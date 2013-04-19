package;

import massive.munit.Assert;
import hxmath.BigInt;

class BigIntTest 
{
	public function new() {
	}
	
	@Test
	public function testIntCasts():Void {
		var n : BigInt = 1;
		Assert.areEqual(1, n.toInt());

		n = -5;
		Assert.areEqual(-5, n);

		n = 0x1234abcd;
		Assert.areEqual(0x1234abcd, n);
	}
}