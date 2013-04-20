package hxmath;

abstract Matrix(_Matrix) {
	public function new(rows : Int, cols : Int) : Matrix
		this = alloc(rows, cols);

	static function alloc(rows : Int, cols : Int) : _Matrix {
		var a = new Array< Array<Float> >();
		for(i in 0...rows) {
			a[i] = new Array<Float>();
			for(j in 0...cols) a[i][j] = (i == j) ? 1.0 : 0.0;
		}
		return a;
	}
	
}

private typedef _Matrix = Array< Array<Float> >;