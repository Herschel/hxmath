package hxmath;

// BigInt interface
abstract BigInt(_BigInt) {
	static inline var BITS_PER_CHUNK : Int = 31;
	static inline var CHUNK_MASK : Int = (1 << BITS_PER_CHUNK) - 1;
	static inline var CHUNK_MAX_FLOAT : Float = (1 << (BITS_PER_CHUNK-1)) * 2.0;

	inline function new(n : _BigInt) { this = n; }

	// INSTANTIATION
	private static inline function alloc() : BigInt {
		return new BigInt( {chunks: new Array(), signum: 0} );
	}

	@:from
	public static function ofInt(n : Int) : BigInt {
		var bn = alloc();
		if (n < 0) {
			bn.signum = -1;
			n = -n;
		} else if (n > 0) {
			bn.signum = 1;
		} else {
			return bn;
		}
		
		while(n != 0) {
			bn.chunks.push(n & CHUNK_MASK);
			n >>>= BITS_PER_CHUNK;
		}

		return bn;
	}

	public static function ofFloat(n : Float) : BigInt {
		var bn = alloc();

		if (n < 0) {
			bn.signum = -1;
			n = -n;
		} else if (n > 0) {
			bn.signum = 1;
		}

		n = Math.ffloor(n);
		while(n != 0) {
			bn.chunks.push( Std.int(n % CHUNK_MAX_FLOAT) );
			n = Math.ffloor( n / CHUNK_MAX_FLOAT );
		}

		return bn;
	}

	public static function ofString(n : String) : BigInt {
		// TODO
		return alloc();
	}

	// CONVERSION
	public function toInt() : Int {
		var n = 0;
		var i = this.chunks.length - 1;
		while(i >= 0) {
			n <<= BITS_PER_CHUNK;
			n |= this.chunks[i];
			i--;
		}
		return n * this.signum;
	}

	public function toFloat() : Float {
		var n = 0.0;
		var i = this.chunks.length - 1;
		while(i >= 0) {
			n *= CHUNK_MAX_FLOAT;
			n += this.chunks[i];
			i--;
		}
		return n * this.signum;
	}

	public function toString() : String {
		// TODO
		return "0";
	}

	// BOOLEAN COMPARISONS
	@:op(A == B)
	public static function eq(lhs : BigInt, rhs : BigInt) : Bool {
		// TODO
		return false;
	}

	@:op(A != B)
	public static function neq(lhs : BigInt, rhs : BigInt) : Bool {
		// TODO
		return false;
	}
}

private typedef _BigInt = {
	var chunks : Array<Int>;
	var signum : Int;
}