// Implementation for Accessing Data Item of type String
//
public abstract class DataString extends Data {
	// Method for getting the data type
	public abstract String Type();
	
	// Method for getting the size of the data type
	public abstract Integer Size();

	// Implementation for getting the value of the data item
	public String Get() {
		return ( String ) value;
	}
	
	// Implementation for setting the value of the data item
	public void Set( Object v ) {
		value = ( String ) v;
	}
	
	// Implementation for string representation of the data item
	public String AsString() {
		return ( String ) value;
	}
	
	// Implementation for less than operator for String
	public boolean EQ( Object v ) {
		return ( ( ( String ) value ).compareTo( ( ( DataString ) v ).Get() ) ) == 0 ? true : false;
	}
	
	// Implementation for less than operator for String
	public boolean LT( Object v ) {
		return ( ( ( String ) value ).compareTo( ( ( DataString ) v ).Get() ) ) < 0 ? true : false;
	}
	
	// Implementation for greater than operator for String
	public boolean GT( Object v ) {
		return ( ( ( String ) value ).compareTo( ( ( DataString ) v ).Get() ) ) > 0 ? true : false;
	}
	
	// Implementation for less than or equal operator for String
	public boolean LE( Object v ) {
		return ( ( ( String ) value ).compareTo( ( ( DataString ) v ).Get() ) ) <= 0 ? true : false;
	}
	
	// Implementation for greater than or equal operator for String
	public boolean GE( Object v ) {
		return ( ( ( String ) value ).compareTo( ( ( DataString ) v ).Get() ) ) >= 0 ? true : false;
	}
}