package hxmath;

// BigInt interface
abstract BigInt(_BigInt) {
	inline function new(n : _BigInt) { this = n; }

	@:from
	public static inline function ofInt(n : Int) : BigInt
		return new BigInt( _BigInt.ofInt(n) );

	public static inline function ofFloat(n : Float) : BigInt
		return new BigInt( _BigInt.ofFloat(n) );

	public inline function toInt() : Int
		return this.toInt();

	public inline function toFloat() : Float
		return this.toFloat();
}

/** Implementation of BigInt */
private class _BigInt {
	static inline var BITS_PER_CHUNK : Int = 31;
	static inline var CHUNK_MASK : Int = (1 << BITS_PER_CHUNK) - 1;
	static inline var CHUNK_MAX_FLOAT : Float = (1 << (BITS_PER_CHUNK-1)) * 2.0;

	var _chunks : Array<Int>;
	var _signum : Int;

	function new() {
		_chunks = new Array();
		_signum = 0;
	}

	// INSTANTIATION
	public static inline function alloc() : _BigInt {
		return new _BigInt();
	}

	public static function ofInt(n : Int) : _BigInt {
		var bn = alloc();
		if (n < 0) {
			bn._signum = -1;
			n = -n;
		} else if (n > 0) {
			bn._signum = 1;
		} else {
			return bn;
		}
		
		while(n != 0) {
			bn._chunks.push(n & CHUNK_MASK);
			n >>>= BITS_PER_CHUNK;
		}

		return bn;
	}

	public static function ofFloat(n : Float) : _BigInt {
		var bn = alloc();

		if (n < 0) {
			bn._signum = -1;
			n = -n;
		} else if (n > 0) {
			bn._signum = 1;
		}

		n = Math.ffloor(n);
		while(n != 0) {
			bn._chunks.push( Std.int(n % CHUNK_MAX_FLOAT) );
			n = Math.ffloor( n / CHUNK_MAX_FLOAT );
		}

		return bn;
	}

	// CONVERSION
	public function toInt() : Int {
		var n = 0;
		var i = _chunks.length - 1;
		while(i >= 0) {
			n <<= BITS_PER_CHUNK;
			n |= _chunks[i];
			i--;
		}
		return n * _signum;
	}

	public function toFloat() : Float {
		var n = 0.0;
		var i = _chunks.length - 1;
		while(i >= 0) {
			n *= CHUNK_MAX_FLOAT;
			n += _chunks[i];
			i--;
		}
		return n * _signum;
	}
}