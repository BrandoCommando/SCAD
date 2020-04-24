part="stand";
pitch=-5; // Y Rotation
yaw=-8; // Y Rotation
oshpart="1";
include <OpenSourceGear.scad>;
if(part=="stand") stand();
else if(part=="bracket") rotate([-90,0]) bracket();
else if(part=="all") {
  color("blue") stand();
  color("green") bracket();
}
module stand(){
difference(){
  union(){
    translate([-20,-62,0]) mirror([0,1]) cube([40,10,35]);
translate([0,0,2]) rotate([yaw,0]) difference(){
  union(){
    translate([0,0,-10]) rotate([0,0,0]) scale([2.4,2.4,2.86]) osh_badge();
    for(m=[0,1]) mirror([m,0])
    translate([-60,-4.5,-5]) {
      cube([10,9,30]);
      translate([0,0,30]) rotate([0,15,0]) cube([10,9,10]);
    }
    translate([0,0,-10]) rotate([0,0,-120]) rotate_extrude(angle=60,$fn=100) { translate([34.2,0]) square([2,23]); }
    translate([-7.5,-65,-10]) cube([15,30.4,23]);
    translate([-20,-80,-10]) cube([40,17,45]);
  }
  translate([0,25,-.01]) cylinder(d=8,h=2.01,$fn=20);
  translate([0,0,1.01]) cylinder(d=69,h=12,$fn=200);
  translate([-4,-65.01,-10.01]) cube([8,32.01,20]);
  translate([-6.25,-49.01,2]) {
    translate([0,0,0]) cube([12.5,20.01,6]);
    translate([6.25,0,6]) rotate([-90,0]) scale([1,.6]) cylinder(d=12.5,h=16.01,$fn=30);
  }
}
}
  translate([-20.01,-68,-10]) mirror([0,1,0]) rotate([0,0]) cube(60);
translate([-60,-95,-30]) cube([120,200,30]);
translate([-.01,-66.01,-40]) rotate([90,0]) {
    *cylinder(d=117,h=2,$fn=200);
    translate([-20,0]) cube([110,90,2]);
  for(x=[-14,14],y=[45,55])
    translate([x,y,-8]) cylinder(d=3,h=10,$fn=20);
}
}
}
module bracket(){
translate([-.01,-66.01,-40]) rotate([90,0]) {
    *translate([30,-40]) cylinder(d=117,h=2,$fn=200);
  difference(){
    rotate([0,0,pitch]) {
      translate([-25,-20]) cube([120,65,4]);
      translate([-25,22,0]) cube([43,43,6]);
      intersection(){
        translate([-6,30,-24]) rotate([45,0]) cube([6,40,60]);
        translate([-6,22,0]) cube([6,50,50]);
      }
    }
    for(x=[-14,14],y=[45,55])
      translate([x,y,-3]) cylinder(d=3,h=10,$fn=20);
    translate([20,20,-.01]) rotate([0,0,-5]) cube([80,55,5.02]);
  }
}
}
