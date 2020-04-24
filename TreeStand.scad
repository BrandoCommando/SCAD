trunk_diameter = 17;

part=1;
include <OpenSourceGear.scad>;

difference(){
translate([14,0]) leg();
  translate([30,-2,10]) rotate([90,0])  scale([0.3,0.3,1]) osh_badge();
}
rotate([0,0,90]) translate([14,0]) leg();
rotate([0,0,180]) translate([14,0]) leg();
rotate([0,0,270]) translate([14,0]) leg();
difference(){
  cylinder(d=30,h=30,$fn=50);
  translate([0,0,5]) cylinder(d=trunk_diameter,h=30,$fn=40);
  translate([0,0,25]) rotate([0,0,45]) rotate([0,90]) cylinder(d=3,h=20,$fn=20);
}

module leg() {
  rotate([90,0]) translate([0,0,-2.5]) linear_extrude(5) polygon([[0,0],[0,30],[5,30],[50,10],[60,4],[60,0]]);
  translate([0,2.5,0]) linear_extrude(30) polygon([[0,0],[0,3],[5,0],[5,-5],[0,-8]]);
  translate([55,0]) cylinder(d=20,h=4,$fn=30);
}