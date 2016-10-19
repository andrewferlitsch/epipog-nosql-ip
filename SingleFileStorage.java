import java.io.RandomAccessFile;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Arrays;
import java.util.ArrayList;
import javafx.util.Pair;
import java.io.File;
import java.io.UnsupportedEncodingException;

// Implementation for Accessing Physical Storage of Data as Single File
//
public class SingleFileStorage extends Storage {
	
	// Constructor: initialize name of collection in storage
	SingleFileStorage( String collection )
	{
		super( collection );
	}
	
	private RandomAccessFile fd = null;		// file pointer for data storage file

	// Implementation for opening (connecting) to storage
	public void Open() 
		throws StorageException
	{
		String data = storageRoot + collection + ".dat";
		
		try
		{
			fd = new RandomAccessFile( data, "rw" );
		}
		catch ( FileNotFoundException e ) {
			throw new StorageException( "Storage File not Found: " + data );
		}
	}
	
	// Implementation for closing (disconnecting) from storage
	public void Close()  
		throws StorageException
	{
		try {
			fd.close();
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot close storage file" );
		}
	}
	
	// Implementation for seeking to the begin of the storage
	public void Begin() 
		throws StorageException
	{
		try {
			fd.seek( 0 );
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot seek in storage file" );
		}
	}
	
	// Implementation for seeking to the end of the storage
	public void End() 
		throws StorageException
	{
		try {
			fd.seek( fd.length() );
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot seek in storage file" );
		}
	}
	
	// Implementation for returning current location in storage
	public long Pos() 
		throws StorageException
	{
		try {
			return fd.getFilePointer();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot get file location in storage file" );
		}
	}
	
	// Implementation for moving to a location in storage
	public void Move( long pos )
		throws StorageException
	{
		try {
			fd.seek( pos );
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot seek in storage file" );
		}
	}
	
	// Implementation for checking if at the end of the file in storage
	public boolean Eof() 
		throws StorageException
	{
		try {
			if ( fd.getFilePointer() >= fd.length() - 1 )
				return true;
		} 
		catch ( IOException e )
		{
			throw new StorageException( "Cannot get location in storage file" );
		}
		
		return false;
	}
	
	// Implementation for writing a fixed length string to storage
	public void Write( String value, int length ) 
		throws StorageException
	{
		try {
			byte[] bytes = value.getBytes();
			byte[] out   = Arrays.copyOf( bytes, length );
			fd.write( out, 0, length );	
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot write to storage file" );
		}
	}
	
	// Implementation for writing a string to storage
	public void Write( String value ) 
		throws StorageException
	{
		try {
			byte[] bytes = value.getBytes();
			fd.write( bytes, 0, bytes.length );	
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot write to storage file" );
		}
	}
	
	// Implementation for writing a byte to storage
	public void Write( byte value ) 
		throws StorageException
	{
		try {
			fd.write( value );	
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot write to storage file" );
		}
	}
	
	// Implementation for writing a short storage
	public void Write( Short value ) 
		throws StorageException
	{
		try {
			fd.writeShort( value );	
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot write to storage file" );
		}
	}
	
	// Implementation for writing an integer storage
	public void Write( Integer value ) 
		throws StorageException
	{
		try {
			fd.writeInt( value );	
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot write to storage file" );
		}
	}
	
	// Implementation for writing a long integer storage
	public void Write( Long value ) 
		throws StorageException
	{
		try {
			fd.writeLong( value );	
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot write to storage file" );
		}
	}
	
	// Implementation for writing a long integer storage
	public void Write( Float value ) 
		throws StorageException
	{
		try {
			fd.writeFloat( value );	
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot write to storage file" );
		}
	}
	
	// Implementation for writing a double storage
	public void Write( Double value ) 
		throws StorageException
	{
		try {
			fd.writeDouble( value );	
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot write to storage file" );
		}
	}
	
	// Implementation for writing a line to storage
	public void WriteLine( String value ) 
		throws StorageException
	{
		Write( value + "\r\n" );	
	}
	
	// Implementation for reading a string from storage
	public String Read( int length )
		throws StorageException	
	{
		byte[] bytes = null;
		try {
			bytes = new byte[ length ];
			fd.read( bytes );
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from storage file" );
		}
		try
		{
			return new String( bytes, "UTF-8" );
		}
		catch ( UnsupportedEncodingException e ) {
			return null;
		}
	}
	
	// Implementation for reading a byte from storage
	public byte ReadByte() 
		throws StorageException	
	{
		try {
			return fd.readByte();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from storage file" );
		}
	}
	
	// Implementation for reading a Short from storage
	public Short ReadShort() 
		throws StorageException	
	{
		try {
			return fd.readShort();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from storage file" );
		}
	}
	
	// Implementation for reading an integer from storage
	public Integer ReadInt() 
		throws StorageException	
	{
		try {
			return fd.readInt();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from storage file" );
		}
	}
	
	// Implementation for reading a long from storage
	public Long ReadLong() 
		throws StorageException	
	{
		try {
			return fd.readLong();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from storage file" );
		}
	}
	
	// Implementation for reading a float from storage
	public float ReadFloat()
		throws StorageException	
	{
		try {
			return fd.readFloat();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from storage file" );
		}
	}
	
	// Implementation for reading a double from storage
	public double ReadDouble()
		throws StorageException	
	{
		try {
			return fd.readDouble();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from storage file" );
		}
	}
	
	// Implementation for reading a line from storage
	public String ReadLine()
		throws StorageException	
	{
		try {
			return fd.readLine();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from storage file" );
		}
	}
	
	private RandomAccessFile ix = null;		// file pointer for index storage file
	
	// Implementation for writing out index to storage
	public void Write( Index index )
		throws StorageException
	{
		// construct path of index for this collection
		String idx = storageRoot + collection + ".idx";
		
		// Open the index file
		try
		{
			ix = new RandomAccessFile( idx, "rw" );
		}
		catch ( FileNotFoundException e ) {
			throw new StorageException( "Index File not Found: " + idx );
		}
		
		// TODO: structure of index is hardcoded. 
		// Should be abstracted
		
		ArrayList<long[]> entries = (ArrayList<long[]>)index.Index();
		for ( long[] entry : entries ) {
			try
			{
				ix.writeLong( entry[ 0 ] );
				ix.writeLong( entry[ 1 ] );
			}
			catch ( IOException e ) {
				throw new StorageException( "Cannot write to storage file" );
			}
		}
		
		// Close the index file
		try {
			ix.close();
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot close index file" );
		}
	}
	
	// Implementation for reading in index from storage
	public ArrayList<long[]> ReadIndex()
		throws StorageException
	{
		String idx = storageRoot + collection + ".idx";
		
		// check if index exists yet
		File f = new File(idx);
		if( false == f.exists() ) 
			return null;
	
		try
		{
			ix = new RandomAccessFile( idx, "r" );
		}
		catch ( FileNotFoundException e ) {
			throw new StorageException( "Cannot open index file: " + idx );
		}
		
		// Get the file length
		long filesize = 0;
		try
		{
			filesize = ix.length();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from index file" );
		}

		ArrayList<long[]> entries = new ArrayList<long[]>();
		
		// read 16 bytes at a time
		for ( long i = 0; i < filesize; i += 16 ) {
			try {
				long[] entry = { ix.readLong(), ix.readLong() };
				entries.add( entry );
			}
			catch ( IOException e ) {
				throw new StorageException( "Cannot read from index file" );	
			}
		}
		
		try {
			ix.close();
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot close index file" );
		}
		
		return entries;
	}
	
	private RandomAccessFile sc = null;		// file pointer for schema storage file
	
	// Implementation to Write out schema to storage
	public void Write( Schema schema ) 
		throws StorageException
	{
		// Construct path of Schema for this collection
		String sch = storageRoot + collection + ".sch";
		
		// Open the schema file
		try
		{
			sc = new RandomAccessFile( sch, "rw" );
		}
		catch ( FileNotFoundException e ) {
			throw new StorageException( "Schema File not Found: " + sch );
		}
		
		// Write schema in CSV format
		ArrayList<Pair<String,String>> keys = schema.GetKeys();
		if ( keys != null ) {
			for ( Pair<String,String> key : keys ) {
				try {
					String value = key.getKey() + "," + key.getValue() + "\r\n";
					byte[] bytes = value.getBytes();
					sc.write( bytes, 0, bytes.length );	
				}
				catch ( IOException e ) {
					throw new StorageException( "Cannot write to schema file" );
				}
			}
		}
		
		// Close the schema file
		try {
			sc.close();
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot close schema file" );
		}
	}
	
	// Implementation to Read in schema from storage
	public ArrayList<Pair<String,String>> ReadSchema() 
		throws StorageException
	{	
		String sch = storageRoot + collection + ".sch";
		
		// check if schema exists yet
		File f = new File( sch );
		if( false == f.exists() ) 
			return null;
	
		try
		{
			sc = new RandomAccessFile( sch, "r" );
		}
		catch ( FileNotFoundException e ) {
			throw new StorageException( "Cannot open schema file: " + sch );
		}
		
		// Allocate list for key/type pairs
		ArrayList<Pair<String,String>> keys = new ArrayList<Pair<String,String>>();
		
		// Read in the pairs of key/type
		try
		{
			String line;
			while ( ( line = sc.readLine() ) != null ) {
				String[] pair = line.split( "," );
				keys.add( new Pair( pair[ 0 ], pair[ 1 ] ) );
			}
		}
		catch ( IOException e ) {
			throw new StorageException( "Cannot read from schema file: " + sch );
		}
		
		// Close the schema file
		try {
			sc.close();
		}
		catch ( IOException e )
		{
			throw new StorageException( "Cannot close schema file" );
		}
		
		return keys;
	}
}