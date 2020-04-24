cd=25.4/2-.4;
bigang=50;
litang=90;
rotate([0,0,bigang]) translate([100,0]) mirror([0,1,0]) rotate([90,0]) linear_extrude(20) profile();
rotate_extrude(angle=bigang,$fn=200) translate([100,0]) profile();
translate([100,0]) rotate([90,0]) linear_extrude(25.4*4,convexity=3) profile();
translate([100,25.4*-4]) mirror([0,1]) translate([-25.4,0]) {
  rotate_extrude(angle=litang,$fn=100) translate([25.4,0]) profile();
  rotate([0,0,litang]) mirror([0,1]) translate([25.4,0]) rotate([90,0]) linear_extrude(25.4*2,convexity=3) profile();
}
module profile() {
  difference() {
    circle(d=cd,$fn=50);
    translate([cd*-.5,cd*-.5]) square([cd,2]);
  }
}