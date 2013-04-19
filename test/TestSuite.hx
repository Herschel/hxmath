import massive.munit.TestSuite;

import BigIntTest;
import hxmath.ComplexTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(BigIntTest);
		add(hxmath.ComplexTest);
	}
}
