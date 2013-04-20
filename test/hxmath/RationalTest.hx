package hxmath;

import massive.munit.Assert;

class RationalTest {
	@Test
	public function testCreation() {
		var r : Rational = new Rational();
		Assert.areEqual(0, r.num);
		Assert.areEqual(1, r.den);

		r = new Rational(0, -999);
		Assert.areEqual(0, r.num);
		Assert.areEqual(1, r.den);

		r = new Rational(1, 5);
		Assert.areEqual(1, r.num);
		Assert.areEqual(5, r.den);

		r = new Rational(-1, 3);
		Assert.areEqual(-1, r.num);
		Assert.areEqual(3, r.den);

		r = new Rational(3, -8);
		Assert.areEqual(-3, r.num);
		Assert.areEqual(8, r.den);

		r = new Rational(-9, -16);
		Assert.areEqual(9, r.num);
		Assert.areEqual(16, r.den);

		r = new Rational(2, 4);
		Assert.areEqual(r.num, 1);
		Assert.areEqual(r.den, 2);

		r = new Rational(4325, -801855);
		Assert.areEqual(r.num, -5);
		Assert.areEqual(r.den, 927);		
	}

	@Test
	public function testFloatCasts() {
		var r : Rational = new Rational(1, 2);
		Assert.areEqual(1/2, r.toFloat());

		r = new Rational(-5, 20);
		Assert.areEqual(-1/4, r.toFloat());

		r = new Rational(-2, -3);
		Assert.areEqual(2/3, r.toFloat());

		r = new Rational(53253, -213503);
		Assert.areEqual(-53253/213503, r.toFloat());

		r = new Rational(0, -999);
		Assert.areEqual(0.0, r.toFloat());
	}

	@Test
	public function testStringCasts() {
		var r:Rational = new Rational(1, 2);
		Assert.areEqual("1 / 2", r.toString());

		r = new Rational(-4, 30);
		Assert.areEqual("-2 / 15", r.toString());

		r = new Rational(3, -33);
		Assert.areEqual("-1 / 11", r.toString());

		r = new Rational(0, -11);
		Assert.areEqual("0 / 1", r.toString());

		r = new Rational(-55, -1234);
		Assert.areEqual("55 / 1234", r.toString());
	}
}