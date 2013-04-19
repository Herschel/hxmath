package hxmath;

// TODO: Parameterize, _Complex<T>, allow use of BigFloats/etc.?
abstract Complex(_Complex) {
	public var real(get, set) : Float;
	inline function get_real() return this.real;
	inline function set_real(n) return this.real = n;

	public var imag(get, set) : Float;
	inline function get_imag() return this.imag;
	inline function set_imag(n) return this.imag = n;

	public function new(real : Float = 0.0, imag : Float = 0.0) : Complex {
		this = alloc();
		this.real = real;
		this.imag = imag;
	}

	static inline function alloc() : _Complex
		return {real: 0.0, imag: 0.0};
}

private typedef _Complex = {
	var real : Float;
	var imag : Float;
}