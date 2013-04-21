package hxmath;

// BigInt interface
abstract BigInt(_BigInt) {
	static inline var BITS_PER_CHUNK : Int = 31;
	static inline var CHUNK_MASK : Int = (1 << BITS_PER_CHUNK) - 1;
	static inline var CHUNK_MAX_FLOAT : Float = (1 << (BITS_PER_CHUNK-1)) * 2.0;

	inline function new() : BigInt
		this = alloc();

	// INSTANTIATION
	private static inline function alloc() : _BigInt {
		return {chunks: new Array(), signum: 0};
	}

	@:from
	public static function ofInt(n : Int) : BigInt {
		var bn = new BigInt();
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
		var bn = new BigInt();

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
		return new BigInt();
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
		// the _BigInt representation is guaranteed to be unique,
		// so we can just compare the guts for equality
		if(lhs.signum != rhs.signum) return false;
		if(lhs.chunks.length != rhs.chunks.length) return false;
		for(i in 0...lhs.chunks.length) {
			if(lhs.chunks[i] != rhs.chunks[i]) return false;
		}

		return true;
	}

	@:op(A != B)
	public static inline function neq(lhs : BigInt, rhs : BigInt) : Bool
		return !eq(lhs, rhs);

	@:op(A == B) @:commutative
	public static inline function eqInt(lhs : BigInt, rhs : Int) : Bool
		return lhs == ofInt(rhs);

	@:op(A != B) @:commutative
	public static inline function neqInt(lhs : BigInt, rhs : Int) : Bool
		return lhs != ofInt(rhs);

	// BASIC ARITHMETIC
	@:op(A + B)
	public static function add(lhs : BigInt, rhs : BigInt) : BigInt {
		if (lhs.signum == 0) return rhs;
		if (rhs.signum == 0) return lhs;
		if (_compareMagnitude(lhs, rhs) == 1) {
			var temp = lhs;
			lhs = rhs;
			rhs = temp;
		}
		if (lhs.signum == rhs.signum) return _add(lhs, rhs);
		else return _sub(lhs, rhs);
	}

	@:op(A - B)
	public static function sub(lhs : BigInt, rhs : BigInt) : BigInt {
		rhs.signum = -rhs.signum;
		var out = add(lhs, rhs);
		rhs.signum = -rhs.signum;
		return out;
	}

	static function _compareMagnitude(a : BigInt, b : BigInt) : Int {
		if (a.chunks.length > b.chunks.length) return -1;
		if (a.chunks.length < b.chunks.length) return 1;
		var i = a.chunks.length;
		while (i >= 0) {
			if(a.chunks[i] > b.chunks[i]) return -1;
			if(a.chunks[i] < b.chunks[i]) return 1;
			i--;
		}
		return 0;
	}

	static function _add(big : BigInt, small : BigInt) : BigInt {
		var out = new BigInt();

		var carry = 0;
		for(i in 0...big.chunks.length) {
			var sum = big.chunks[i] + small.chunks[i] + carry;
			carry = sum >>> BITS_PER_CHUNK;
			sum &= CHUNK_MASK;
			out.chunks.push(sum);
		}
		for(i in big.chunks.length...small.chunks.length) {
			var sum = big.chunks[i] + carry;
			carry = sum >>> BITS_PER_CHUNK;
			sum &= CHUNK_MASK;
			out.chunks.push(sum);
		}
		if (carry == 1) out.chunks.push(1);
		out.signum = big.signum;

		return out;
	}

	static function _sub(big : BigInt, small : BigInt) : BigInt {
		var out = new BigInt();

		var borrow = 0;
		for(i in 0...big.chunks.length) {
			var diff = big.chunks[i] - small.chunks[i] - borrow;
			borrow = diff >>> BITS_PER_CHUNK;
			diff &= CHUNK_MASK;
			out.chunks.push(diff);
		}
		for(i in big.chunks.length...small.chunks.length) {
			var diff = big.chunks[i] - borrow;
			borrow = diff >>> BITS_PER_CHUNK;
			diff &= CHUNK_MASK;
			out.chunks.push(diff);
		}
		if (borrow == 1) out.chunks.push(1);
		out.signum = big.signum;

		return out;
	}

	@:op(A * B)
	public static inline function mul(lhs : BigInt, rhs : BigInt) : BigInt
		return new BigInt(); // TODO

	@:op(A / B)
	public static inline function div(lhs : BigInt, rhs : BigInt) : BigInt
		return new BigInt(); // TODO

	@:op(-A)
	public static inline function neg(n : BigInt) : BigInt {
		var out : BigInt = new BigInt();
		out.chunks = n.chunks;
		out.signum = -n.signum;
		return out;
	}
}

private typedef _BigInt = {
	var chunks : Array<Int>;
	var signum : Int;
}