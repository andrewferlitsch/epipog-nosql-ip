import java.util.ArrayList;
import javafx.util.Pair;

// Implementation for Accessing Physical Storage of Data across multiple files
//
public class MultiFileStorage extends Storage {

	// Constructor: initialize name of collection in storage
	MultiFileStorage( String collection )
	{
		super( collection );
	}

	// Implementation for opening (connecting) to storage
	public void Open()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Open" );
	}
	
	// Implementation for closing (disconnecting) from storage
	public void Close()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Close" );
	}
	
	// Implementation for seeking to the begin in storage
	public void Begin()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Begin" );
	}
	
	// Implementation for seeking to the end in storage
	public void End()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.End" );
	}
	
	// Implementation for returning current location in storage
	public long Pos() 
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Pos" );
	}
	
	// Implementation for moving to a location in storage
	public void Move( long pos ) 
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Move" );
	}
	
	// Implementation for checking if at end of file in storage
	public boolean Eof() 
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Eof" );
	}
	
	// Implementation for writing a padded String to storage
	public void Write( String value, int length )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.string" );
	}
	
	// Implementation for writing a String to storage
	public void Write( String value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.string" );
	}
	
	// Implementation for writing a byte to storage
	public void Write( byte value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.byte" );
	}
	
	// Implementation for writing a short to storage
	public void Write( Short value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.short" );
	}
	
	// Implementation for writing an Integer to storage
	public void Write( Integer value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.integer" );
	}
	
	// Implementation for writing a Long Integer to storage
	public void Write( Long value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.long" );
	}
	
	// Implementation for writing a Float to storage
	public void Write( Float value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.float" );
	}
	
	// Implementation for writing a Double to storage
	public void Write( Double value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.double" );
	}
	
	// Implementation for writing a Boolean to storage
	public void Write( Boolean value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.boolean" );
	}
	
	// Implementation for writing a line to storage
	public void WriteLine( String value )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.line" );
	}
	
	// Implementation for writing an index to storage
	public void Write( Index index )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Write.index" );
	}
	
	// Implementation for reading a string from storage
	public String Read( int length )
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.string" );
	}
	
	// Implementation for reading a byte from storage
	public byte ReadByte()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.byte" );
	}
	
	// Implementation for reading an Integer from storage
	public Integer ReadInt()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.integer" );
	}
	
	// Implementation for reading a Short from storage
	public Short ReadShort()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.short" );
	}
	
	// Implementation for reading a Long from storage
	public Long ReadLong()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.long" );
	}
	
	// Implementation for reading a float from storage
	public float ReadFloat()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.float" );
	}
	
	// Implementation for reading a double from storage
	public double ReadDouble()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.double" );
	}
	
	// Implementation for reading a boolean from storage
	public Boolean ReadBoolean()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.boolean" );
	}
	
	// Implementation for reading a line from storage
	public String ReadLine()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.line" );
	}

	// Implementation for reading an index from storage
	public ArrayList<long[]> ReadIndex()
		throws UnsupportedOperationException	
	{
		throw new UnsupportedOperationException( "MultiFileStorage.Read.index" );
	}

	// Implementation to Write out schema to storage
	public void Write( Schema schema ) 
		throws UnsupportedOperationException
	{
			throw new UnsupportedOperationException( "MultiFileStorage.Write.schema" );
	}
	
	// Implementation to Read in schema from storage
	public ArrayList<Pair<String,String>> ReadSchema() 
		throws UnsupportedOperationException
	{	
			throw new UnsupportedOperationException( "MultiFileStorage.Write.read" );
	}
}