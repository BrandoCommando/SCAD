cdist=inches(2.4);
rtan=16;
rmotor=-90;//-25.25;
bearing_yplay=0.001;
bearing_yoff=67;
showmotor=1;
holemode=1;
skip_jaw=1;
include <QRClamp.scad>;
bearing_case2d(0);
*import("BearingBlock_Take4.stl");
echo(str("Rot: ",rtan));
*!bighold2d();
*%for(x=[-20,0,20,40]) translate([x, -cdist-10]) {
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
*if(showmotor)
  %translate([0,0,-14]) import("GregLGear45HIAcrylic.stl");
*%cylinder(d=inches(1/2),h=inches(3),$fn=50);
*if(showmotor)
%rotate([0,0,rmotor]) translate([39.7055,0,-10]) {
  translate([0,0,24]) rotate([0,0,-rmotor]) difference() {
    translate([-21.15,-21.15]) cube(42.3);
    mirrorx() mirrory() translate([15.5,15.5,-.01]) cylinder(d=3,h=6,$fn=20);
  }
  mirror([0,0,1]) rotate([0,0,7]) import("GregSGear9.stl");
}
*if(bearing_yplay)
{
  translate([60,0]) difference() {
    linear_extrude(2) difference() {
      hull() {
        for(y=[0,bearing_yplay]) translate([0,bearing_yoff+y]) circle(d=inches(1.5)+8,$fn=100);
        }
      hull() {
        for(y=[0,bearing_yplay]) translate([0,bearing_yoff+y]) circle(d=inches(1),$fn=80);
      }
      mirrorx() translate([inches(1.125)/2+4,bearing_yoff+bearing_yplay/2,-.01]) {
          circle(d=3,h=10.02,$fn=20);
        }
        translate([0,bearing_yoff,-.01]) mirrory(bearing_yplay) for(r=[-45,-135]) rotate([0,0,r]) translate([inches(1.125)/2+4, 0]) {
          circle(d=3,h=10.02,$fn=20);
        }
    }
  }
}
module main_block() {
difference() {
  union() {
    *cylinder(d=inches(1.5),h=10,$fn=100);
    linear_extrude(10,convexity=3) bearing_case2d();
    if(holemode==3)
    {
      for(x=[-20,0,20])
      translate([x,-cdist,10]) intersection() {
        groove_clamp(20,extrusion_size/2 - extrusion_groove_lip/2);
        translate([-10,-10,-10]) cube([20,11,x==0?10:20]);
      }
      mirrorx() translate([10.01,-cdist]) cube([19.98,17,20]);
    }
    if(bearing_yplay)
      translate([-6,16+bearing_yoff+bearing_yplay]) cube([12,6,10]);
  }
  if(holemode==3)
    mirrorx() translate([20,-cdist,10]) {
      cam_sub(20);
      mirrorx() translate([-10,-.01,0]) cube([7.1,9.02,10.02]);
    }
  if(bearing_yplay)
  {
    bearing_holes();
    mirrory(bearing_yoff+bearing_yplay) {
      translate([-3,-19.4,3]) cube([6,2.8,8.01]);
      translate([0,-30,6]) rotate([-90,0]) {
        cylinder(d=3,h=40,$fn=20);
        translate([0,0,-10]) cylinder(d=8,h=18,$fn=40);
        translate([-4,-4.01,-10]) cube([8,4.01,18]);
      }
    }
  }
  if(showmotor)
  rotate([0,0,rmotor]) translate([39.7055,0,-.01]) {
    cylinder(d=26,h=20.02,$fn=50);
    for(m=showmotor<3?[0:1]:[0]) mirror([m,0]) mirrory() translate([-15.5,15.5]) {
      cylinder(d=3,h=20,$fn=20);
      if(!m)
      translate([0,0,6]) cylinder(d=8,h=4.02,$fn=40);
    }
  }
  translate([0,0,2]) linear_extrude(8.01) hull() for(y=[0,bearing_yplay]) translate([0,bearing_yoff+y]) circle(d=inches(1.125)+.2,h=8.01,$fn=80);
  *translate([0,0,7.98]) cylinder(d1=inches(1.125)+.2,d2=inches(1),h=1,$fn=80);
  translate([0,0,-.01]) linear_extrude(10.02) hull() for(y=[0,bearing_yplay]) translate([0,bearing_yoff+y]) circle(d=inches(1),h=10.02,$fn=100);
  for(x=[-20,0,20])
  translate([x,-cdist-.01,5]) {
    if(holemode==1)
      rotate([-90,0]) {
        cylinder(d=3.4,h=15.02,$fn=20);
        boltlen=14;
        anglez=18;
        angler=30;
        translate([0,0,boltlen-6-(x==0?4:0)]) cylinder(d=8,h=anglez+.02,$fn=30);
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
      translate([0,10,-5.01]) cylinder(d=3,h=20,$fn=20);
    }
  }
}
}
module bighold2d()
{
  hex=0;
  translate([0,bearing_yoff]) difference() {
    circle(d=70,$fn=100);
    circle(d=inches(1.125)-.1,$fn=90);
    for(r=[0:45:359]) rotate([0,0,r]) translate([30,0]) circle(d=3,$fn=20);
      mirrorx() translate([inches(1.125)/2+4,bearing_yplay/2]) {
      if(!hex)
        circle(d=3,h=10.02,$fn=20);
      else
        rotate([0,0,30]) {
          circle(d=7.2,h=3,$fn=6);
        }
      }
      mirrory(bearing_yplay) for(r=[-45,-135,90]) rotate([0,0,r]) translate([inches(1.125)/2+4, 0]) {
      if(!hex)
        circle(d=r==90?4:3,h=10.02,$fn=20);
      else
        rotate([0,0,30]) {
          circle(d=7.2,h=3,$fn=6);
        }
    }

  }
}
module bearing_holes()
{
  mirrorx() translate([inches(1.125)/2+4,bearing_yoff+bearing_yplay/2,-.01]) {
          cylinder(d=3,h=10.02,$fn=20);
          rotate([0,0,30]) {
            cylinder(d=7.2,h=3,$fn=6);
            translate([0,0,3]) cylinder(d1=7.2,d2=3,h=2,$fn=6);
          }
        }
        translate([0,bearing_yoff,-.01]) mirrory(bearing_yplay) for(r=[-45,-135]) rotate([0,0,r]) translate([inches(1.125)/2+4, 0]) {
          cylinder(d=3,h=10.02,$fn=20);
          rotate([0,0,30]) {
            cylinder(d=7.2,h=3,$fn=6);
            translate([0,0,3]) cylinder(d1=7.2,d2=3,h=2,$fn=6);
          }
        }
}
module bearing_holes2d(hex=0,ythru=0,wide=0)
{
  if(bearing_yplay) {
    mirrorx() translate([inches(1.125)/2+4,bearing_yoff+bearing_yplay/2]) {
      if(!hex)
        *circle(d=3,h=10.02,$fn=20);
      else
        rotate([0,0,30]) {
          circle(d=7.2,h=3,$fn=6);
        }
      }
    translate([0,bearing_yoff]) //mirrory(bearing_yplay)
      for(r=[0:45:350],r2=[0:30]) rotate([0,0,r+r2]) translate([inches(1.125)/2+4, 0]) {
      if(!hex)
        circle(d=3,h=10.02,$fn=20);
      else
        rotate([0,0,30]) {
          circle(d=7.2,h=3,$fn=6);
        }
    }
  }
  hull() for(y=[0,bearing_yplay]) translate([0,bearing_yoff+y]) circle(d=inches(1.125-(hex?.125:0))-.1,h=8.01,$fn=80);
  if(bearing_yplay>0.1)
  {
    mirrory(bearing_yoff+bearing_yplay) {
      if(ythru)
        translate([-1.5,0]) square([3,32]);
      translate([-3,-19.4]) square([6,2.8]);
      translate([0,-30]) {
        translate([-4,-10.01]) square([8,18]);
      }
    }
  }
  if(showmotor)
  rotate([0,0,rmotor]) translate([39.7055,0]) {
    circle(d=23,h=20.02,$fn=50);
    for(m=showmotor<3?[0:1]:[0]) mirror([m,0]) mirrory() translate([-15.5,15.5]) {
      circle(d=3,h=20,$fn=20);
    }
  }
  if(wide)
  for(x=[-25,25],y=[-50,-30]) translate([x,y]) circle(d=3,$fn=20);
}
module bearing_case2d(hex=0,wide=0)
{
  difference() {
    union() {
      //hull() {
        translate([0,bearing_yoff+bearing_yplay]) circle(d=inches(1.5)+(bearing_yplay?8:0),$fn=100);
        translate([-inches(.75)+4,-cdist+38]) square([inches(1.5)-8,cdist+28]);
      //}
      hull() {
        mirrorx() translate([wide?-28:inches(.75)-2,-cdist+2]) {
          for(y=[2,37]) translate([0,y]) circle(d=6,$fn=30);
          
        }
        //translate([-30,-cdist]) square([60,8]);
        //translate([-10,-cdist]) square([20,cdist]);
      }
    }
      *circle(d=inches(1.125),$fn=80);
      *mirrorx() hull() {
        translate([6,-cdist+8]) square([inches(.625),16]);
        rotate([0,0,-rtan]) translate([inches(1.25/2),0]) square([5,10]);
      }
      bearing_holes2d(hex,wide=wide);
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
