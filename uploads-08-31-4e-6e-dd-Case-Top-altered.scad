
module case() {
	difference() {
		rotate([180, 0, 0]) import("Case-Top-repaired.stl", convexity=10);
		
		// Remove the upper extrusion of the camera mount area to make the case top flush
		translate([0, 0, 1.3755]) cube([100, 100, 3], center=true);
		
		// A little foxy flourish
		linear_extrude(height=10, center=true)
			translate([-20, 3, 0]) scale([0.045, 0.045, 1]) import("fox.dxf", convexity=10);
	}
}

// Cutout mask to select the mount to move around
module mask() {
	difference() {
		translate([-24.96, -27.469, -10]) cube([21.35, 25.85, 10]);
		translate([-24.96, -27.469, -10]) cube([6.22, 1.6, 8.5]);
	}
}

// Cutout mask to clear the old mount/case area
module mask2() {
	translate([-30.96, -25.469, -10]) cube([27.35, 23.465, 10]);
	translate([-15.96, -28, -2]) cube([12.35, 3.465, 0.874]);
}

rotate([180, 0, 0]) union() {

// Remove the original mount
difference() {
	difference() {
		case();
		rotate([-45, 0, 0]) translate([-16.5, -0.62, -5.20975]) cube([15, 3, 3]);
	}
	mask2();
}

// Place the mount back in a new spot, 90 deg rotated
*translate([-28.5, 2, 0]) rotate([0, 0, 90])
intersection() {
	case();
	mask();
}

// Place the mount on the same rotation but slightly further away from the ribbon slot
translate([-10.5, 0, 0])
intersection() {
	case();
	mask();
}

// Fill the hole
translate([-15.96, -25.469, -1.125]) cube([12.35, 23.465, 1]);

}