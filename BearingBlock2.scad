cdist=inches(3);
rtan=16;
rmotor=-90;//-25.25;
showmotor=1;
holemode=3;
skip_jaw=1;
include <QRClamp.scad>;
*import("BearingBlock_Take4.stl");
echo(str("Rot: ",rtan));
*%for(x=[-20,0,20,40]) translate([x,-cdist-10]) {
  linear_extrude(200) difference() {
    hull() {
      mirrorx() mirrory() translate([8,8]) circle(r=2,$fn=30);
    }
    for(r=[0:90:359]) rotate([0,0,r]) translate([-2,5]) {
      square([4,5.01]);
      translate([-1,1.5]) hull() {
        circle(r=1.5,$fn=30);
        translate([6,0]) circle(r=1.5,$fn=30);
      }
    }
    circle(d=5,$fn=30);
  };
}
//translate([-10,0,cdist]) rotate([90,0,90])
if(showmotor)
  %translate([0,0,-14]) import("GregLGear45HIAcrylic.stl");
%cylinder(d=inches(1/2),h=inches(3),$fn=50);
if(showmotor)
%rotate([0,0,rmotor]) translate([39.7055,0,-10]) {
  translate([0,0,24]) rotate([0,0,-rmotor]) difference() {
    translate([-21.15,-21.15]) cube(42.3);
    mirrorx() mirrory() translate([15.5,15.5,-.01]) cylinder(d=3,h=6,$fn=20);
  }
  mirror([0,0,1]) rotate([0,0,7]) import("GregSGear9.stl");
}
difference() {
  union() {
    cylinder(d=inches(1.5),h=10,$fn=100);
    linear_extrude(10,convexity=3) difference() {
      //hull()
      union() {
        circle(d=inches(1.5),$fn=100);
        translate([-10,-cdist]) square([20,cdist]);
        hull() {
          mirrory(-cdist-cdist+21) mirrorx() translate([-28,-cdist+2]) circle(d=4,$fn=30);
        }
      }
      *circle(d=inches(1.125),$fn=80);
      *mirrorx() hull() {
        translate([6,-cdist+8]) square([inches(.625),16]);
        rotate([0,0,-rtan]) translate([inches(1.25/2),0]) square([5,10]);
      }
    }
    if(holemode==3)
    {
      for(x=[-20,0,20])
      translate([x,-cdist,10]) intersection() {
        groove_clamp(20,extrusion_size/2 - extrusion_groove_lip/2);
        translate([-10,-10,-10]) cube([20,10,x==0?10:20]);
      }
      mirrorx() translate([10.01,-cdist]) cube([19.98,17,20]);
    }
  }
  if(holemode==3)
    mirrorx() translate([20,-cdist,10]) {
      cam_sub(20);
      cam_ramp();
      *mirrorx() translate([-10,-.01,0]) cube([7.1,9.02,10.02]);
    }
  if(showmotor)
  rotate([0,0,rmotor]) translate([39.7055,0,-.01]) {
    cylinder(d1=24,d2=20,h=10.02,$fn=50);
    for(m=showmotor==1?[0:1]:[0]) mirror([m,0]) mirrory() translate([-15.5,15.5]) cylinder(d=3,h=20,$fn=20);
  }
  translate([0,0,2]) cylinder(d=inches(1.125)+.2,h=8.01,$fn=80);
  *translate([0,0,7.98]) cylinder(d1=inches(1.125)+.2,d2=inches(1),h=1,$fn=80);
  translate([0,0,-.01]) cylinder(d=inches(1),h=10.02,$fn=100);
  for(x=[-20,0,20])
  translate([x,-cdist-.01,5]) {
    if(holemode==1)
      rotate([-90,0]) {
        cylinder(d=3.4,h=15.02,$fn=20);
        boltlen=14;
        anglez=18;
        angler=30;
        translate([0,0,boltlen-6]) cylinder(d=8,h=anglez+.02,$fn=30);
        if(x!=0||!showmotor)
        translate([0,0,boltlen+anglez-6.99]) rotate([x==0?-angler:0,x<0?-angler:(x>0?angler:0),0]) {
          sphere(d=8,$fn=30);
          cylinder(d1=8,d2=8,h=20,$fn=30);
        }
        *translate([0,0,25]) cylinder(d1=8,d2=5,h=20,$fn=30);
        *mirror([x<0?1:0,0]) translate([-4,-8,5]) {
          cube([18,8,50]);
          translate([4,4]) cube([18,8,50]);
        }
      }
    else if(holemode==2)
    {
      translate([0,1.5]) mirrory(17) hull() {
        translate([-2,0,3]) {
          translate([1.5,1.5]) cylinder(d=3,h=2.02,$fn=20);
          translate([3,1.5]) cylinder(d=3,h=2.02,$fn=20);
          //cube([4,3,2.02]);
        }
      }
      translate([0,10,-5.01]) cylinder(d=5,h=20,$fn=20);
    }
  }
}

module bolt(bd=8,hd=14.6,h=30)
{
  cylinder(d=hd,h=hd/3,$fn=6);
  translate([0,0,hd/3-.01])
    cylinder(d=bd,h=h,$fn=40);
}
module mirrorx(off=0)
{
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off=0)
{
  translate([0,off/2,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,off/-2,0]) children();
}
module mirrorz(off=0)
{
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/-2]) children();
}
function inches(in) = 25.4*in;