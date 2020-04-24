part="motor";
show_mods=0;
if(part=="motor") {
translate([0,0,0]) {
translate([-240,-240,0]) import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/Roller_Motor_Mount.STL");
translate([-4,48]) {
  intersection(){
    translate([0,-2]) cube([8,10,31]);
    translate([0,-2]) rotate([-10,0]) cube([8,10,30]);
    translate([0,0,-10]) rotate([10,0]) cube([8,10,36]);
  }
  translate([4,28,0]) intersection() {
    cylinder(d=60,h=30,$fn=60);
      translate([0,-9]) rotate([10,0]) translate([0,0,-4]) rotate([0,0,130]) rotate_extrude(angle=280,$fn=50) {
      translate([10,0]) square([2,34]);
    }
  }
}
}
}
if(part=="mod1"||part=="mod2")
{
  mods();
} else if(show_mods) #mods();
if(part=="zmotor")
{
translate([0,0,0])
{
translate([-105,-146.63,0]) import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/C-Z-Motor.STL");
*rotate([0,0,-30]) translate([0,120,0]) rotate([0,0,15]) {
  difference() {
    union(){
      cylinder(d=54,h=10,$fn=80);
      translate([-3,-80,0]) cube([6,80,10]);
      translate([-5,20]) cube([10,16,10]);
    }
    translate([0,0,-.01]) cylinder(d=50,h=10.02,$fn=70);
    translate([-2.5,20,-.01]) cube([5,20,20]);
    translate([-6,31,5]) rotate([0,90]) cylinder(d=3,h=20,$fn=20);
  }
}
}
}

module mods() {
union(){
translate([-34.83,11.75]) {
  if(part!="mod2")
  {
    cylinder(d=25,h=12,$fn=70);
  *rotate([0,0,195]) translate([14,-8,0]) cube([8.6,16,12]);
  }
  else {
  rotate([0,0,195]) translate([18,8,6]) rotate([90,0]) cylinder(d=10,h=16);
  }
}
mirror([1,0]) translate([-34.83,11.75]) {
  if(part!="mod2")
  {
    cylinder(d=25,h=12,$fn=70);
  *rotate([0,0,195]) translate([14,-8,0]) cube([8.6,16,12]);
  }
  else {
  rotate([0,0,195]) translate([18,8,6]) rotate([90,0]) cylinder(d=10,h=16);
  }
}
if(part!="mod2") {
translate([0,11.8]) cylinder(d=4,h=6,$fn=20);
translate([21.9,-10.1]) cylinder(d=4,h=6,$fn=20);
translate([-21.9,-10.1]) cylinder(d=4,h=6,$fn=20);
}
}
}