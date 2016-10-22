import javafx.util.Pair;
import java.util.ArrayList;

// Implementation of Index as Binary Tree
//
public class BinaryTreeIndex extends Index {
	// constructor
	public BinaryTreeIndex( String collectionName, String[] keys ) {
		super( collectionName, keys );
	}
	
	// Method for adding a hashed entry to the index
	// Return
	//	0	: new entry (not found)
	//	non-zero: position of data (entry found)
	public long Add( long hash, long pos ) 
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "BinaryIndex.Add" );	
	}
	
	// Method for finding a hashed entry from index
	// Return
	//	-1 : not found
	//	not -1 : found, return position in datastore
	public long Find( long hash ) 
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "BinaryIndex.Find" );	
	}
	
	// Method for removing a hash entry from the index
	// Return
	//	-1 : not found
	//	not -1 : found and removed
	protected long Remove( long hash )
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "BinaryIndex.Remove" );	
	}
	
	// Implementation to return the position in storage of the nth record (row/document)
	// Return
	//	-1 : no such element
	//  >0 : storage position
	public long Pos( int nth ) 
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "BinaryIndex.Pos" );
	}
	
	// Method for getting in-memory index
	public Object Index()
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "BinaryIndex.Index.get" );	
	}
	
	// Method for setting in-memory index
	public void Index( Object index )
		throws UnsupportedOperationException
	{
		throw new UnsupportedOperationException( "BinaryIndex.Index.set" );
	}
}