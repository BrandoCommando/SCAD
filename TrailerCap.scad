part=1;
include <OpenSourceGear.scad>
intersection(){
  translate([0,0,20]) cylinder(d=50,h=10,$fn=30);
difference(){
  cylinder(d=48,h=30,$fn=100);
  translate([0,0,-.01]) {
    translate([0,0,2]) minkowski(){
      translate([0,0,5]) cylinder(d=33,h=30.02,$fn=100);
      sphere(r=5,$fn=50);
    }
    translate([0,0,2]) intersection(){
      minkowski(){
        translate([0,0,5]) cylinder(d=35,h=30.02,$fn=100);
        sphere(r=5,$fn=50);
      }
      translate([-7,-25]) cube([14,30,30.02]);
    }
  scale([0.5,0.5,0.1]) osh_badge();
  }
}
*cylinder(d=48,h=2,$fn=100);
}