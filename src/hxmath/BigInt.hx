package hxmath;

// BigInt interface
abstract BigInt(_BigInt) {
	inline function new(n : _BigInt) { this = n; }

	@:from static public inline function ofInt(n : Int) : BigInt {
		return new BigInt( _BigInt.ofInt(n) );
	}

	public inline function toInt() : Int { return this.toInt(); }
}

/** Implementation of BigInt */
private class _BigInt {
	static inline var BITS_PER_CHUNK : Int = 31;
	static inline var CHUNK_MASK : Int = (1<<BITS_PER_CHUNK) - 1;

	private var _chunks : Array<Int>;
	private var _signum : Int;

	private function new() {
		_chunks = new Array();
		_signum = 0;
	}

	// INSTANTIATION
	static public inline function alloc() : _BigInt {
		return new _BigInt();
	}

	// CONVERSION
	static public function ofInt(n : Int) : _BigInt {
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
}