import javafx.util.Pair;
import java.util.ArrayList;
import java.text.ParseException;
import java.util.Date;

// Implementation of DataStore as a Binary Record File
//
public class BinaryStore extends DataStore {
	
	// Extended Constructor
	public BinaryStore( String collection ) {
		super( collection );
	}
	
	// Implementation of Insert() method
	public void Insert( ArrayList<Pair<String,String>> keyVals ) 
		throws IllegalArgumentException, StorageException
	{
		schema.checkKeyValArgs( keyVals );
		
		// Seek to the end of the Storage
		End();
		
		// Index the entry for primary key(s)
		long found = Index( keyVals );
		if ( -1 != found ) {
			// move to location in storage of found entry
			Move( found );
			
			// remove it (mark as dirty)
			Write( (byte) 0x00 );

			// Goto end of storage to add updated entry
			End();
		}
		
		// Set dirty flag to clean
		Write( (byte) 0x01 );
			
		// find the column information (type) in schema
		ArrayList<Pair<String,String>> keys = schema.GetKeys();
		
		// Write each key value according to type
		for ( Pair<String,String> keyVal : keyVals ) {
			String key = keyVal.getKey();
		
			// find the column in the schema
			for ( Pair<String,String> col : keys ) {
				if ( key.equals( col.getKey() ) )  {
					// Convert string value into data type
					Object value = null;
					try {
						value = schema.Convert( keyVal );
					}
					catch ( ParseException e ) {
						throw new StorageException( e.getMessage() );
					}
					switch ( col.getValue() ) {
					case "string16" : Write( (String) value, 16  ); break;
					case "string32" : Write( (String) value, 32  ); break;
					case "string64"	: Write( (String) value, 64  ); break;
					case "string128": Write( (String) value, 128 ); break;
					case "short"    : Write( (Short) value ); 		break;
					case "char"		: // Special case, write only lowest 8-bits (octet)
									  char v = (char) value; Write( (byte) v );		
									  break;
					case "integer"  : Write( (Integer) value ); 	break;
					case "long"     : Write( (Long) value ); 		break;
					case "float"    : Write( (Float) value );		break;
					case "double"   : Write( (Double) value );		break;
				    case "date"     : Write( ((Date)value).getTime() ); break;
					case "time"     : Write( ((Date)value).getTime() ); break;
					}
					break;
				}
			}
		}
	}
	
	// Implementation of Update() method
	public void Update( ArrayList<Pair<String,String>> keyVals, Where where ) 
		throws UnsupportedOperationException, IllegalArgumentException
	{
		schema.checkKeyValArgs( keyVals );
		throw new UnsupportedOperationException();
	}
	
	// Implementation of Select() method
	public ArrayList<Data[]> Select( String[] cols, ArrayList<Where> whereList ) 
		throws IllegalArgumentException, StorageException
	{
		int    colOrder[];
		Data[] row;
		
		// Special case, match all columns
		if ( 1 == cols.length && cols[ 0 ].equals( "*" ) )
		{
			ArrayList<Pair<String,String>> keys = schema.GetKeys();
			
			// No Schema
			if ( null == keys ) {
				throw new IllegalArgumentException( "No Schema" );
			}
			
			// allocate array to hold column order
			colOrder = new int[ keys.size() ];
		
			// Allocate first row to hold column names
			row = new Data[ colOrder.length ];
			
			int i = 0;
			for ( Pair<String,String> key : keys ) {
				// Set column order
				colOrder[ i ] = i;
						
				// Set the column name in first row
				row[ i ] = new DataString32(); row[ i++ ].Set( key.getKey() );
			}
		}
		else {
			schema.checkKeyArgs( cols );
			
			// allocate array to hold column order
			colOrder = new int[ cols.length ];
		
			// Allocate first row to hold column names
			row = new Data[ colOrder.length ];
	
			// find the column order from the schema
			for ( int i = 0; i < cols.length; i++ ) {
				// Set column order
				colOrder[ i ] = schema.GetColumnPosition ( cols[ i ] );
					
				// Set the column name in first row
				row[ i ] = new DataString32(); row[ i ].Set( cols[ i ] );		
			}
		}

		// Allocate space for returning result
		ArrayList<Data[]> result = new ArrayList<Data[]>();
		
		// Add first row of column names
		result.add( row );
		
		// Get the key/type schema definition
		ArrayList<Pair<String,String>> keys = schema.GetKeys();
		
		// Go to the beginning of the storage
		Begin();
		
		// Read each record in storage
		//
		int nth = 0;
		while ( !Eof() ) {
			row = new Data[ colOrder.length ];
			int ncol = 0;			// current column position
			
			// First byte indicates if entry is dirty( is dirty == 0x0 )
			byte dirty = ReadByte();
			
			nth++;	// increment the next sequential position of a record (row/document)
			// entry is marked as dirty
			if ( 0x0 == dirty ) {
				// skip to the position of the next entry
				Move( index.Pos( nth ) );
				continue; 
			}
			// Mismatch in data store type
			else if ( 0x01 != dirty )
				throw new StorageException( "Bad entry in storage or not a binary store" );
			
			// Read each column according to data type
			boolean skip = false;
			for ( Pair<String,String> key : keys ) {
				Data value = null;
				switch ( key.getValue() )
				{
					case "string16" : value = new DataString16();  value.Set( ( ( String ) Read( 16 ) ).trim()  );  break;
					case "string32" : value = new DataString32();  value.Set( ( ( String ) Read( 32 ) ).trim() );  break;
					case "string64" : value = new DataString64();  value.Set( ( ( String ) Read( 64 ) ).trim() );  break;
					case "string128": value = new DataString128(); value.Set( ( ( String ) Read( 128 ) ).trim() ); break;
					case "char"		: value = new DataChar();	   value.Set( ( char ) ReadByte() ); break;
					case "short"    : value = new DataShort();     value.Set( ReadShort() ); break;
					case "integer"  : value = new DataInteger();   value.Set( ReadInt() ); break;
					case "long"  	: value = new DataLong();      value.Set( ReadLong() ); break;
					case "float"  	: value = new DataFloat();     value.Set( ReadFloat() ); break;
					case "double"  	: value = new DataDouble();    value.Set( ReadDouble() ); break;
					case "date"  	: value = new DataDate();      value.Set( ReadLong() ); break;
					case "time"  	: value = new DataTime();	   value.Set( ReadLong() ); break;
				}

				// Check where 
				if ( null != whereList ) {

					// Check each where condition (AND)
					for ( Where where : whereList ) {
						// matched key
						if ( key.getKey().equals( where.key ) ) {
							switch ( where.op ) {
							case EQ: 
								if ( !value.EQ( where.value ) ) {
									skip = true; // value not matched
									break;
								}
								break;
							case NE: 
								if ( !value.NE( where.value ) ) {
									skip = true; // value not matched
									break;
								}
								break;
							case LT: 
								if ( !value.LT( where.value ) ) {
									skip = true; // value not matched
									break;
								}
								break;
							case GT: 
								if ( !value.GT( where.value ) ) {
									skip = true; // value not matched
									break;
								}
								break;
							case LE: 
								if ( !value.LE( where.value ) ) {
									skip = true; // value not matched
									break;
								}
								break;
							case GE: 
								if ( !value.GE( where.value ) ) {
									skip = true; // value not matched
									break;
								}
								break;
							}
						}
						
						// none match already found
						if ( true == skip )
							break;
					}
					// TODO: should jump to next row on skip (unmatched where), but needs an index always
				}

				// add to row result in correct order if part of result
				for ( int i = 0; i < colOrder.length; i++ ) {
					if ( colOrder[ i ] == ncol ) {
						row[ i ] = value;
						break;
					}
				}
				
				ncol++;	// increment the column position
			}
			
			// did not match where clause
			if ( true == skip ) {
				continue;
			}
			
			// Add the row to the result
			result.add( row );
		}
		
		return result;
	}
	
	// Implementation of Delete() method
	public void Delete( Where where ) 
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException();
	}
	
	// Implementation of Vacuum() method
	public void Vacuum() 
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException();
	}
	
}