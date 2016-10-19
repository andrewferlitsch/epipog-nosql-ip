import javafx.util.Pair;
import java.util.ArrayList;
import java.util.List;
import java.io.*;

// Implementation for parsing input data with tab ('\t') separator
public class TSVParse extends SVParse {
	// Constructor & Initializer
	//	inputFile:	path to inputFile
	//	dataStore:	data store to insert into
	public TSVParse( String _inputFile, DataStore _dataStore, boolean _noHeader ) {
		super( _inputFile, _dataStore, _noHeader, '\t' );
	}
}