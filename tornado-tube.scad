// Tornado Tube
// Print with 2-3 shells for water tightness.
// Cut out plastic support in center of tube.
// Use 7/8" garden hose washer on both sides.
// Requires two 2-liter containers
// Fill a 2-liter container 3/4 full of water.
// Screw them together with this connector.
// Invert and swirl. 
// Watch the tornado!
//
// requires 2LscrewPositive.11.stl from http://www.thingiverse.com/thing:10489

union() {
	difference() {
		cylinder(r=18,h=28);
		translate([0,0,-4]) import("2LscrewPositive.11.stl");
		translate([0,0,32]) rotate([0,180,0]) import("2LscrewPositive.11.stl");
		cylinder(r=7,h=100);
	}
	translate([0,0,12]) cylinder(r=10,h=0.4); // support
}