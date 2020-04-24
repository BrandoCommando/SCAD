// THING: BRINE SHRIMP HATCHERY BASE
// AUTHOR: SHANE GRABER
// ----------------------------
// This is a simple brine shrimp hatchery base that one screws onto a plastic
// 2 liter bottle with it's base cut off. Once printed, I suggest brushing the 
// inside with acetone to make it water tight. Optionally, add a rubber o-ring
// at the bottom of the threads to help seal it even more. Attach the airline 
// from your air pump to the nipple protruding vertically from the hatchery base.
// Make sure to use an airline check valve in case of a power outage as one
// does not want the water in this hatchery to back flow into the air pump.
//
// For information on how to culture brine shrimp, please see the following 
// articles:
//
// 1. The Breeder's Net: Artemia Nauplii As A Food Source
//    By Frank Marini, Ph.D.
//    http://www.advancedaquarist.com/2002/12/breeder
//
// 2. Breeder's Net : Amazing Artemia!
//    By Suzy Applegarth
//    http://www.advancedaquarist.com/2008/3/breeder
//
// Requires "2LscrewPositive.11.stl" from "2 Liter bottle threads" found at:
// http://www.thingiverse.com/thing:10489
//
// Enjoy!
//

difference() {
	union() {

		//outside ring, 5 mm wide, 5 mm high
		difference() {
			cylinder(r=45, h=5, $fn=30);
			cylinder(r=40, h=5.1, $fn=30);
		}

		// bottlecap is 26mm diameter, 19mm tall; shortened relative to thread stl
		difference() {
			cylinder(r=19, h=23-4, $fn=20); // cap
			translate([0,0,22]) rotate([0,180,0]) import("2LscrewPositive.11.stl"); // threads
			translate([0,0,14]) cylinder(r1=10, r2=19, h=7); // bevel due to shortening
		}

		// radial supports, 5 mm wide, 5 mm high
		translate([0,0,2.5]) cube(size=[88,5,5], center=true);
		translate([0,0,2.5]) rotate(90) cube(size=[88,5,5], center=true);

		// airline nipple, 6 mm, sticking out of a 6mm block vertically
		translate([10,-14,0]) rotate([0,0,-45]) cube(size=[15,6,6]);
		translate([20.25,-20,2]) cylinder(r=3, h=12, $fn=8);
		
	}

	// air path, 3 mm hole
	translate([0,0,1]) cylinder(r=2, h=15, $fn=8); // 4 mm hole in cap
	translate([0,0,3]) rotate([45,90,0]) cylinder(r=1.5, h=30, $fn=8); // 3 mm hole in block
	translate([20.25,-20,2]) cylinder(r=1.5, h=15, $fn=8); // 3mm hole in nipple

}