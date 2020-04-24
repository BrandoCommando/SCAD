difference(){
  union(){
  cylinder(d=35,h=10,$fn=60);
    translate([16,-4.5]) cube([22,9,10]);
  }
  translate([0,0,-.01]) cylinder(d=32,h=10.02,$fn=50);
  translate([-20,-10,-.01]) cube([10,20,10.02]);
  translate([34,-4.51,2]) cube([1.99,9.02,6]);
}
translate([36,-4.5]) difference() {
  cube([4,9,20]);
  translate([-.01,4.5,16]) rotate([0,90,0]) cylinder(d=4,h=10,$fn=20);
}
*translate([17.5+20,-4.5]) {
  cube([10,9,16]);
  translate([10,0]) cube([3,9,18]);
}