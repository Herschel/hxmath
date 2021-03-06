import massive.munit.TestSuite;

import hxmath.BigIntTest;
import hxmath.ComplexTest;
import hxmath.MatrixTest;
import hxmath.RationalTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(hxmath.BigIntTest);
		add(hxmath.ComplexTest);
		add(hxmath.MatrixTest);
		add(hxmath.RationalTest);
	}
}
