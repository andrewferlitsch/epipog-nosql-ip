import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Date;

// Implementation for Accessing Data Item of type Time
//
public class DataTime extends Data {
	// Implementation for getting the data type
	public String Type() {
		return "time";
	}
	
	// Implementation for getting the size of the data type
	public Integer Size() {
		return 8;
	}

	// Implementation for getting the value of the data item
	public Long Get() {
		return ( Long ) value;
	}
	
	// Implementation for setting the value of the data item
	public void Set( Object v ) {
		value = ( Long ) v;
	}
	
	// Implementation for string representation of the data item
	public String AsString() {
		DateFormat df = new SimpleDateFormat("HH:ss");
		return df.format( new Date( ( Long ) value ) );
	}
	
	// Implementation for less than operator for data type
	public boolean LT( Object v ) {
		return ( Long ) value < ( ( DataTime ) v ).Get();
	}
	
	// Implementation for greater than operator for data type
	public boolean GT( Object v ) {
		return ( Long ) value > ( ( DataTime ) v ).Get();
	}
}