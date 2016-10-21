// Implementation for Accessing Data Item of type Short
//
public class DataShort extends Data {
	
	// Implementation for getting the data type
	public String Type() {
		return "short";
	}
	
	// Implementation for getting the size of the data type
	public Integer Size() {
		return 2;
	}

	// Implementation for getting the value of the data item
	public Short Get() {
		return ( Short )value;
	}
	
	// Implementation for setting the value of the data item
	public void Set( Object v ) {
		value = ( Short ) v;
	}
	
	// Implementation for string representation of the data item
	public String AsString() {
		return String.valueOf( ( Short ) value );
	}
	
	// Implementation for equal operator for data type
	public boolean EQ( Object v ) {
		short v1 = ( Short ) value;
		short v2 = ( ( DataShort ) v ).Get();
		return  v1 == v2;
	}
	
	// Implementation for less than operator for data type
	public boolean LT( Object v ) {
		return ( Short ) value < ( ( DataShort ) v ).Get();
	}
	
	// Implementation for greater than operator for data type
	public boolean GT( Object v ) {
		return ( Short ) value > ( ( DataShort ) v ).Get();
	}
	
	// Implementation for less than or equal operator for data type
	public boolean LE( Object v ) {
		return ( Short ) value <= ( ( DataShort ) v ).Get();
	}
	
	// Implementation for greater than or equal operator for data type
	public boolean GE( Object v ) {
		return ( Short ) value >= ( ( DataShort ) v ).Get();
	}
}