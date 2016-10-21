import java.util.ArrayList;
import javafx.util.Pair;

// Abstract Layer for Accessing Physical Storage of Data
//
public abstract class Storage {
	// Root for Storage: Hardcoded for demo purposes only (can be further abstracted)
	protected final String storageRoot = "/tmp/";
	
	protected String collection = null;	// name of the collection (file) in storage
	
	public Storage( String _collection ) throws IllegalArgumentException
	{
		if ( null == _collection )
			throw new IllegalArgumentException( "collection is null" );
		collection = _collection;
	}
	
	// Method for opening (connecting) to storage
	public abstract void Open() throws StorageException;
	
	// Method for closing (disconnecting) from storage
	public abstract void Close() throws StorageException;
	
	// Method to seek to the begin of the storage
	public abstract void Begin() throws StorageException;
	
	// Method to seek to the end of the storage
	public abstract void End() throws StorageException;
	
	// Method to return the current location in storage
	public abstract long Pos() throws StorageException;
	
	// Method to move to a location in storage
	public abstract void Move( long pos ) throws StorageException;
	
	// Method to check for at end of file in storage
	public abstract boolean Eof() throws StorageException;
	
	// Method to write a padded string to the storage
	public abstract void Write( String value, int length ) throws StorageException;
		
	// Method to write a string to the storage
	public abstract void Write( String value ) throws StorageException;
	
	// Method to write a byte to the storage
	public abstract void Write( byte value ) throws StorageException;

	// Method to write a short to the storage
	public abstract void Write( Short value ) throws StorageException;

	// Method to write an integer to the storage
	public abstract void Write( Integer value ) throws StorageException;
	
	// Method to write a long to the storage
	public abstract void Write( Long value ) throws StorageException;
	
	// Method to write a float to the storage
	public abstract void Write( Float value ) throws StorageException;
	
	// Method to write a double to the storage
	public abstract void Write( Double value ) throws StorageException;
	
	// Method to write a boolean to the storage
	public abstract void Write( Boolean value ) throws StorageException;
	
	// Method to write a line to storage
	public abstract void WriteLine( String value ) throws StorageException;
	
	// Method to Read a String from storage
	public abstract String Read( int length ) throws StorageException;
	
	// Method to Read a byte from storage
	public abstract byte ReadByte() throws StorageException;
	
	// Method to Read a short from storage
	public abstract Short ReadShort() throws StorageException;
	
	// Method to Read an Integer from storage
	public abstract Integer ReadInt() throws StorageException;
	
	// Method to Read a Long from storage
	public abstract Long ReadLong() throws StorageException;
	
	// Method to Read a float from storage
	public abstract float ReadFloat() throws StorageException;
	
	// Method to Read a double from storage
	public abstract double ReadDouble() throws StorageException;
	
	// Method to Read a boolean from storage
	public abstract Boolean ReadBoolean() throws StorageException;
	
	// Method to Read a line from storage
	public abstract String ReadLine() throws StorageException;
	
	// Method to Write out index to storage
	public abstract void Write( Index index ) throws StorageException;
	
	// Method to Read in index from storage
	public abstract ArrayList<long[]> ReadIndex() throws StorageException;
	
	// Method to Write out schema to storage
	public abstract void Write( Schema schema ) throws StorageException;
	
	// Method to Read in schema from storage
	public abstract ArrayList<Pair<String,String>> ReadSchema() throws StorageException;
}