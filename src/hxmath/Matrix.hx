package hxmath;

abstract Matrix(_Matrix) {
	public var numRows(get, never) : Int;
	inline function get_numRows() return this.length;

	public var numCols(get, never) : Int;
	inline function get_numCols() return this[0].length;

	public function new(rows : Int, cols : Int) : Matrix
		this = alloc(rows, cols);

	static function alloc(rows : Int, cols : Int) : _Matrix {
		if (rows <= 0 || cols <= 0) throw Error.InvalidMatrixSize;

		var a = new Array< Array<Float> >();
		for(i in 0...rows) {
			a[i] = new Array<Float>();
			for(j in 0...cols) a[i][j] = (i == j) ? 1.0 : 0.0;
		}
		return a;
	}

	// BOOLEAN OPERATORS
	@:op(A == B)
	public static function eq(lhs : Matrix, rhs : Matrix) : Bool
		return false; // TODO

	@:op(A != B)
	public static function neq(lhs : Matrix, rhs : Matrix) : Bool
		return false; // TODO
	
}

private typedef _Matrix = Array< Array<Float> >;