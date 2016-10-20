// Implementation for Accessing Data Item of type Byte
//
public class DataByte extends Data {
	
	// Implementation for getting the data type
	public String Type() {
		return "byte";
	}
	
	// Implementation for getting the size of the data type
	public Integer Size() {
		return 1;
	}

	// Implementation for getting the value of the data item
	public Byte Get() {
		return ( Byte )value;
	}
	
	// Implementation for setting the value of the data item
	public void Set( Object v ) {
		value = ( Short ) v;
	}
	
	// Implementation for string representation of the data item
	public String AsString() {
		return String.valueOf( ( Byte ) value );
	}
	
	// Implementation for equal operator for data type
	public boolean EQ( Object v ) {
		return ( Byte ) value == ( ( DataByte ) v ).Get();
	}
	
	// Implementation for less than operator for data type
	public boolean LT( Object v ) {
		return ( Byte ) value < ( ( DataByte ) v ).Get();
	}
	
	// Implementation for greater than operator for data type
	public boolean GT( Object v ) {
		return ( Byte ) value > ( ( DataByte ) v ).Get();
	}
	
	// Implementation for less than or equal operator for data type
	public boolean LE( Object v ) {
		return ( Byte ) value <= ( ( DataByte ) v ).Get();
	}
	
	// Implementation for greater than or equal operator for data type
	public boolean GE( Object v ) {
		return ( Byte ) value >= ( ( DataByte ) v ).Get();
	}
}