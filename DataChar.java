// Implementation for Accessing Data Item of type char
//
public class DataChar extends Data {
	
	// Implementation for getting the data type
	public String Type() {
		return "char";
	}
	
	// Implementation for getting the size of the data type
	public Integer Size() {
		return 1;
	}

	// Implementation for getting the value of the data item
	public Character Get() {
		return ( Character )value;
	}
	
	// Implementation for setting the value of the data item
	public void Set( Object v ) {
		value = ( Character ) v;
	}
	
	// Implementation for string representation of the data item
	public String AsString() {
		return String.valueOf( ( Character ) value );
	}
	
	// Implementation for equal operator for data type
	public boolean EQ( Object v ) {
		return ( Character ) value == ( ( DataChar ) v ).Get();
	}
	
	// Implementation for not equal operator for data type
	public boolean NE( Object v ) {
		return ( Character ) value != ( ( DataChar ) v ).Get();
	}
	
	// Implementation for less than operator for data type
	public boolean LT( Object v ) {
		return ( Character ) value < ( ( DataChar ) v ).Get();
	}
	
	// Implementation for greater than operator for data type
	public boolean GT( Object v ) {
		return ( Character ) value > ( ( DataChar ) v ).Get();
	}
	
	// Implementation for less than or equal operator for data type
	public boolean LE( Object v ) {
		return ( Character ) value <= ( ( DataChar ) v ).Get();
	}
	
	// Implementation for greater than or equal operator for data type
	public boolean GE( Object v ) {
		return ( Character ) value >= ( ( DataChar ) v ).Get();
	}
}