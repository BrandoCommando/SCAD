mw=34;
mh=12;
part="main";
oshpart=part;
include <OpenSourceGear.scad>
if(part=="main"||part=="all")
  key_main();
if(part=="back")
  rotate([-90,0])
    key_back();
else if(part=="all")
  translate([0,0,10]) key_back();
module key_back(){
  difference(){
  translate([3,mh-1.5,6.7]) linear_extrude(34.5,convexity=3) polygon([[-2,0],[-2,-1],[-.5,-1],[0,0],[2,1],[mw-8,1],[mw-6,0],[mw-5.5,-1],[mw-4,-1],[mw-4,0],[mw-6,1.5],[mw-7,2.5],[1,2.5],[0,1.5]]);
      translate([mw/2,mh,25]) rotate([90,0]) scale([.4,.4,.1]) osh_badge();
  }
  translate([1,1.5,39]) difference() {
    linear_extrude(2) polygon([[0,1],[1,0],[mw-3,0],[mw-2,1],[mw-2,mh-10],[mw-3,mh-10],[mw-3,2],[mw-4,1.5],[2,1.5],[1,2],[1,mh-10],[0,mh-10]]);
    *translate([1.5,-.8,-1]) rotate([-45,0]) cube([mw-5,4,4]);
    translate([-.01,-.8,-1]) rotate([-45,0]) cube([mw,4,4]);
  }
translate([0,0,46.8]) mirror([0,0,1]) difference() {
  union(){
    translate([0,0,-2]) cube2([mw,mh+1,4],left=1,right=1,front=1,back=1,bottom=1,curve=2);
    translate([0,0,2]) cube2([mw,mh+1,4],left=1,right=1,front=1,back=1);
  }
  rotate([-90,0]) translate([mw/2-14,-4,-.01]) linear_extrude(mh+1.02) polygon([[2,-1],[2,1],[5,3],[23,3],[26,1],[26,-1]]);
  translate([mw*.5,0]) for(m=[0:1]) mirror([m,0]) translate([mw*-.5,0]) {
  translate([-.01,6.5,4]) rotate([0,90,0]) cylinder(d=6,h=1,$fn=20);
   translate([-.02,3.5,4]) cube([1,6,3]);
  translate([-.01,6.5,4]) rotate([0,90]) cylinder(d=2,h=5,$fn=12);
  }
}
translate([0,0,-1]) difference(){
  *translate([mw/2-5.8,mh-.6,3.2]) cube([11.6,1.6,4]);
  union(){
  translate([mw/2-5.4/2,mh-.5,5]) cube([5.4,1.51,3.5]);
  translate([mw/2,mh-.5,5]) rotate([-90,0]) cylinder(d=5.4,h=1.51,$fn=20);
  }
  translate([mw/2,3,5]) rotate([-90,0]) {
    cylinder(d=2,h=10,$fn=20);
    translate([0,0,8.2]) cylinder(d1=2,d2=4,h=2,$fn=30);
  }
}
*translate([mw/2,4,45.8]) difference() {
rotate([-90,0]) scale([1.5,1]) {
  difference() {
      union(){
        //cylinder(d1=9,d2=10,h=.5,$fn=50);
        translate([0,0,0]) cylinder(d=10,h=7,$fn=50);
        //translate([0,0,2.5]) cylinder(d1=10,d2=9,h=.5,$fn=50);
      }
      //translate([0,0,-.01]) cylinder(d1=9,d2=8,h=.52,$fn=40);
      translate([0,0,-.01]) cylinder(d=8,h=7.02,$fn=40);
      //translate([0,0,2.49]) cylinder(d1=8,d2=9,h=.52,$fn=40);
  }
}
  translate([-10,2,5]) rotate([-45,0]) cube([20,30,30]);
  translate([-10,-0,0]) rotate([75,0]) cube([20,30,30]);
}
}
module key_main() {
difference(){
  cube2([mw,mh+1,6.49],r=2,bottom=1,left=1,right=1,front=1,back=1,curve=6);
  translate([mw/2-9.3/2,mh/2-3.3/2,-.01]) cube([9.3,3.3,6.02]);
  translate([mw/2-16/2,mh/2-3.3/2,2.4]) cube([16,3.3,10]);
  translate([mw/2-19.6/2,mh/2-3.3/2,3]) cube([19.6,3.3,10]);
  translate([5.6,2,5.5]) rotate([-90,0]) cylinder(d=5,h=8,$fn=20);
  translate([mw/2-3,mh-1.5,4]) cube([6,2.51,3.5]);
  translate([mw/2,mh-1.5,4]) rotate([-90,0]) cylinder(d=6,h=2.51,$fn=20);
  translate([mw/2,3,4]) rotate([-90,0]) cylinder(d=2,h=10,$fn=20);
}
*translate([mw/2-6,mh-1.5,6.5]) cube([12,1.5,10]);
translate([0,1.5,6.49]) rotate([90,0]) translate([31,0])
  linear_extrude(1.5) mirror([1,0]) front_face();
difference(){
  union(){
  translate([0,0,6.49]) cube2([3,mh+1,34.1],left=1,front=1,back=1);
  translate([mw-3,0,6.49]) cube2([3,mh+1,34.1],right=1,front=1,back=1);
  }
  translate([1.4,1.5,6.48]) difference() {
    cube2([mw-1.4*2,mh-1.5*2+1.5,34.12],r=1,left=1,right=1,front=1,back=1);
    translate([mw/2-1.4,0]) for(m=[0,1]) mirror([m,0]) translate([mw/-2+1.4,0]) translate([0,0]) {
      rotate([-90,0]) translate([0,0,-1]) linear_extrude(8.8) hull() {
        circle(d=5,$fn=20);
        translate([-1,-10]) circle(d=3,$fn=20);
      }
    }
    
  }
}
  translate([mw*.5,0,47]) mirror([0,0,1]) for(m=[0:1]) mirror([m,0]) translate([mw*-.5,0]) {
    difference(){union(){
  translate([-.6,6.5,4]) rotate([0,90,0]) cylinder(d=6,h=2,$fn=20);
   translate([0,4,4]) cube([1.4,5,3]);
    }
  translate([-1,6.5,4]) rotate([0,90]) cylinder(d=2,h=5,$fn=12);
  }
  }
}
module cube2(dims,r=2,bottom=0,top=0,left=0,right=0,front=0,back=0,curve=0) {
  intersection(){
    cube(dims);
    dx=dims[0] - (left ? r : 0) - (right ? r : 0);
    dy=dims[1] - (front ? r : 0) - (back ? r : 0);
    dz=dims[2] - (top ? r : 0) - (bottom ? r : 0);
    minkowski(){
      if(curve)
        translate([left?r:0,front?r:0,bottom?r:0]) translate([0,dy]) rotate([90,0]) linear_extrude(dy) polygon([[curve,0],[dx-curve,0],[dx,dz],[0,dz]]);
      else
        translate([left?r:0,front?r:0,bottom?r:0]) cube([dims[0]-(left?r:0)-(right?r:0),dims[1]-(front?r:0)-(back?r:0),dims[2]-(bottom?r:0)-(top?r:0)]);
      sphere(r=r,$fn=30);
    }
  }
}
module front_face() {
clr=1.1;
scale(28/48.3)
difference(){
  translate([-1,0]) square([50,59.1]);
  translate([24.87,13.2]) circle(d=clr*19.8,h=2.02,$fn=40);
  translate([9.5,33.5]) circle(d=clr*16.24,h=2.02,$fn=30);
  translate([48.3-8.5,34.5]) circle(d=clr*16.2,h=2.02,$fn=30);
  translate([24.745-25.634/2,49.364-7/2]) {
    translate([3.8,0-.5])
      square([clr*.9*(25.634-7.868),clr*.99*8]);
    translate([3.8,3.8]) circle(d=clr*8);
    translate([25.634-3.8,3.8]) circle(d=clr*8);
  }
  translate([9.8,9.743]) circle(d=clr*5.8,h=2.02,$fn=20);
}
}