difference() {
  rotate_extrude($fn=200) difference() {
    square([13,8]);
    translate([0,.5]) square([11,8]);
    translate([12+25.4/2,4]) circle(d=25.4,$fn=60);
  }
  translate([0,0,-.01]) cylinder(d=18,h=1.02,$fn=60);
}