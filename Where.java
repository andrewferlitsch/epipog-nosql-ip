
// Class for Where Clause
public class Where {
	String  key;				// key to check
	Data    value;				// value to compare to
	WhereOp op;					// comparison operation

	public enum WhereOp {
		EQ,
		NE,
		LT,
		GT,
		LE,
		GE
	}
}