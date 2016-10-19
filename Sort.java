import java.util.ArrayList;

// Abstract Layer for Sorting Results
public abstract class Sort {
	// Constructor
	//	_result : result list to be sorted
	//  _datastore : the data store
	public Sort( ArrayList<Data[]> _result, DataStore _dataStore ) {
		result	  = _result;
		dataStore = _dataStore;
	}
	
	protected ArrayList<Data[]> result;	// result list to be sorted
	protected DataStore dataStore;		// data store
	
	// Method to sort an result list
	//	key : keys (columns in schema) to sort
	public abstract ArrayList<Data[]> Sort( String[] keys ) throws IllegalArgumentException;
}