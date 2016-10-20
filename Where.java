
// Class for Where Clause
public class Where {
	String  key;
	Data   value;	
	WhereOp op;
	
	public enum WhereOp {
		EQ,
		LT,
		GT,
		LE,
		GE
	}
}