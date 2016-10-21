import javafx.util.Pair;
import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.text.ParseException;

// Implementation Layer for Dynamic Schemas
//
public class Schema {
	
	// Constructor
	public Schema( String _collectionName ) {
		collectionName = _collectionName;
	}
	
	private ArrayList<Pair<String,String>> keys = null;	// dynamic schema 
	private String collectionName = null;				// name of the collection
	
	// Method for dynamically specifying the schema
	// Pair =
	//	L = Field Name
	//	R = Field Type ( String, Integer, Long, Float, Double, Date, Time )
	public void Schema( ArrayList<Pair<String,String>> _keys ) 
		throws IllegalArgumentException
	{
		if ( null == _keys )
			throw new IllegalArgumentException( "Schema: Keys is null" );

		keys  = _keys;
		
		// Check that keys data types are valid
		int len = keys.size();
		for ( int i = 0; i < len; i++ ) {
			// Look for duplicate keys in schema
			for ( int j = i + 1; j < len; j++ ) {
				if ( keys.get( i ).getKey().equals( keys.get( j ).getKey() ) ) {
					throw new IllegalArgumentException( "Schema: key is defined more than once: " + keys.get( i ).getKey() );
				}
			}
			switch ( keys.get( i ).getValue() ) {
				case "string16"	:
				case "string32"	:
				case "string64"	:
				case "string128":
				case "char"		:
				case "short"	:
				case "integer"	:
				case "long"		:
				case "float"	:
				case "double"	:
				case "date"		:
				case "time"		: break;
				default: throw new IllegalArgumentException( "Schema: key has invalid data type (-S): " + keys.get( i ).getValue() );
			}
		}
	}

	// Accessor function to get the key/type pairs from the schema
	public ArrayList<Pair<String,String>> GetKeys() {
		return keys;
	}
	
	// Method to check that keys arguments are valid
	public void checkKeyArgs( String[] mykeys ) 
		throws IllegalArgumentException
	{	
		if ( null == mykeys )
			throw new IllegalArgumentException( "Keys is null" );
		if ( 0 == mykeys.length )
			throw new IllegalArgumentException( "Keys is empty" );	
		if ( null == keys )
			throw new IllegalArgumentException( "No schema" );

		// Check key name is in the schema
		for ( int i = 0; i < mykeys.length; i++ ) {
			boolean matched = false;
			for ( Pair<String,String> key : keys ) {
				if ( mykeys[ i ].equals( key.getKey() ) ) {
					matched = true;
					break;
				}
			}
			if ( false == matched )
				throw new IllegalArgumentException( "Key not found: " + mykeys[ i ] );
		}
	}
	
	// Method to check that keyVal arguments are valid
	public void checkKeyValArgs( ArrayList<Pair<String,String>> keyVals ) 
		throws IllegalArgumentException
	{
		if ( null == keyVals )
			throw new IllegalArgumentException( "KeyVals is null" );
		if ( null == keys )
			throw new IllegalArgumentException( "No schema" );

		// Check key name is in the schema
		for ( Pair<String,String> keyVal : keyVals ) {
			boolean matched = false;
			for ( Pair<String,String> key : keys ) {
				if ( keyVal.getKey().equals( key.getKey() ) ) {
					matched = true;
					break;
				}
			}
			if ( false == matched )
				throw new IllegalArgumentException( "Key not found: " + keyVal.getKey() );
		}
	}
			
	// Method for converting a value of a key-value from String
	// representation to internal datastore data type
	protected Object Convert( Pair<String,String> keyVal ) 
		throws NumberFormatException, ParseException 
	{
		for ( Pair<String,String> key : keys ) {
			// Look for field name in keyval in the schema (keys)
			if ( key.getKey().equals( keyVal.getKey() ) )  {
				// Cast the value in keyval according to the type
				// in the matching schema
				String value = keyVal.getValue();
				switch ( key.getValue().toLowerCase() ) {
					case "string16" :
					case "string32" :
					case "string64" :
					case "string128": return value;
					case "char"		: return value.charAt( 0 );
					case "short"	: return Short.parseShort( value );
					case "integer"  : return Integer.parseInt( value );
					case "long"		: return Long.parseLong( value );
					case "float"	: return Float.parseFloat( value );
					case "double"	: return Double.parseDouble( value );
					case "date"		: DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									  return format.parse( value );
					case "time"		: format = new SimpleDateFormat("HH:ss");
									  return format.parse( value );
				}
			}
		}
		return null;	// should never happen
	}
	
	// Get data type of a string
	public String GetType( String col ) 
		throws IllegalArgumentException
	{
		if ( null == keys )
			throw new IllegalArgumentException( "No Schema" );
			
		for ( Pair<String,String> key : keys ) {
			// Look for key in the schema (keys)
			if ( key.getKey().equals( col ) )  {
				return key.getValue();
			}
		}
		
		return null;	// should never happen
	}	
	
	// Get the column position in the schema
	protected Integer GetColumnPosition( String col ) {
		
		int ix = 0;
		for ( Pair<String,String> key : keys ) {
			// Look for key in the schema (keys)
			if ( key.getKey().equals( col ) )  
				return ix;
			ix++;
		}
		
		return -1; // not found
	}
}