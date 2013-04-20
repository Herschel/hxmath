package hxmath;

import massive.munit.Assert;

class RationalTest {
	@Test
	public function testCreation() {
		var r : Rational = new Rational();
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
}