rotate([0,-90]) {
cube([4,70,30]);
translate([0,10,0]) difference() {
  cube([16,20,10]);
  translate([16,-.01,10]) rotate([-90,0]) scale([1.5,1]) cylinder(d=16,h=20.02,$fn=40);
}
translate([0,40,0]) difference() {
  cube([16,20,10]);
  translate([16,-.01,10]) rotate([-90,0]) scale([1.5,1]) cylinder(d=16,h=20.02,$fn=40);
}
translate([5.98,0,30]) cube([1,70,3]);
translate([5.98,0,42]) cube([1,70,3]);
difference(){
  translate([0,0,30]) cube([5.99,70,15]);
  translate([2,10,32]) cube([4,50,11]);
  translate([-.01,4.5,32]) rotate([0,0,45]) cube([10.02,4,11]);
}
translate([5.98,0,30]) linear_extrude(15) polygon([[0,0],[0,10],[10,0]]);
translate([0,70,0]) mirror([0,1]) translate([5.98,0,30]) linear_extrude(15) polygon([[0,0],[0,10],[10,0]]);
}