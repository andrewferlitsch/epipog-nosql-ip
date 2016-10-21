import javafx.util.Pair;
import java.util.ArrayList;
import java.util.List;
import java.io.*;

// Abstract Layer for parsing input data with character separator
public abstract class SVParse extends Parse {
	// Constructor & Initializer
	//	inputFile:	path to inputFile
	//	dataStore:	data store to insert into
	//	separator:  character delimiter
	public SVParse( String _inputFile, DataStore _dataStore, boolean _noHeader, char _separator ) {
		super( _inputFile, _dataStore, _noHeader );
		separator = _separator;
	}
	
	private char separator = ( char ) 0;	// Separator character sequence
	
	// Implementation for parsing character delimited file
	public void Parse() 
		throws StorageException
	{
		ArrayList<String> heading 			   = null;		// CSV headings
		boolean  header  					   = !noHeader;	// expect heading in input
		int hlen = 0;										// number of headings
		ArrayList<Pair<String,String>> keyVals = null; 		// row of parsed key/val pairs

		ArrayList<Pair<String,String>> keys = dataStore.GetKeys();
		if ( null == keys )
			throw new StorageException( "No schema" );
		
		// no header in input, get headings from the schema
		if ( true == noHeader ) {
			heading = new ArrayList<String>();
			for ( Pair<String,String> key : keys )
				heading.add( key.getKey() );
			hlen = heading.size();
		}

		int len  = lines.size();	// number of lines
		for ( int i = 0; i < len; i++ ) {
			// heading
			if ( true == header ) {
				heading = Split( lines.get( i ), separator );
				
				// store the headings in lowercase, and remove leading/trailing whitespace
				hlen = heading.size();
				for ( int j = 0; j < hlen; j++ )
					heading.set( j, heading.get( j ).trim().toLowerCase() );
				
				header = false;
				continue;
			}
			
			// Allocate a list of key/value pairs for each row
			keyVals = new ArrayList<Pair<String,String>>(); 
				
			// Spit the line
			ArrayList<String> cols = Split( lines.get( i ), separator );
			int clen = cols.size();
			
			if ( hlen != keys.size() ) {
				throw new StorageException( "Number of columns in header incorrect" );
			}
			
			if ( clen != hlen ) {
				throw new StorageException( "Number of columns in row incorrect" );
			}
			
			for ( int j = 0; j < clen; j++ ) {
				String value = cols.get( j );
				try {
					switch ( keys.get( j ).getValue() ) {
					case "string16"	: if ( value.length() > 16 )
										throw new StorageException( "Value too long for string16 data type: " + value );
									  break;
					case "string32"	: if ( value.length() > 32 )
										throw new StorageException( "Value too long for string32 data type: " + value );
									  break;
					case "string64"	: if ( value.length() > 64 )
										throw new StorageException( "Value too long for string64 data type: " + value );
									  break;
					case "string128": if ( value.length() > 128 )
										throw new StorageException( "Value too long for string128 data type: " + value );
									  break;
					case "char"		: if ( value.length() > 1 )
										throw new StorageException( "Value too long for char data type: " + value );
									  break;
					case "short"   	: if ( value.startsWith( "0x" ) || value.startsWith( "0X") )
										value = String.valueOf( Short.parseShort( value.substring( 2 ), 16 ) );
									  else
										Short.parseShort( value );
									  break;
					case "integer" 	: if ( value.startsWith( "0x" ) || value.startsWith( "0X") )
										value = String.valueOf( Integer.parseInt( value.substring( 2 ), 16 ) );
									  else
										Integer.parseInt( value );
									  break;
					case "long"    	: if ( value.startsWith( "0x" ) || value.startsWith( "0X") )
										value = String.valueOf( Long.parseLong( value.substring( 2 ), 16 ) );
									  else
										Long.parseLong( value );
									  break;
					case "float"	: Float.parseFloat( value ); break;
					case "double"	: Double.parseDouble( value ); break;
					case "date"		: if ( value.length() == 10 ) {
										if ( ( value.charAt( 0 ) == '1' || value.charAt( 0 ) == '2' ) &&
											 ( value.charAt( 1 ) >= '0' && value.charAt( 1 ) <= '9' ) &&
											 ( value.charAt( 2 ) >= '0' && value.charAt( 2 ) <= '9' ) &&
											 ( value.charAt( 3 ) >= '0' && value.charAt( 3 ) <= '9' ) &&
											 value.charAt( 4 ) == '-' &&
											 ( value.charAt( 5 ) == '0' || value.charAt( 5 ) == '1' ) &&
											 ( value.charAt( 6 ) >= '0' && value.charAt( 6 ) <= '9' ) &&
											 value.charAt( 7 ) == '-' &&
											 ( value.charAt( 8 ) >= '0' && value.charAt( 8 ) <= '9' ) &&
											 ( value.charAt( 9 ) >= '0' && value.charAt( 9 ) <= '9' ) )
												break;
									  }
									  throw new StorageException( "Incorrect value for date data type: " + value );
					case "time"		: if ( value.length() == 5 ) {
										if ( ( value.charAt( 0 ) == '0' || value.charAt( 0 ) == '1' ) &&
											 ( value.charAt( 1 ) >= '0' && value.charAt( 1 ) <= '9' ) &&
											 value.charAt( 2 ) == ':' &&
											 ( value.charAt( 3 ) >= '0' && value.charAt( 3 ) <= '9' ) &&
											 ( value.charAt( 4 ) >= '0' && value.charAt( 4 ) <= '9' ) )
												break;
									  }
									  throw new StorageException( "Incorrect value for time data type: " + value );
					}
				}
				catch ( NumberFormatException e ) {
					throw new StorageException( "Incorrect value for data type: " + value );
				}
				keyVals.add( new Pair<String,String>( heading.get( j ), value ) );
			}
				
			// insert row in data store
			dataStore.Insert( keyVals );
		}
	}
	
	// Split a character sequence separated line
	//	line : line to split
	//	separator : delimiter
	public static ArrayList<String> Split( String line, char separator ) {

        ArrayList<String> result = new ArrayList<>();

        //if empty, return!
        if ( line == null && line.isEmpty() ) {
            return result;
        }

		boolean inQuotes    = false;
        StringBuffer curVal = new StringBuffer();
		char[] chars 		= line.toCharArray();

        for ( char ch : chars ) {
			// separator found and not in quotes
			if ( ch == separator && !inQuotes ) {
                result.add( curVal.toString().trim() );
                curVal = new StringBuffer();
			}
			// quote found
			else if ( ch == '"' ) {
				inQuotes = !inQuotes;
			}
			// everything else
			else
				curVal.append( ch );
		}

        result.add( curVal.toString().trim() );

        return result;
	}
}