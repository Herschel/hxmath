package hxmath;

// BigInt interface
abstract BigInt(_BigInt) {
	inline function new(n : _BigInt) { this = n; }

	@:from static public inline function ofInt(n : Int) : BigInt {
		return new BigInt( _BigInt.ofInt(n) );
	}

	public inline function toInt() : Int { return this.toInt(); }
}

// BigInt implementation
private class _BigInt {
	private function new() {

	}

	// INSTANTIATION
	static public inline function alloc() : _BigInt {
		return new _BigInt();
	}

	// CONVERSION
	static public function ofInt(n : Int) : _BigInt {
		// TODO
		return alloc();
	}

	public function toInt() : Int {
		// TODO
		return 0;
	}
}