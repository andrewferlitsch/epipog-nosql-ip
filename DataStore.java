import javafx.util.Pair;
import java.util.ArrayList;

// Abstract Layer for Accessing DataStore
//
public abstract class DataStore { 
	protected String collectionName = null;	// name of the data collection group
	protected Schema schema;				// the dynamic schema definition for the collection	
	protected String[] primary = null;		// dynamic primary key(s) definition

	private   Storage storage = null;		// data storage 
	private   Index index = null;			// index of primary key(s)
	
	// Constructor
	public DataStore( String _collectionName )
	{
		collectionName = _collectionName;	
		
		// Construct the schema object
		schema = new Schema( collectionName );
	}

	// Set Storage Type
	public void Storage ( String type ) 
		throws StorageException
	{
		switch ( type.toLowerCase() ) {
			case "single": storage = new SingleFileStorage( collectionName );
						   break;
			case "multi" : storage = new MultiFileStorage( collectionName );
						   break;
			default		 : throw new StorageException( "Invalid argument for storage type (-t): " + type );
		}
	}
	
	// Open the storage 
	public void Open()
		throws StorageException
	{
		if ( null != storage ) {
			// open the data store
			storage.Open();
		
			// read in the index
			ArrayList<long[]> entries = storage.ReadIndex();
			if ( entries != null ) {
				for ( long[] entry : entries ) {
					index.Add( entry[ 0 ], entry[ 1 ] );
				}
			}
			
			// No schema has been specified
			if ( schema.GetKeys() == null ) {
				// Read in the schema
				ArrayList<Pair<String,String>> keys = storage.ReadSchema();
				if ( keys != null )
					schema.Schema( keys );
			}
		}
	}
	
	// Close the storage 
	public void Close()
		throws StorageException
	{
		if ( null != storage ) {
			// close the data store
			storage.Close();
			
			// write out the index
			storage.Write( index );
			
			// write out the schema
			storage.Write( schema );
		}
	}
	
	// Seek to the begin of the storage 
	public void Begin()
		throws StorageException
	{
		if ( null != storage )
			storage.Begin();
	}
	
	// Seek to the end of the storage 
	public void End()
		throws StorageException
	{
		if ( null != storage )
			storage.End();
	}
	
	// Seek to a location in the storage 
	public void Move( long pos )
		throws StorageException
	{
		if ( null != storage )
			storage.Move( pos );
	}
	
	// Get current position storage 
	public long Pos()
		throws StorageException
	{
		if ( null != storage )
			return storage.Pos();
		return -1;
	}
	
	// Check if at the end of file
	public boolean Eof()
		throws StorageException
	{
		if ( null != storage )
			return storage.Eof();
		return false;
	}
	
	// Write a padded string to storage
	public void Write( String value, int length )
		throws StorageException
	{
		if ( null != storage )
			storage.Write( value, length );
	}
	
	// Write a string 
	public void Write( String value )
		throws StorageException
	{
		if ( null != storage )
			storage.Write( value );
	}
	
	// Write a byte 
	public void Write( byte value )
		throws StorageException
	{
		if ( null != storage )
			storage.Write( value );
	}
	
	// Write a short to storage
	public void Write( short value )
		throws StorageException
	{
		if ( null != storage )
			storage.Write( value );
	}
	
	// Write an integer to storage
	public void Write( int value )
		throws StorageException
	{
		if ( null != storage )
			storage.Write( value );
	}
	
	// Write a long to storage
	public void Write( long value )
		throws StorageException
	{
		if ( null != storage )
			storage.Write( value );
	}
	
	// Write a float to storage
	public void Write( float value )
		throws StorageException
	{
		if ( null != storage )
			storage.Write( value );
	}
	
	// Write a double to storage
	public void Write( double value )
		throws StorageException
	{
		if ( null != storage )
			storage.Write( value );
	}
	
	// Read string from storage
	public String Read( int length )
		throws StorageException
	{
		if ( null != storage )
			return storage.Read( length );
		return null;
	}
	
	// Read byte from storage
	public byte ReadByte()
		throws StorageException
	{
		if ( null != storage )
			return storage.ReadByte();
		return -1;
	}
	
	// Read short from storage
	public Short ReadShort()
		throws StorageException
	{
		if ( null != storage )
			return storage.ReadShort();
		return -1;
	}
	
	// Read integer from storage
	public Integer ReadInt()
		throws StorageException
	{
		if ( null != storage )
			return storage.ReadInt();
		return -1;
	}
	
	// Read long from storage
	public Long ReadLong()
		throws StorageException
	{
		if ( null != storage )
			return storage.ReadLong();
		return -1L;
	}
	
	// Read float from storage
	public float ReadFloat()
		throws StorageException
	{
		if ( null != storage )
			return storage.ReadFloat();
		return -1;
	}
	
	// Read double from storage
	public double ReadDouble()
		throws StorageException
	{
		if ( null != storage )
			return storage.ReadDouble();
		return -1;
	}
	
	// Read a line from storage
	public String ReadLine() 
		throws StorageException
	{
		if ( null != storage )
			return storage.ReadLine();
		return null;
	}
	
		
	// Method for dynamically specifying the primary keys
	public void Primary( String[] _primary ) 
		throws IllegalArgumentException
	{
		schema.checkKeyArgs( _primary );
		
		primary  = _primary;
		
		// No primary key
		if ( null == primary )
			return;
	}
	
	// Set the dynamic schema definition
	public void Schema( ArrayList<Pair<String,String>> keys )
	{
		schema.Schema( keys );
	}
	
	// Method to check that keyVal arguments are valid
	public void checkKeyValArgs( ArrayList<Pair<String,String>> keyVals ) 
		throws IllegalArgumentException
	{
		schema.checkKeyValArgs( keyVals );
	}
	
	// Method to check that key arguments are valid
	public void checkKeyArgs( String[] myKeys ) 
		throws IllegalArgumentException
	{
		schema.checkKeyArgs( myKeys );
	}
	
	// Accessor Method: get keys from the schema
	public ArrayList<Pair<String,String>> GetKeys()
	{
		return schema.GetKeys();
	}
 
	// Set Index Type
	public void Index ( String type ) 
		throws StorageException
	{
		switch ( type.toLowerCase() ) {
			case "linked": index = new LinkedIndex( collectionName );
						   break;
			case "binary": index = new BinaryTreeIndex( collectionName );
						   break;
			default		 : throw new StorageException( "Invalid argument for index type (-I): " + type );
		}
	}
	
	// Add entry to index
	// Return
	//	-1 : new entry (not found)
	//	not -1 : position of found entry
	public long Index( ArrayList<Pair<String,String>> keyVals )
		throws StorageException
	{
		// no primary key
		if ( null == primary )
			return -1;
		
		// Look for entries that are part of the primary key combination
		String value = "";	// value accumulator
		for ( String index : primary ) {
			for ( Pair<String,String> keyVal : keyVals ) {
				if ( index.equals( keyVal.getKey() ) ) {
					// Hash the value for primary key field 
					value = value.concat( keyVal.getValue() );
					break;
				}
			}
		}

		// Create hash code for entry to add to index
		long hash = value.hashCode();
		// Get position in storage for this entry
		
		long pos  = storage.Pos();
	
		// Add entry to Index
		return index.Add( hash, pos );
	}
	
	// Method for inserting into datastore
	// keyvals:
	//	L = Name of Key that matches schema
	//	R = Value in String Representation
	public abstract void Insert( ArrayList<Pair<String,String>> keyVals ) throws StorageException;
	
	// Method for updating the datastore
	// keyvals:
	//	L = Name of Key that matches schema
	//	R = Value in String Representation	
	//	where: where clause for matching records
	public abstract void Update( ArrayList<Pair<String,String>> keyVals, Where where );
	
	// Method for deleting from datastore	
	//	where: where clause for matching records
	public abstract void Delete( Where where );
	
	// Method for selecting rows from datastore
	//	keys: keys to selecting
	//	where: where clause for matching records
	public abstract ArrayList<Data[]> Select( String[] keys, Where where ) throws IllegalArgumentException, StorageException;		

	public abstract class Where {
		
	}
	
	// Method for sorting results
	public void OrderBy() {}
	
	// Method for vacuuming a collection
	public abstract void Vacuum();
}

