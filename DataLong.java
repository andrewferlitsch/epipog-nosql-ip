// Implementation for Accessing Data Item of type Long
//
public class DataLong extends Data {
	// Implementation for getting the data type
	public String Type() {
		return "long";
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
		return String.valueOf( ( Long ) value );
	}
	
	// Implementation for equal operator for data type
	public boolean EQ( Object v ) {
		long v1 = ( Long ) value;
		long v2 = ( ( DataLong ) v ).Get();
		return ( v1 == v2 );
	}
	
	// Implementation for not equal operator for data type
	public boolean NE( Object v ) {
		long v1 = ( Long ) value;
		long v2 = ( ( DataLong ) v ).Get();
		return ( v1 != v2 );
	}
	
	// Implementation for less than operator for data type
	public boolean LT( Object v ) {
		return ( Long ) value < ( ( DataLong ) v ).Get();
	}
	
	// Implementation for greater than operator for data type
	public boolean GT( Object v ) {
		return ( Long ) value > ( ( DataLong ) v ).Get();
	}
	
	// Implementation for less than or equal operator for data type
	public boolean LE( Object v ) {
		return ( Long ) value <= ( ( DataLong ) v ).Get();
	}
	
	// Implementation for greater than or equal operator for data type
	public boolean GE( Object v ) {
		return ( Long ) value >= ( ( DataLong ) v ).Get();
	}
}