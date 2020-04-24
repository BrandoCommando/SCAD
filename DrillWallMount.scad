mh=50;
rotate([90,0])
{
  union() {
difference(){
  cube([70,10,20]);
  translate([50,-.01,30])
    rotate([-25,0]) rotate([-90,0]) cylinder(d=35,h=20,$fn=40);
}
translate([0,0,mh]) difference() {
  cube([70,10,20]);
  translate([50,-5.01,0])
    rotate([-30,0]) rotate([-90,0]) translate([0,0,-5]) cylinder(d=30,h=20,$fn=30);
}
difference() {
  cube([10,10,70]);
  translate([-.01,5,20+(mh-40)/2+2]) rotate([0,90]) cylinder(d=4,h=10.02,$fn=20);
  translate([-.01,5,mh-(mh-40)/2-2]) rotate([0,90]) cylinder(d=4,h=10.02,$fn=20);
}
}
}