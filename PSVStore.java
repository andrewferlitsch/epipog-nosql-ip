import javafx.util.Pair;
import java.util.ArrayList;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;

// Implementation of DataStore as a PSV File
//
public class PSVStore extends SVStore {

	// Extended Constructor
	public PSVStore( String collection ) {
		super( collection, '|' );
	}
}