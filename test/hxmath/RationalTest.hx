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
	public function testComparisons() {
		var a = new Rational(1, 2);
		var b = new Rational(1, 2);
		Assert.isTrue(a==b); Assert.isFalse(a!=b);
		Assert.isFalse(a<b); Assert.isTrue(a<=b);
		Assert.isFalse(a>b); Assert.isTrue(a>=b);

		a = new Rational(2, 4);
		b = new Rational(8, 16);
		Assert.isTrue(a==b); Assert.isFalse(a!=b);
		Assert.isFalse(a<b); Assert.isTrue(a<=b);
		Assert.isFalse(a>b); Assert.isTrue(a>=b);

		a = new Rational(-30, -100);
		b = new Rational(3, 10);
		Assert.isTrue(a==b); Assert.isFalse(a!=b);
		Assert.isFalse(a<b); Assert.isTrue(a<=b);
		Assert.isFalse(a>b); Assert.isTrue(a>=b);

		a = new Rational(0, -1);
		b = new Rational(0, 1344);
		Assert.isTrue(a==b); Assert.isFalse(a!=b);
		Assert.isFalse(a<b); Assert.isTrue(a<=b);
		Assert.isFalse(a>b); Assert.isTrue(a>=b);

		a = new Rational(2, 3);
		b = new Rational(-2, 3);
		Assert.isFalse(a==b); Assert.isTrue(a!=b);
		Assert.isFalse(a<b); Assert.isFalse(a<=b);
		Assert.isTrue(a>b); Assert.isTrue(a>=b);

		a = new Rational(-16, 8);
		b = new Rational(2, 1);
		Assert.isFalse(a==b); Assert.isTrue(a!=b);
		Assert.isTrue(a<b); Assert.isTrue(a<=b);
		Assert.isFalse(a>b); Assert.isFalse(a>=b);

		a = new Rational(-999, 1);
		b = new Rational(1234, -2);
		Assert.isFalse(a==b); Assert.isTrue(a!=b);
		Assert.isTrue(a<b); Assert.isTrue(a<=b);
		Assert.isFalse(a>b); Assert.isFalse(a>=b);
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

	@Test
	public function testAdditionAndSubtraction() {
		var a = new Rational(-100, 1000);
		var b = new Rational(0, -123123);
		Assert.isTrue(a+b == a);
		Assert.isTrue(b+a == a);
		Assert.isTrue(a-b == a);
		Assert.isTrue(a-a == b);
		Assert.isTrue(b+b == b);

		var a = new Rational(1, 2);
		var b = new Rational(2, 4);
		var c = new Rational(1, 1);
		Assert.isTrue(a+b == c);
		Assert.isTrue(c-b == a);
		Assert.isTrue(c-a == b);

		a = new Rational(-1, 2);
		b = new Rational(3, 4);
		c = new Rational(1, 4);
		Assert.isTrue(a+b == c);
		Assert.isTrue(c-b == a);
		Assert.isTrue(c-a == b);

		a = new Rational(410, -321);
		b = new Rational(-32, 400);
		c = new Rational(-10892, 8025);
		Assert.isTrue(a+b == c);
		Assert.isTrue(c-b == a);
		Assert.isTrue(c-a == b);

		a = new Rational(44, 11);
		b = new Rational(55, 22);
		c = new Rational(-6, -4);
		Assert.isTrue(a-b == c);
		Assert.isTrue(a-c == b);
		Assert.isTrue(a == b+c);
	}

	@Test
	public function testMultiplicationAndDivison() {
		var a = new Rational(1234, 5678);
		var b = new Rational(1, 1);
		Assert.isTrue(a*b == a);
		Assert.isTrue(b*a == a);
		Assert.isTrue(a/b == a);

		a = new Rational(50, -1232);
		b = new Rational(0, 144);
		Assert.isTrue(a*b == b);
		Assert.isTrue(b*a == b);
		Assert.isTrue(b/a == b);

		a = new Rational(1, 2);
		b = new Rational(3, 5);
		var c = new Rational(3, 10);
		Assert.isTrue(a*b == c);
		Assert.isTrue(b*a == c);
		Assert.isTrue(c/a == b);
		Assert.isTrue(c/b == a);

		a = new Rational(-2, 55);
		b = new Rational(3, -30);
		c = new Rational(6, 1650);
		Assert.isTrue(a*b == c);
		Assert.isTrue(c/b == a);
		Assert.isTrue(c/a == b);

		a = new Rational(12, 2);
		b = new Rational(-2, 3);
		c = new Rational(36, -4);
		Assert.isTrue(a/b == c);
		Assert.isTrue(a == c*b);
		Assert.isTrue(a/c == b);
	}

	@Test
	public function testNegation() {
		var a = new Rational(1, 2);
		var b = new Rational(-444, 888);
		var z = new Rational(0, 3);
		Assert.isTrue(-a == b);
		Assert.isTrue(a == -b);
		Assert.isTrue(-a == -a);
		Assert.isTrue(a == -(-a));

		Assert.isTrue(a+(-a) == z);
		Assert.isTrue(z-a == -a);
		Assert.isTrue(-z == z);
	}
}