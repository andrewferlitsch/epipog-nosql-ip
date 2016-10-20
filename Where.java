

		
public class Where {
	String  key;
	String  value;	// TODO: should be converted to Data
	WhereOp op;
	
	public enum WhereOp {
		EQ,
		LT,
		GT,
		LE,
		GE
	}
}