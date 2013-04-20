package hxmath;

import massive.munit.Assert;

class MatrixTest {
	@Test
	public function testCreation() {
		var m = new Matrix(3, 3);
		Assert.areEqual(m.numRows, 3);
		Assert.areEqual(m.numCols, 3);

		var m = new Matrix(1, 934);
		Assert.areEqual(1, m.numRows);
		Assert.areEqual(934, m.numCols);
	}
}