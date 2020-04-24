difference() {
  union() {
    cylinder(d=40,h=10,$fn=80);
    translate([-30,-4]) cube([60,8,8]);
  }
  translate([0,-50,5]) rotate([-90,0]) cylinder(d=5,h=100,$fn=30);
  translate([0,0,2]) cylinder(d=30,h=10.02,$fn=6);
  translate([0,0,-.01]) cylinder(d=20,h=2.02,$fn=60);
}