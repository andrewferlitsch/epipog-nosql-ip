public class GetOpt {
	
	// Getopt() command line parser
	private static String optarg = null;	// argument for option
	private static int getOptIndex = 0;		// current index in argument list
	
	// Accessor method for argument that follows option
	static public String Arg() { return optarg; }
	static public int    Index() { return getOptIndex; }
	
	// 	argv	: argument list
	//	parse	: option/arg to parse
	static public char Parse( String[] argv, String parse, String usage ) {
		// End of Argument List
		if ( getOptIndex >= argv.length ) {
			return (char) -1;
		}
		
		// Next argument is not an option
		if ( argv[ getOptIndex ].charAt( 0 ) != '-' ) {
			return (char) -1;
		}
		
		// Stray comma, no option follows
		if ( argv[ getOptIndex ].length() < 2 ) {
			System.err.println( "Invalid argument, no option letter follows comma" );
			System.err.print( usage );
			System.exit( 1 );
			return (char) -1;
		}
		
		// Not a valid option character after comma
		int opt = parse.indexOf( String.valueOf( argv[ getOptIndex ].charAt( 1 ) ) );
		if ( -1 == opt ) {
			System.err.println( "Invalid option: -" +  argv[ getOptIndex ].charAt( 1 ) );
			System.err.print( usage );
			System.exit( 1 );
			return (char)-1;
		}
		
		if ( parse.length() > opt + 1 ) {
			// option requires an argument
			if ( parse.charAt( opt + 1 ) == ':' ) {
				// argument follows option w/o space
				if ( argv[ getOptIndex ].length() > 2 ) {
					optarg = argv[ getOptIndex ].substring( 2 );
					return argv[ getOptIndex++ ].charAt( 1 );
				}
				// argument follows option with space
				else if ( getOptIndex + 1 < argv.length &&
				          argv[ getOptIndex + 1 ].charAt( 0 ) != '-' ) {
					getOptIndex += 2;
					optarg = argv[ getOptIndex - 1 ];
					return argv[ getOptIndex - 2 ].charAt( 1 );	  
				}
				// No argument follows option
				System.err.println( "Missing argument for -" + argv[ getOptIndex ].charAt( 1 ) + " option" );
				System.err.print( usage );
				System.exit( 1 );
				return (char) -1;
			}
		}
		
		// current option parsed
		return argv[ getOptIndex++ ].charAt( 1 );	
	}
}