// Common utilities for the thumb cluster body and neck.

include <util.scad>
include <params.scad>

TC_PCB_WIDTH = 20.4;

TC_PCB_GUIDE_MAJOR_WIDTH = TC_PCB_WIDTH;
TC_PCB_GUIDE_SLOT_WIDTH = 1.0;
TC_PCB_GUIDE_DEPTH = 3.5;
TC_PCB_GUIDE_SLOT_HEIGHT = 0.9;
TC_PCB_GUIDE_MINOR_WIDTH = TC_PCB_GUIDE_MAJOR_WIDTH - 2*TC_PCB_GUIDE_SLOT_WIDTH;

TC_PCB_GUIDE_PINCH_DIAMETER = 2;

TC_ARM_BASE_WIDTH = TC_PCB_GUIDE_MAJOR_WIDTH;


TC_ARM_HEIGHT = 12;


TC_CUTOUT_DEPTH = 3;


TC_LEG_CUTOUT_WIDTH = 13;
TC_LEG_CUTOUT_DEPTH = 2.2;

TC_INTER_PADDLE_ANGLE = 80;
TC_INTER_PADDLE_ARCLEN = 12;

TC_INTER_PADDLE_RADIUS = TC_INTER_PADDLE_ARCLEN / (TC_INTER_PADDLE_ANGLE * PI / 180) - TC_PCB_GUIDE_DEPTH;

TC_CUTOUT_MINOR_RADIUS = TC_INTER_PADDLE_RADIUS + TC_PCB_GUIDE_DEPTH - TC_PCB_GUIDE_SLOT_HEIGHT;

TC_CUTOUT_MAJOR_RADIUS = TC_CUTOUT_MINOR_RADIUS + TC_CUTOUT_DEPTH;

TC_INTER_PADDLE_INSET_ARCLEN = 2;
TC_INTER_PADDLE_INSET_ANGLE = angleFromLen(TC_CUTOUT_MINOR_RADIUS, TC_INTER_PADDLE_INSET_ARCLEN);

module DownwardHemisphere(d)
{
    difference() {
        circle(d=d);
        Rect(d,d,ANCHOR_CB);
    }
}

module PCBGuide()
{
    EXTRA=1;

    pn_neg() {
        Rect(TC_PCB_GUIDE_MINOR_WIDTH, TC_PCB_GUIDE_DEPTH, ANCHOR_CT, extraY=EXTRA);
        translate([0, -TC_PCB_GUIDE_DEPTH])
            Rect(TC_PCB_GUIDE_MAJOR_WIDTH, TC_PCB_GUIDE_SLOT_HEIGHT, ANCHOR_CB);
        translate([0, -TC_PCB_GUIDE_DEPTH])
            Rect(TC_LEG_CUTOUT_WIDTH, TC_LEG_CUTOUT_DEPTH, ANCHOR_CT);
        translate([-TC_PCB_GUIDE_MAJOR_WIDTH/2+TC_PCB_GUIDE_PINCH_DIAMETER/2, -TC_PCB_GUIDE_DEPTH])
            DownwardHemisphere(d=TC_PCB_GUIDE_PINCH_DIAMETER);
        translate([TC_PCB_GUIDE_MAJOR_WIDTH/2-TC_PCB_GUIDE_PINCH_DIAMETER/2, -TC_PCB_GUIDE_DEPTH])
            DownwardHemisphere(d=TC_PCB_GUIDE_PINCH_DIAMETER);

    }

    translate([-TC_PCB_GUIDE_MAJOR_WIDTH/2, -TC_PCB_GUIDE_DEPTH+TC_PCB_GUIDE_SLOT_HEIGHT])
        ClearedCorner(45);
    translate([TC_PCB_GUIDE_MAJOR_WIDTH/2, -TC_PCB_GUIDE_DEPTH+TC_PCB_GUIDE_SLOT_HEIGHT])
        ClearedCorner(-45);
}

module BodyArm()
{
    pn_pos() Rect(TC_ARM_BASE_WIDTH, TC_ARM_HEIGHT, ANCHOR_CT);

    PCBGuide();
}

module BodyHalfArm()
{
    BIG = 100;
    pn_pos() intersection() {
        Rect(TC_ARM_BASE_WIDTH, TC_ARM_HEIGHT, ANCHOR_CT);
        Rect(BIG, BIG, ANCHOR_RC);
    }

    PCBGuide();
}

module TCElbow()
{
    EXTRA_ANGLE = 0.1;

    pn_pos() {
        difference() {
            Wedge(TC_INTER_PADDLE_RADIUS+TC_ARM_HEIGHT, TC_INTER_PADDLE_ANGLE+EXTRA_ANGLE);
            circle(r=TC_INTER_PADDLE_RADIUS);
        }
    }

    pn_neg() {
        difference() {
            Wedge(TC_CUTOUT_MAJOR_RADIUS, TC_INTER_PADDLE_ANGLE - 2*TC_INTER_PADDLE_INSET_ANGLE);
            circle(r=TC_CUTOUT_MINOR_RADIUS);
        }
    }
}
