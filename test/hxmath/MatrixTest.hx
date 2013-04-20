package hxmath;

import massive.munit.Assert;

class MatrixTest {
	@Test
	public function testCreation() {
		var m = new Matrix(3, 3);
		Assert.areEqual(m.numRows, 3);
		Assert.areEqual(m.numCols, 3);

		m = new Matrix(1, 934);
		Assert.areEqual(1, m.numRows);
		Assert.areEqual(934, m.numCols);

		var threw = false;
		try m = new Matrix(0, 323) catch(e : Error) threw = true;
		Assert.isTrue(threw);

		threw = false;
		try m = new Matrix(3, -1) catch(e : Error) threw = true;
		Assert.isTrue(threw);
	}
}