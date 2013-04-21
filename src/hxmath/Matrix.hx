package hxmath;

abstract Matrix(_Matrix) {
	public var numRows(get, never) : Int;
	inline function get_numRows() return this.length;

	public var numCols(get, never) : Int;
	inline function get_numCols() return this[0].length;

	public function new(rows : Int, cols : Int) : Matrix
		this = alloc(rows, cols);

	inline function get(i : Int, j : Int) return this[i][j];

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
	public static function eq(lhs : Matrix, rhs : Matrix) : Bool {
		if(lhs.numRows != rhs.numRows) return false;
		if(lhs.numCols != rhs.numCols) return false;

		for(i in 0...lhs.numRows) {
			for(j in 0...lhs.numCols)
				if(lhs.get(i, j) != rhs.get(i, j)) return false;
		}

		return true;
	}

	@:op(A != B)
	public static function neq(lhs : Matrix, rhs : Matrix) : Bool {
		if(lhs.numRows != rhs.numRows) return true;
		if(lhs.numCols != rhs.numCols) return true;

		for(i in 0...lhs.numRows) {
			for(j in 0...lhs.numCols)
				if(lhs.get(i, j) != rhs.get(i, j)) return true;
		}

		return false;
	}
	
}

private typedef _Matrix = Array< Array<Float> >;