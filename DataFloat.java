// Implementation for Accessing Data Item of type Float
//
public class DataFloat extends Data {
	// Implementation for getting the data type
	public String Type() {
		return "float";
	}
	
	// Implementation for getting the size of the data type
	public Integer Size() {
		return 4;
	}

	// Implementation for getting the value of the data item
	public Float Get() {
		return ( Float )value;
	}
	
	// Implementation for setting the value of the data item
	public void Set( Object v ) {
		value = (Float) v;
	}
	
	// Implementation for string representation of the data item
	public String AsString() {
		return String.valueOf( (Float) value );
	}
	
	// Implementation for less than operator for data type
	public boolean LT( Object v ) {
		return ( Float ) value < ( ( DataFloat ) v ).Get();
	}
	
	// Implementation for greater than operator for data type
	public boolean GT( Object v ) {
		return ( Float ) value > ( ( DataFloat ) v ).Get();
	}
}