package;

import massive.munit.Assert;
import hxmath.BigInt;

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
}