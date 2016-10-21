
// Class for Where Clause
public class Where {
	String  key;
	Data   value;	
	WhereOp op;
	
	public enum WhereOp {
		EQ,
		NE,
		LT,
		GT,
		LE,
		GE
	}
}