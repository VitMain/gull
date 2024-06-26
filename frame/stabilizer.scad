// A saddle shape which sits astride the front or back of a rib and supports the corners of the
// fingerboard to keep them from drooping. Held in place by friction, compressive force, and the 
// legs of keyswitches.

include <util.scad>
include <params.scad>


module Stabilizer()
{
	LARGE = 100;
	difference() {
		Rect(STABILIZER_OUTER_WIDTH, STABILIZER_HEIGHT, ANCHOR_CT, extraY=STABILIZER_EXTRA_HEIGHT);
		Rect(STABILIZER_INNER_WIDTH, STABILIZER_VERTICAL_INSET, ANCHOR_CT, extraY=STABILIZER_EXTRA_HEIGHT);
	}
}

Dekerf() Stabilizer();
