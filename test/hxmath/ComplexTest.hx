package hxmath;

import massive.munit.Assert;

class ComplexTest {
	@Test
	public function testCreation() {
		var c : Complex = new Complex();
		Assert.areEqual(0.0, c.real);
		Assert.areEqual(0.0, c.imag);

		c = new Complex(1.1, -3.2);
		Assert.areEqual(1.1, c.real);
		Assert.areEqual(-3.2, c.imag);

		c.real = 9999;
		c.imag = -1234;
		Assert.areEqual(9999, c.real);
		Assert.areEqual(-1234, c.imag);		
	}
}