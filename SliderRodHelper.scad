difference() {
  translate([-2,-2]) cube([14,14,10]);
  translate([5,4,-.01]) cylinder(d=8,h=10.02,$fn=30);
  translate([2,-2.01,-.01]) cube([6,5,10.02]);
  translate([5,0]) for(m=[0]) mirror([m,0]) translate([-5,0]) translate([17,17,-.01]) rotate([0,0,45]) {
    cylinder(d=24,h=10.02,$fn=60);
    translate([0,0,5]) rotate([0,90]) translate([0,0,-16]) cylinder(d=3,h=8,$fn=20);
  }
  translate([-1,3,5]) rotate([0,0,-20]) rotate([0,90]) translate([0,0,-3]) cylinder(d=3,h=7,$fn=20);
}