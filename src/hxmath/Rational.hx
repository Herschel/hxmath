package hxmath;

// TODO: Parameterize, Rational<T>, allow use of BigInt etc.?
abstract Rational(_Rational) {
	public var num(get, set) : Int;
	inline function get_num() return this.num;
	inline function set_num(n) return this.num = n;

	public var den(get, set) : Int;
	inline function get_den() return this.den;
	inline function set_den(n) return this.den = n;

	public function new(num : Int = 0, den : Int = 1) : Rational {
		this = alloc();
		this.num = num;
		this.den = den;
	}

	static inline function alloc() : _Rational
		return {num: 0, den: 0};
}

private typedef _Rational = {
	var num : Int;
	var den : Int;
}