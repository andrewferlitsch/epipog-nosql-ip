import javafx.util.Pair;
import java.util.ArrayList;
import java.util.List;
import java.io.*;

// Implementation for parsing input data with pipe ('|') separator
public class PSVParse extends SVParse {
	// Constructor & Initializer
	//	inputFile:	path to inputFile
	//	dataStore:	data store to insert into
	public PSVParse( String _inputFile, DataStore _dataStore, boolean _noHeader ) {
		super( _inputFile, _dataStore, _noHeader, '|' );
	}
}