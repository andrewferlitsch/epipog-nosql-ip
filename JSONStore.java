import javafx.util.Pair;
import java.util.ArrayList;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;

// Implementation of DataStore as a JSON File
//
public class JSONStore extends DataStore {
	// Extended Constructor
	public JSONStore( String collection ) {
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
			
			// remove it
			Write( "{\"#" );

			// Goto end of storage to add updated entry
			End();
		}
		
		// Write each key value to storage
		Write( (byte) '{' );
		for ( Pair<String,String> keyVal : keyVals ) {
			// Write Key
			String key = keyVal.getKey();
			Write( (byte) '"' );
			Write( key );
			Write( (byte) '"' );
			Write( (byte) ':' );
			
			// Write Value
			String val = keyVal.getValue();
			Write( (byte) '"' );
			Write( val );
			Write( (byte) '"' );
			Write( (byte) ',' );
		}
		
		Move( Pos() - 1 );	// remove trailing comma
		Write( "}\r\n" );
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
				colOrder[ i ] = schema.GetColumnPosition( cols[ i ] );
					
				// Set the column name in first row
				row[ i ] = new DataString32(); row[ i ].Set( cols[ i ] );	
			}
		}
		
		// Allocate space for returning result
		ArrayList<Data[]> result = new ArrayList<Data[]>();
		
		// Add first row of column names
		result.add( row );
		
		// Get key/type pairs from the schema definition
		ArrayList<Pair<String,String>> keys = schema.GetKeys();
		
		// Go to the beginning of the storage
		Begin();
		
		// Read each pipe-separated line from storage
		String line;
		int nth = 0;
		while ( null != ( line = ReadLine() ) ) {
			row = new Data[ colOrder.length ];
			String first = null;	// first column in record
			int ncol = 0;			// current column position
			
			// Split the line into columns
			ArrayList<String> vl = SVParse.Split( line, ',' );
			String[] values = vl.toArray( new String[ vl.size() ] );
			
			nth++; // increment the next sequential position of a record (row/document)
			boolean skip = false;
			for ( int j = 0; j < values.length; j++ ) {
				// Check if entry has been marked as dirty ({"#)
				if ( null == first ) {
					first = values[ j ];
					
					values[ j ] = values[ j ].substring( 1 );	// drop leading { 
				}
				// Last column
				else if ( j == values.length - 1 ) {
					values[ j ] = values[ j ].substring( 0, values[ j ].length() - 1 );	// drop trailing }
				}
				
				// add to row result in correct order if part of result
				
				if ( false == first.startsWith( "{#" ) ) {
					// split entry into id and value
					String[] pair = values[ j ].split( ":" );
				
					// Make corrections if colon in value field
					if ( pair.length > 2 ) {
						for ( int i = 2; i < pair.length; i++ )
							pair[ 1 ] += ":" + pair[ i ];
					}

					for ( int i = 0; i < colOrder.length; i++ ) {
						if ( colOrder[ i ] == ncol ) {
							try {
								values[ j ] = pair[ 1 ].replace( "\"", "" );	// remove enclosing double quotes
				
								// Convert according to data type in schema
								switch ( keys.get( ncol ).getValue() )
								{
									case "string16" : row[ i ] = new DataString16();	row[ i ].Set( values[ j ] ); break;
									case "string32" : row[ i ] = new DataString32();	row[ i ].Set( values[ j ] ); break;
									case "string64" : row[ i ] = new DataString64();	row[ i ].Set( values[ j ] ); break;
									case "string128": row[ i ] = new DataString128();	row[ i ].Set( values[ j ] ); break;
									case "byte"		: row[ i ] = new DataByte();		row[ i ].Set( Byte.parseByte( values[ j ] ) ); break;
									case "short"	: row[ i ] = new DataShort();   	row[ i ].Set( Short.parseShort( values[ j ] ) ); break;
									case "integer"	: row[ i ] = new DataInteger(); 	row[ i ].Set( Integer.parseInt( values[ j ] ) ); break;
									case "long"		: row[ i ] = new DataLong();		row[ i ].Set( Long.parseLong( values[ j ] ) ); break;
									case "float"	: row[ i ] = new DataFloat();		row[ i ].Set( Float.parseFloat( values[ j ] ) ); break;
									case "double"	: row[ i ] = new DataDouble(); 		row[ i ].Set( Double.parseDouble( values[ j ] ) ); break;
									case "date"		: row[ i ] = new DataDate();		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
																						row[ i ].Set( format.parse( values[ j ] ).getTime() ); break;
									case "time"		: row[ i ] = new DataTime();		format = new SimpleDateFormat("HH:ss");
																						row[ i ].Set( format.parse( values[ j ] ).getTime() ); break; 
								}
							}
							catch ( ParseException e ) {
								throw new StorageException( e.getMessage() );
							}
							
							// Check where 
							if ( null != whereList ) {
								
								// Check each where condition (AND)
								for ( Where where : whereList ) {
									// matched key
									if ( keys.get( ncol ).getKey().equals( where.key ) ) {
										switch ( where.op ) {
										case EQ: 
											if ( !row[ i ].EQ( where.value ) ) {
												skip = true; // value not matched
												break;
											}
											break;
										case NE: 
											if ( !row[ i ].NE( where.value ) ) {
												skip = true; // value not matched
												break;
											}
											break;
										case LT: 
											if ( !row[ i ].LT( where.value ) ) {
												skip = true; // value not matched
												break;
											}
											break;
										case GT: 
											if ( !row[ i ].GT( where.value ) ) {
												skip = true; // value not matched
												break;
											}
											break;
										case LE: 
											if ( !row[ i ].LE( where.value ) ) {
												skip = true; // value not matched
												break;
											}
											break;
										case GE: 
											if ( !row[ i ].GE( where.value ) ) {
												skip = true; // value not matched
												break;
											}
											break;
										}
									}
								}
								
								// none match already found
								if ( true == skip )
									break;
								
								// TODO: should jump to next row on skip (unmatched where), but needs an index always
							}
							break;
						}
					}
				}
				// entry is marked as dirty
				else
				{
					// skip to the position of the next entry
					Move( index.Pos( nth ) );
					continue; 
				}

				ncol++;	// increment the column position
			}
			
			// did not match where clause
			if ( true == skip ) {
				continue;
			}
			
			// entry is marked as dirty
			if ( first.startsWith( "{#" ) )
				continue;
		
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