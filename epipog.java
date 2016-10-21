import javafx.util.Pair;
import java.util.List;
import java.util.ArrayList;
import java.io.*;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.charset.Charset;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.text.DateFormat;

// Main entry for Query application
public class epipog {
	final static String usage = "Usage: epipog <options>\r\n" +
								"\t-c cache\t# size of cache in MB [not implemented]\r\n" +
								"\t-C collection\t# name of the data collection\r\n" +
								"\t-d datastore\t# type of data store (binary,psv,json,csv)\r\n" +
								"\t-f filter\t# filter [not implemented]\r\n" +
								"\t-F format\t# input format (psv,csv,tsv)\r\n" +
								"\t-i inputfile\t# import input file\r\n" +
								"\t-I index\t# index type (linked,binary)\r\n" +
								"\t-n\t\tno header in input file (e.g., csv, psv, tsv)\t\n" +
								"\t-o field(s)\t# order by fields\r\n" +
								"\t-O sort\t\t# sort method (insert,merge,quick)\r\n" +
								"\t-P primary\t# primary keys for indexing\r\n" +
								"\t-s field(s)\t# select fields\r\n" +
								"\t-S schema\t# the schema (key,value pairs)\r\n" +
								"\t-t storage\t# storage type (single,multi)\r\n" +
								"\t-V\t\t# vacuum (remove deleted items) from collection [not implemented]\r\n";
		
	// Main entry method
	public static void main( String args[] ) {
		// Check for command line argument are present
		if ( 0 == args.length ) {
			System.err.print( usage );
			System.exit( 1 );
		}
		
		String  cOption = "1";		// cache size
		int     cacheSize = 1;		// default cache size is 1Kb
		String  COption = "tmp";	// collection name: default to 'tmp' if none specified
		String  dOption = "binary";	// data store: default is binary
		String  fOption = null;		// filter (where)
		String  FOption = "csv";	// input format: default to CSV
		String  iOption = null;		// insert
		String  IOption = "linked";	// index type: default to linked list
		boolean nOption = false;	// no header in input file (csv, psv, tsv)
		String  oOption = null;		// order by	
		String  OOption = "insert";	// sort method: default to insert(ion)
		String  POption = null; 	//"STB,TITLE,DATE";	// Primary keys
		String  sOption = null;		// select
		String  SOption = null;		// schema
		String  tOption = "single";	// storage type: default to 'single'
		boolean VOption = false;	// vacuum
		
		DataStore dataStore = null;		// the data store type for this operation
		
		// Parse the command line arguments
		char opt;
		while ( ( opt = GetOpt.Parse( args, "c:C:d:f:F:i:I:no:O:P:s:S:t:V", usage ) ) != (char)-1 ) {
			switch ( opt ) {
			case 'c': cOption = GetOpt.Arg(); break;
			case 'C': COption = GetOpt.Arg(); break;
			case 'd': dOption = GetOpt.Arg(); break;
			case 'f': fOption = GetOpt.Arg(); break;
			case 'F': FOption = GetOpt.Arg(); break;
			case 'i': iOption = GetOpt.Arg(); break;
			case 'I': IOption = GetOpt.Arg(); break;
			case 'n': nOption = true;   break;
			case 'o': oOption = GetOpt.Arg(); break;
			case 'O': OOption = GetOpt.Arg(); break;
			case 'P': POption = GetOpt.Arg(); break;
			case 's': sOption = GetOpt.Arg(); break;
			case 'S': SOption = GetOpt.Arg(); break;
			case 't': tOption = GetOpt.Arg(); break;
			case 'V': VOption = true;   break;
			}
		}
		
		if ( GetOpt.Index() != args.length ) {
			System.err.println( "Invalid argument: " + args[ GetOpt.Index() ] );
			System.err.println( usage );
			System.exit( 1 );
		}
		
		// Check for valid cache size option
		try {
			cacheSize = Integer.parseInt( cOption );
		}
		catch ( NumberFormatException e ) {
			System.err.println( "Invalid argument for cache size (-c): " + cOption );
			System.err.print( usage );
			System.exit( 1 );
		}
		
		// Check for valid data store option
		switch ( dOption ) {
			case "binary"	: dataStore = new BinaryStore( COption );
							  break;
			case "psv"		: dataStore = new PSVStore( COption );
							  break;
			case "csv"		: dataStore = new CSVStore( COption );
							  break;
			case "json"		: dataStore = new JSONStore( COption );
							  break;
			default			: System.err.println( "Invalid argument for data store (-d): " + dOption );
							  System.err.print( usage );
							  System.exit( 1 );
							  break;
		}
		
		// Check for valid storage type options
		try
		{
			dataStore.Storage( tOption );
		}
		catch ( StorageException e ) {
			System.err.println( e.getMessage() );
			System.err.print( usage );
			System.exit( 1 );
		}
		
		// Load & Verify Schema
		if ( null != SOption ) {
			String[] pairs = SOption.split( "," );	// pair key/values are comma separated
			if ( 0 == pairs.length ) {
				System.err.println( "Empty schema -S option : " + SOption );
				System.err.print( usage );
				System.exit( 1 );
			}
			
			ArrayList<Pair<String,String>> keys = new ArrayList<Pair<String,String>>( pairs.length ); 	// allocate space
			for ( int i = 0; i < pairs.length; i++ ) {			// process each key/value pair
				String[] keyval = pairs[ i ].split( ":" );
				if ( 2 != keyval.length ) {
					System.err.println( "Schema: key missing data type (-S): " + pairs[ i ] );
					System.err.print( usage );
					System.exit( 1 );
				}
				keys.add( new Pair( keyval[ 0 ].toLowerCase(), keyval[ 1 ].toLowerCase() ) );
			}
			
			// Load the schema
			try{
				dataStore.Schema( keys );
			}
			catch ( IllegalArgumentException e ) {
				System.err.println( e.getMessage() );
				System.err.print( usage );
				System.exit( 1 );
			}
		}
		
		// Load the Primary Keys for the Schema
		String[] primary = null;
		if ( null != POption ) {
			primary = POption.split( "," );	// primary key list separated by commas
			
			if ( 0 == primary.length ) {
				System.err.println( "Malformed argument for primary key (-P): " + POption );
				System.err.print( usage );
				System.exit( 1 );
			}
			
			// Load & Verify the Primary Keys
			try {
				dataStore.Primary( primary );
			}
			catch ( IllegalArgumentException e ) {
				System.err.println( e.getMessage() );
				System.err.print( usage );
				System.exit( 1 );
			}
		}
		
		// Check for valid index type options
		try
		{
			dataStore.Index( IOption );
		}
		catch ( StorageException e ) {
			System.err.println( e.getMessage() );
			System.err.print( usage );
			System.exit( 1 );
		}

		// Open the storage
		try {
			dataStore.Open();
		}
		catch ( StorageException e ) {
			System.err.println( e.getMessage() );
			System.exit( 1 );
		}
		
		// Insert
		if ( null != iOption ) {
			// Allocate the input file parser
			Parse parse = null;
			switch ( FOption ) {
			case "psv": parse = new PSVParse( iOption, dataStore, nOption ); break;
			case "csv": parse = new CSVParse( iOption, dataStore, nOption ); break;
			case "tsv": parse = new TSVParse( iOption, dataStore, nOption ); break;
			default	  : System.err.println( "Invalid argument for input format (-F): " + FOption );
						System.err.println( usage );
						System.exit( 1 );
						break;
			}
			
			try {
				parse.Open();
			}
			catch ( IOException e ) {
				System.err.println( e.getMessage() );
				System.err.println( usage );
				System.exit( 1 );
			}
			
			// parse and insert rows into data store
			try
			{
				parse.Parse();
			}
			catch ( StorageException e ) {
				System.err.println( e.getMessage() );
				System.exit( 1 );
			}
			catch ( IllegalArgumentException e ) {
				System.err.println( e.getMessage() );
				System.exit( 1 );
			}
			
			try {
				parse.Close();
			}
			catch ( IOException e ) {
				System.err.println( e.getMessage() );
				System.exit( 1 );
			}
		}
		
		// filter (where)
		Where where = null;
		ArrayList<Where> whereList = new ArrayList<Where>();
		if ( null != fOption ) {
			String[] filters = fOption.split( "," );
			
			// Check the syntax of the filter arguments
			for ( String filter : filters ) {
				where = new Where();	// allocate a filter object
				
				// Parse the where operatorS
				String[] pair = null;
				if ( filter.contains( "<=" ) ) {
					pair = filter.split( "<=" );
					where.op = Where.WhereOp.LE; 
				}
				else if ( filter.contains( ">=" ) ) {
					pair = filter.split( ">=" );
					where.op = Where.WhereOp.GE; 
				}
				else if ( filter.contains( "!=" ) ) {
					pair = filter.split( "!=" );
					where.op = Where.WhereOp.NE; 
				}
				else if ( filter.contains( "<" ) ) {
					pair = filter.split( "<" );
					where.op = Where.WhereOp.LT; 
				}
				else if ( filter.contains( ">" ) ) {
					pair = filter.split( ">" );
					where.op = Where.WhereOp.GT; 
				}
				else if ( filter.contains( "=" ) ) {
					pair = filter.split( "=" );
					where.op = Where.WhereOp.EQ; 
				}
				if ( null == pair || pair.length != 2 ) {
					System.err.println( "Malformed argument for filter (-f): " + filter );
					System.err.println( usage );
					System.exit( 1 );
				}
			
				String type = null;
				try {
					type = dataStore.GetType( pair[ 0 ] );
				}
				catch ( IllegalArgumentException e ) {
					System.err.println( e.getMessage() );
					System.err.println( usage );
					System.exit( 1 );
				}
				if ( null == type ) {
					System.err.println( "Key not found: " + pair[ 0 ] );
					System.err.println( usage );
					System.exit( 1 );
				}
				
				where.key = pair[ 0 ]; 
				
				try {
					switch ( type ) {
					case "string16"	: where.value = new DataString16(); 	where.value.Set( pair[ 1 ] ); break;
					case "string32"	: where.value = new DataString32(); 	where.value.Set( pair[ 1 ] ); break;
					case "string64"	: where.value = new DataString64(); 	where.value.Set( pair[ 1 ] ); break;
					case "string128": where.value = new DataString128(); 	where.value.Set( pair[ 1 ] ); break;
					case "char"		: where.value = new DataChar();			where.value.Set( pair[ 1 ] ); break;
					case "integer"	: where.value = new DataInteger(); 		where.value.Set( Integer.parseInt( pair[ 1 ] ) ); break;
					case "short"	: where.value = new DataShort(); 		where.value.Set( Short.parseShort( pair[ 1 ] ) ); break;
					case "long"		: where.value = new DataLong(); 		where.value.Set( Long.parseLong( pair[ 1 ] ) ); break;
					case "float"	: where.value = new DataFloat(); 		where.value.Set( Float.parseFloat( pair[ 1 ] ) ); break;
					case "double"	: where.value = new DataDouble(); 		where.value.Set( Double.parseDouble( pair[ 1 ] ) ); break;
					case "date"		: where.value = new DataDate(); 		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
																			where.value.Set( format.parse( pair[ 1 ] ).getTime() ); break;
					case "time"		: where.value = new DataTime(); 		format = new SimpleDateFormat("HH:ss");
																			where.value.Set( format.parse( pair[ 1 ] ).getTime() ); break;
					}
					
					whereList.add( where );
				}
				catch ( ParseException e ) {
					System.err.println( "Invalid argument for find clause (-f): " + pair[ 1 ] );
					System.err.println( usage );
					System.exit( 1 );
				}
				catch ( NumberFormatException e ) {
					System.err.println( "Invalid argument for find clause (-f): " + pair[ 1 ] );
					System.err.println( usage );
					System.exit( 1 );
				}
			}
		}
		
		ArrayList<Data[]> result = null;	// query results
		
		// select
		String[] sKeys = null;
		if ( null != sOption ) {
			sKeys = sOption.split( "," );	// get keys (column names) from option arguments
			for ( int j = 0; j < sKeys.length; j++ )
				sKeys[ j ] = sKeys[ j ].toLowerCase();
			
			try {
				result = dataStore.Select( sKeys, whereList );
			}
			catch ( StorageException e ) {
				System.err.println( e.getMessage() );
				System.exit( 1 );
			}
			catch ( IllegalArgumentException e ) {
				System.err.println( e.getMessage() );
				System.err.print( usage );
				System.exit( 1 );
			}
		}
		
		// Display the results
		if ( null != result ) {
			// order by
			if ( null != oOption ) {
				Sort sort = null;
				switch ( OOption ) {
				case "insert" : sort = new InsertionSort( result, dataStore ); 
								break;
				case "quick"  : sort = new QuickSort( result, dataStore ); 
								break;
				default		  : System.err.println( "Invalid argument for sort type (-O): " + OOption );
								System.err.println( usage );
								System.exit( 1 );
								break;
				}
				
				try
				{
					String[] orderby = oOption.split( "," );
					for ( int j = 0; j < orderby.length; j++ )
						orderby[ j ] = orderby[ j ].toLowerCase();
					
					dataStore.checkKeyArgs( orderby );
					
					result = sort.Sort( orderby );
				}
				catch ( IllegalArgumentException e ) {
					System.err.println( e.getMessage() );
					System.err.println( usage );
					System.exit( 1 );
				}
			}
	
			// Display each row in the result
			for ( Data[] row : result ) {
				// Display each column in the field
				for ( int j = 0; j < row.length; j++ ) {
					if ( row[ j ] != null )
						System.out.print( row[ j ].AsString() );
					if ( j < row.length - 1 )
						System.out.print( "," );
				}
				System.out.println( "" );
			}
		}
		
		// Vacuum
		if ( true == VOption ) {
			// TODO: do vacuum function
		}
		
		// Close the storage
		try {
			dataStore.Close();
		}
		catch ( StorageException e ) {
			System.err.println( e.getMessage() );
			System.exit( 1 );
		}
		
		System.exit( 0 );
	}
}