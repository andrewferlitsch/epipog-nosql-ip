// Abstract Layer for Accessing Data Item
//
public abstract class Data {
	protected Object value;
	
	// Default constructor
	public Data() {
	}

	// Method for getting the data type
	public abstract String Type();
	
	// Method of getting the size of the data type
	public abstract Integer Size();

	// Method for getting the value of the data item
	public abstract Object Get();
	
	// Method for setting the value of the data item
	public abstract void Set( Object v );
	
	// Method for string representation of the data item
	public abstract String AsString();
	
	// Method for equal operator for data type
	public abstract boolean EQ( Object v );
	
	// Method for not equal operator for data type
	public abstract boolean NE( Object v );
	
	// Method for less than operator for data type
	public abstract boolean LT( Object v );
	
	// Method for greater than operator for data type
	public abstract boolean GT( Object v );
	
	// Method for less than or equal operator for data type
	public abstract boolean LE( Object v );
	
	// Method for greater than or equal operator for data type
	public abstract boolean GE( Object v );
}