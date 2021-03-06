package hxmath;

// TODO: Parameterize, Rational<T>, allow use of BigInt etc.?
abstract Rational(_Rational) {
	public var num(get, set) : Int;
	inline function get_num() return this.num;
	inline function set_num(n) return this.num = n;

	public var den(get, set) : Int;
	inline function get_den() return this.den;
	inline function set_den(n) return this.den = n;

	var impl(get, never) : _Rational;
	inline function get_impl() return this;

	public function new(num : Int = 0, den : Int = 1) : Rational {
		this = alloc();
		this.num = num;
		this.den = den;
		reduce();
	}

	static inline function alloc() : _Rational
		return {num: 0, den: 0};

	// CONVERSIONS
	public function toFloat() : Float
		return this.num / this.den;

	public function toString() : String
		return '${this.num} / ${this.den}';

	function reduce() {
		if(this.num == 0) {
			this.den = 1;
			return;
		}

		var a = this.num;
		var b = this.den;
		while(b != 0) {
			var temp = b;
			b = a % temp;
			a = temp;
		}
		if(a < 0) a = -a;

		this.num = Std.int(this.num / a);
		this.den = Std.int(this.den / a);

		if(this.den < 0) {
			this.num = -this.num;
			this.den = -this.den;
		}
	}

	// BASIC ARITHMETIC
	@:op(A + B)
	public static function add(lhs : Rational, rhs : Rational) : Rational
		return new Rational(
			lhs.impl.num * rhs.impl.den + rhs.impl.num * lhs.impl.den,
			lhs.impl.den * rhs.impl.den
		);

	@:op(A - B)
	public static function sub(lhs : Rational, rhs : Rational) : Rational
		return new Rational(
			lhs.impl.num * rhs.impl.den - rhs.impl.num * lhs.impl.den,
			lhs.impl.den * rhs.impl.den
		);

	@:op(A * B)
	public static function mul(lhs : Rational, rhs : Rational) : Rational
		return new Rational(
			lhs.impl.num * rhs.impl.num,
			lhs.impl.den * rhs.impl.den
		);

	@:op(A / B)
	public static function div(lhs : Rational, rhs : Rational) : Rational
		return new Rational(
			lhs.impl.num * rhs.impl.den,
			lhs.impl.den * rhs.impl.num
		);

	@:op(-A)
	public static function neg(lhs : Rational) : Rational
		return new Rational(-lhs.impl.num, lhs.impl.den);

	// BOOLEAN COMPARISONS
	@:op(A == B)
	public static function eq(lhs : Rational, rhs : Rational) : Bool {
		// Rational is guaranteed to be unique after reduce
		// so simply compare parts
		return lhs.impl.num == rhs.impl.num && lhs.impl.den == rhs.impl.den;
	}

	@:op(A != B)
	public static inline function ne(lhs : Rational, rhs : Rational) : Bool
		return lhs.impl.num != rhs.impl.num || lhs.impl.den != rhs.impl.den;

	@:op(A < B)
	public static function lt(lhs : Rational, rhs : Rational) : Bool {
		// denominator is always positive, so no need to worry about sign flippage
		return (lhs.impl.num * rhs.impl.den) < (rhs.impl.num * lhs.impl.den);
	}

	@:op(A <= B)
	public static function lte(lhs : Rational, rhs : Rational) : Bool
		return (lhs.impl.num * rhs.impl.den) <= (rhs.impl.num * lhs.impl.den);

	@:op(A > B)
	public static function gt(lhs : Rational, rhs : Rational) : Bool
		return (lhs.impl.num * rhs.impl.den) > (rhs.impl.num * lhs.impl.den);

	@:op(A >= B)
	public static function gte(lhs : Rational, rhs : Rational) : Bool
		return (lhs.impl.num * rhs.impl.den) >= (rhs.impl.num * lhs.impl.den);

	// INTEGER BOOLEAN COMPARISONS
	@:op(A == B) @:commutative
	public static function eqInt(lhs : Rational, rhs : Int) : Bool
		return lhs.impl.num == lhs.impl.den * rhs;

	@:op(A != B) @:commutative
	public static function neInt(lhs : Rational, rhs : Int) : Bool
		return lhs.impl.num != lhs.impl.den * rhs;

	@:op(A < B) @:commutative
	public static function ltInt(lhs : Rational, rhs : Int) : Bool
		return lhs.impl.num < lhs.impl.den * rhs;

	@:op(A <= B) @:commutative
	public static function lteInt(lhs : Rational, rhs : Int) : Bool
		return lhs.impl.num <= lhs.impl.den * rhs;

	@:op(A > B) @:commutative
	public static function gtInt(lhs : Rational, rhs : Int) : Bool
		return lhs.impl.num > lhs.impl.den * rhs;

	@:op(A >= B) @:commutative
	public static function gteInt(lhs : Rational, rhs : Int) : Bool
		return lhs.impl.num >= lhs.impl.den * rhs;
}

private typedef _Rational = {
	var num : Int;
	var den : Int;
}