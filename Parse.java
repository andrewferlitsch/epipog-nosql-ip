import javafx.util.Pair;
import java.util.ArrayList;
import java.util.List;
import java.io.*;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.charset.Charset;

// Abstract Layer for parsing input data
public abstract class Parse {
	// Constructor & Initializer
	//	inputFile: path to inputFile
	//  dataStore: data store to insert into
	public Parse( String _inputFile, DataStore _dataStore, boolean _noHeader ) {
		inputFile = _inputFile;
		dataStore = _dataStore;
		noHeader  = _noHeader;
	}
	
	private   String 	   inputFile 	= null;		// File to parse
	protected List<String> lines 		= null;		// list of lines read in from input file
	protected DataStore    dataStore 	= null;		// data store
	protected boolean	   noHeader		= false;	// input file has no header (csv,psv,tsv)
	
	// Method to open the input file
	public void Open()
		throws IOException
	{
		// open the input file
		try
		{
			lines = Files.readAllLines( Paths.get( inputFile ), Charset.forName( "UTF-8" ) );
		}
		catch ( IOException e ) {
			throw new IOException( "Unable to open input file: " + inputFile );
		}
	}
	
	//  Method to close the input file
	public void Close()
		throws IOException
	{
		// nothing
	}
	
	// Method to parse input file
	public abstract void Parse() throws StorageException;
}