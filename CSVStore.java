import javafx.util.Pair;
import java.util.ArrayList;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;

// Implementation of DataStore as a CSV File
//
public class CSVStore extends SVStore {

	// Extended Constructor
	public CSVStore( String collection ) {
		super( collection, ',' );
	}
}