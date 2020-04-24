//rotate([180,0]) difference(){
//  translate([0.01,0.01,0.01]) cube([69.96,24.96,6]);
base();
//}
module base() {
difference(){
  cube([70,25,5]);
  translate([-.01,8.5,-.01]) {
    translate([8.5,0]) cylinder(d=5,h=5.02,$fn=50);
    translate([0,-2.5]) cube([8.5,5,5.02]);
    translate([30,0,4.5]) cylinder(d=18,h=5.02,$fn=90);
    translate([21,-8.51,4.5]) cube([18,8.5,5.02]);
    translate([30,0]) cylinder(d=12,h=5.02,$fn=80);
    translate([24,-8.51]) cube([12,8.5,5.02]);
    translate([51,0]) {
      cylinder(d=5,h=5.02,$fn=50);
      translate([0,-2.5]) cube([8,5,5.02]);
      translate([8,0]) cylinder(d=5,h=5.02,$fn=50);
    }
  }
  for(x=[16,44])
  translate([x,6,2]) {
    cylinder(d=6,h=5.02,$fn=50);
    translate([-3,0]) cube([6,13,5.02]);
    translate([0,13]) cylinder(d=6,h=5.02,$fn=50);
    }
  translate([66.5,7.5,2]) {
    cylinder(d=5,h=5.02,$fn=50);
    translate([-2.5,0]) cube([5,10,5.02]);
    translate([0,10]) cylinder(d=5,h=5.02,$fn=50);
  }
}
}