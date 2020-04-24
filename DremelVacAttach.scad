novac=1;
include<VacAttach.scad>;
translate([0,-15.5,-72]) import("MPCNC_525_-_Dremel_3000_Mount/files/Top_MPCNC_525_Dremel_3000_Mount.stl");
rotate([0,0,-170]) translate([30,0]) {
  difference() {
    union(){
      translate([0,-10]) cube([40,20,10]);
      translate([30,0]) cylinder(d=40,h=10,$fn=80);
      translate([45,-4]) cube([14,8,10]);
    }
    translate([30,0,-.01]) cylinder(d=36,h=15.02,$fn=70);
    translate([45,-2,-.01]) cube([20,4,20]);
    translate([55,-5,5]) rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
  }
  *%translate([30,0,50]) mirror([0,0,1]) rotate([0,0,-90]) vac5();
}