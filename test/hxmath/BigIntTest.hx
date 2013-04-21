package hxmath;

import massive.munit.Assert;

class BigIntTest 
{
	public function new() {
	}
	
	@Test
	public function testIntCasts():Void {
		var n : BigInt;

		n = 0;
		Assert.areEqual(0, n.toInt());

		n= 1;
		Assert.areEqual(1, n.toInt());

		n = -5;
		Assert.areEqual(-5, n.toInt());

		n = 0x1234abcd;
		Assert.areEqual(0x1234abcd, n.toInt());
	}

	@Test
	public function testFloatCasts():Void {
		var n : BigInt;

		n = BigInt.ofFloat(0.0);
		Assert.areEqual(0.0, n.toFloat());

		n = BigInt.ofFloat(1.1);
		Assert.areEqual(1.0, n.toFloat());

		n = BigInt.ofFloat(-5.3);
		Assert.areEqual(-5.0, n.toFloat());

		n = BigInt.ofFloat(1.234e63);
		Assert.areEqual(1.234e63, n.toFloat());

		n = BigInt.ofFloat(-5.432e80);
		Assert.areEqual(-5.432e80, n.toFloat());

		n = BigInt.ofFloat(1.2345e-50);
		Assert.areEqual(0.0, n.toFloat());
	}

	@Test
	public function testStringCasts() {
		var n : BigInt;

		n = BigInt.ofString("0");
		Assert.areEqual("0", n.toString());

		n = BigInt.ofString("20");
		Assert.areEqual("20", n.toString());

		n = BigInt.ofString("-3");
		Assert.areEqual("-3", n.toString());

		n = BigInt.ofString("12345678901234567890");
		Assert.areEqual("12345678901234567890", n.toString());

		n = BigInt.ofString("   099999999999999999  ");
		Assert.areEqual("99999999999999999", n.toString());

		n = BigInt.ofString("   -099999999999999999  ");
		Assert.areEqual("-99999999999999999", n.toString());
	}

	@Test
	public function testEquality() {
		var n : BigInt;
		var m : BigInt;

		// we can not use areEqual here, because it casts to Dynamic
		// and loses the type info necessary to call the proper == method
		m = 1;
		Assert.isTrue(m == 1);
		Assert.isTrue(1 == m);
		Assert.isFalse(m != 1);
		Assert.isFalse(1 != m);

		n = 1;
		Assert.isTrue(m == n);
		Assert.isFalse(m != n);

		n = 2;
		Assert.isFalse(m == n);
		Assert.isTrue(m != n);
	}

	@Test
	public function testAddition() {
		var m : BigInt;
		var n : BigInt;
		var s : BigInt;

		// identity
		m = 123; n = 0;
		Assert.isTrue(m+n == m);
		Assert.isTrue(n+m == m);

		// commutativity
		m = 123; n = 343; s = 466;
		Assert.isTrue(m+n == s);
		Assert.isTrue(n+m == s);

		// associativity
		m = -234356; n = 355321; s = 120965;
		Assert.isTrue(m+n == s);

		// lots of big sums
		m = 0x7fffffff;
		n = m;
		s = BigInt.ofString("4294967294");
		Assert.isTrue(m+n == s);

		m = BigInt.ofString("11111111111111111111110111111111111111111111111111");
		n = m;
		s = BigInt.ofString("22222222222222222222220222222222222222222222222222");
		Assert.isTrue(m+n == s);

		m = BigInt.ofString("99499494949383948405");
		n = BigInt.ofString("-472435789789045237084578078029457809342597808204538970");
		s = BigInt.ofString("-472435789789045237084578078029457709843102858820590565");
		Assert.isTrue(m+n == s);

		m = BigInt.ofString("-1");
		n = BigInt.ofString("100000000000000000000000000000000000000000000");
		s = BigInt.ofString("99999999999999999999999999999999999999999999");
		Assert.isTrue(m+n == s);
	}

	@Test
	public function testNegation() {
		var m : BigInt;
		var n : BigInt;

		// -0 == 0
		n = 0;
		Assert.isTrue(-n == n);

		n = 1;
		Assert.isTrue(-n == -1);
		Assert.isTrue(-(-n) == n);

		n = -1234;
		Assert.isTrue(-n == 1234);
		Assert.isTrue(-(-n) == n);

		m = BigInt.ofString("192395858359234934684359234");
		n = BigInt.ofString("-192395858359234934684359234");
		Assert.isTrue(-m == n);
		Assert.isTrue(m == -n);
	}
}