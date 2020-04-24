part="test";
gang=2;
thick=1.6;
split=8;
if(part=="main") {
  intersection() {
    translate([-26,-52]) cube([gang*46+thick*2,100+thick*2,50-split]);
    plugbox(0);
  }
} else if(part=="top") {
  intersection() {
    translate([-26,-52,50-split]) cube([gang*46+thick*2,100+thick*2,split]);
    plugbox(1);
  }
} else if(part=="sidehole") {
  //%plugbox(1);
  //translate([gang*46-23-thick*2,-37.5,14]) union()
  rotate([0,90]) {
    translate([2,0.5,0.5]) cube([1,74,27]);
    difference()
    {
      translate([3,-8,-4]) cube([1,91,36]);
    translate([0,-3.5]) {
    translate([0,82,14]) rotate([0,90,0]) translate([0,0,-10]) cylinder(d=3,h=30,$fn=20);
    translate([0,0,14]) rotate([0,90,0]) translate([0,0,-10]) cylinder(d=3,h=30,$fn=20);
    }
  }
  }
} else if(part=="test") {
  translate([-21.6,0.4]) plugbox();
//  import("Wally_PlugRocker2.stl");
}
module plugbox(mounts=1) {
difference(){
  union(){
    translate([-26,-52]) cube2([thick*2+(gang*46),100+thick*2,50],bottom=0);
    *translate([20,30,14]) rotate([0,90]) cylinder(d=28,h=20,$fn=60);
  }
  for(x=[-15+thick,15+((gang-1)*46)-thick*2],y=[-40,40])
    translate([x,y,-.01]) cylinder(d=3,h=5,$fn=20);
  translate([-26+thick,-52+thick,-.01]) mirrorx(-.5*(gang*46)) mirrory(-50) translate([4,4]) {
    cylinder(d=3,h=50.02,$fn=20);
    translate([0,0,46]) cylinder(d=6,h=4.02,$fn=30);
  }
  translate([-26+thick,-52+thick,2]) difference() {
    cube2([(gang*46),100,50],r=3);
    mirrory(-50) translate([gang*46,9.5,26]) rotate([0,-90,0]) linear_extrude(7) union() {
      circle(d=8,h=8,$fn=30);
      polygon([[0,-4],[-12,-4],[0,8]]);
    }
    mirrorx(-.5*(gang*46)) mirrory(-50) {
      difference() {
        union() {
          translate([4,4,-.01]) cylinder(d=8,h=50.02,$fn=30);
          translate([0,0,-.01]) cube([4,8,50.02]);
          translate([0,0,-.01]) cube([8,4,50.02]);
        }
        translate([4,4,-.02]) cylinder(d=3,h=50.04,$fn=20);
      }
    }
  }
  translate([13+((gang-1)*46),-37.5,14]) union() {
    cube([30,75,28]);
    translate([0,-3.5]) {
    translate([0,82,14]) rotate([0,90,0]) translate([0,0,-10]) cylinder(d=3,h=30,$fn=20);
    translate([0,0,14]) rotate([0,90,0]) translate([0,0,-10]) cylinder(d=3,h=30,$fn=20);
    }
  }
  if(gang>1)
    translate([23,40,20]) rotate([-90,0]) cylinder(d=23,h=20,$fn=50);
  *translate([19.99,30,14]) rotate([0,90]) cylinder(d=24,h=20.02,$fn=50);
}
if(mounts) intersection(){
  translate([-26+thick,-52+thick,thick]) cube([(gang*46),100,50],r=3);
translate([thick-2,thick-2]) for(m=[0,1]) mirror([0,m])
  for(gx=[0:gang-1]) translate([gx*46,0])
difference() {
  translate([-5,-55+thick/2,2]) 
    cube2([10,17,48],r=5,bottom=0);
  translate([0,-42,20]) cylinder(d=4,h=50,$fn=20);
}
}
}
module cube2(dims,r=5,top=0,bottom=0,$fn=20)
{
  if(bottom==0&&top==0)
    linear_extrude(dims[2],convexity=3) {
      for(x=[r,dims[0]-r],y=[r,dims[1]-r])
        translate([x,y]) circle(r=r,$fn=$fn);
      translate([r,0]) square([dims[0]-r*2,dims[1]]);
      translate([0,r]) square([dims[0],dims[1]-r*2]);
    }
  else
  intersection(){
    cube(dims);
    minkowski(){
      translate([r,r,bottom?r:0]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-(top?r:0)]);
      sphere(r=r,$fn=$fn);
    }
  }
}
module mirrorx(off=0)
{
  translate([-off,0]) for(m=[0,1]) mirror([m,0]) translate([off,0]) children();
}
module mirrory(off=0)
{
  translate([0,-off]) for(m=[0,1]) mirror([0,m]) translate([0,off]) children();
}