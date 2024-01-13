include <params.scad>
use <rib.scad>

module Rib_A()
{
	Rib(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, 3) children();
}

module Rib_A_Anchored()
{
	Rib_Anchored(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, 3) children();
}

Rib_A();
