part="combo";
include<Battery.scad>;

*pack(4,"AA");
block2("bottom");
translate([35,0,4]) rotate([0,0,180]) rotate([180,0]) translate([30,0,-10]) block2("top");
module block2(part="bottom")
{
translate([-20,0]) difference() {
  if(part=="bottom")
    cube([20,60.5,10]);
  else translate([0,0,9]) cube([20,60.5,5]);
  translate([5,34,10.01]) mirror([0,0,1]) rotate([0,0,90]) rotate([90,0]) translate([-6,-2,-4]) regulator();
  translate([8,10,5.5]) cube([5,25,5]);
  translate([6,10,-.01]) tinyswitch();
  translate([20.01,12.5,10]) rotate([0,-90,0]) cylinder(d=5,h=10,$fn=30);
  translate([0,0,-.01]) for(pos=[[4,4],[16,4],[3,57.5],[17,57.5]])
    translate(pos) cylinder(d=3,h=20,$fn=20);
}
}
*block("top");
*block("bottom");


module block(part="bottom")
{
translate(part=="bottom"?[0,0]:[-4,0,16]) rotate([0,part=="bottom"?0:180]) difference(){
  if(part=="bottom")
    translate([0,-1]) cube2([30,30,6],2);
  else
    translate([0,0,6]) cube2([30,30,10],2);
  translate([-.01,4,6]) rotate([0,90,0]) cylinder(d=4,h=8,$fn=40);
  for(x=[4,26]) translate([x,9,-.01]) cylinder(d=3,h=20,$fn=20);
  translate([2,2,-.01]) tinyswitch();
  regulator();
}
}

module tinyswitch()
{
    translate([1,1]) cube([7.2,2.5,2]);
    translate([0,0,1]) cube([9.2,4.5,11]);
}

module regulator()
{
  union(){
  translate([11.5,2,3.5]) cube([10,5.5,12]);
  translate([20.99,2,3.5]) cube([7,2.5,12]);
  translate([6,2,4.5]) cube([7,4.5,10]);
  }
}

module cube2(dims,r=1)
{
  linear_extrude(dims[2]) {
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=20);
  }
}