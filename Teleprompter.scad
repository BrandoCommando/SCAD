bw=153;
bh=118;
td=116;
thick=2.35;
bthick=7;
rr=3;
bd=80;
glassthick=3.2;
bd2=bd+thick*2;
lens_adapter_dias=[79.2,60,66];
lenspos=[bw/2+5,bh/2+.4+8];
lensod=52;
camoff=[0,-35,-57];
main();
!mirror([0,0,1])
  lens_attach();
//!rotate([90,0])
*cam_base();
*cam_prop();
*tripod_square_mount();
//!mirror([0,0,1])
  lens_adapter();
*rotate([-90,0])
  phone_holder();
*!phone_slide();
module cam_base()
{
  translate(lenspos) translate(camoff) rotate([90,0])
    union() {
      difference() {
      translate([bw*-.5,50,25]) {
        translate([-4,0]) cube([bw+8,6,15]);
        translate([0,0,8]) cube([bw,15,7]);
        for(x=[-10,bw-5]) translate([x,0,8]) {
          cube([15,123,7]);
          translate([x<0?0:8,0,-8]) cube([7,123,10]);
        }
      }
          rotate([-90,0]) translate([bw*-.5+5,-30,67])
      phone_holes();
    }
      difference() {
        union() {
          *cylinder(d=6.35,h=6,$fn=30);
          
          translate([-10,-30,25]) cube([20,85,15]);
        }
        translate([0,0,24]) {
          linear_extrude(17.2,convexity=4) hull() {
            translate([0,-20]) circle(d=7,$fn=40);
            translate([0,40]) circle(d=7,$fn=40);
          }
        }
      }
      *rotate([-90,0]) translate([bw*-.5+5,-30,67])
        phone_holes();

    }
}
module cam_prop()
{
  translate(lenspos) translate(camoff) rotate([90,0])
  {
    *%cylinder(d=6.35,h=10,$fn=40);
    translate([-20,-20]) difference() {
      translate([0,0,15])  cube([40,40,34]);
      translate([9,-.1,23]) cube([22,41,18]);
      for(z=[17.01,40.99]) translate([20,20,z]) rotate([0,0,30]) cylinder(d=13,h=6,$fn=6);
      translate([20,20,0]) cylinder(d=7,h=82,$fn=50);
      translate([20,34.2,15]) sphere(d=4,$fn=50);
    }
  }
}
module phone_holder()
{
  difference() {
    translate([10,-10,10]) 
      cube([bw-10,3,106]);
    translate([10+thick,-10.1,20])
      cube([bw-10-thick*2,2,86]);
    translate([20,-10.1,10+thick])
      cube([bw-30,2,106-thick*2]);
    translate([10,-.1,10]) phone_holes();
  }
}
module phone_slide()
{
 mirrorx(bw/2+5) translate([5.3,7.6,15]) {
     rotate([0,0]) linear_extrude(100) {
       *polygon([[0,thick*2-1.2],[5,thick*2-1.2],[5,0],[0,3]]);
       square([5,thick*2-1.2]);
     }
   }
   translate([10.3,1.8,7.4])
    difference() {
      cube([bw-10.3,5+thick*2-.4,107.6]);
      translate([10,-.1,5]) cube([bw-30.3,20,95]);
    phone_holes() translate([0,0,4]) {
      cylinder(d=4,h=20,$fn=24);
      translate([0,0,13]) cylinder(d=7,h=5,$fn=40);
    }
   }
}
module phone_holes(xo=0) {
for(x=[5-xo,bw-15.3+xo],z=[5,100]) translate([x,-12,z]) rotate([-90,0]) {
  if($children>0)
    children();
  else
    cylinder(d=4,h=16,$fn=24);
}
}
module lens_attach()
{
  od3=lens_adapter_dias[2];
  translate(lenspos) {
    difference() {
      union() {
        translate([0,0,-5]) cylinder(d=lens_adapter_dias[1]-.8,h=4.59,$fn=100);
        translate([0,0,-2.8]) cylinder(d=od3-.8,h=2.59,$fn=100);
        translate([od3*-.5+.4,0,-2.8]) cube([od3-.8,lens_adapter_dias[0]/2,2.59]);
      }
      translate([0,0,-5.1]) cylinder(d=lensod,h=3,$fn=100);
      translate([0,0,-2.11]) cylinder(d=lensod-3,h=5,$fn=100);
    }
  }
}
module lens_adapter()
{
  od1=lens_adapter_dias[0];
  od2=lens_adapter_dias[1];
  od3=lens_adapter_dias[2];
  adthick=4.99;
  if(false) {
    translate(lenspos)
    translate([0,0,-2]) intersection() {
      cylinder(d=od1,h=2,$fn=100);
      difference() {
        union() {
          cylinder(d=od3-.8,h=2,$fn=100);
          translate([od3*-.5+.4,0]) cube([od3-.8,od3,2]);
        }
        translate([0,0,-.1]) cylinder(d=od2,h=20,$fn=100);
      }
    }
  }
  if(true) {
  *%lens_attach();
  translate(lenspos) {
    intersection() {
      translate([0,0,-5.01]) {
        *cylinder(d=100,h=4.99,$fn=100);
      }
      difference() {
      union() {
        translate([0,0,-5]) cylinder(d=od1,h=adthick,$fn=100);
        translate([od1*-.5,0,-5]) cube([od1,od1/2,adthick]);
        *translate([0,0,thick+.2]) cylinder(d=bd2+thick*2,h=bthick,$fn=100);
      }
      translate([0,0,-5.1]) cylinder(d=od2,h=19,$fn=100);
      translate([od2*-.5,0,-5.1]) cube([od2,40,3]);
      translate([0,0,-3]) cylinder(d=od3,h=3,$fn=100);
      translate([od3*-.5,0,-3]) cube([od3,od3,3]);
      adapter_holes();
      translate([0,0,thick+.2]) linear_extrude(thick) difference() {
        circle(d=bd2+.4,$fn=100);
        circle(d=bd-.8,$fn=100);
      }
      translate([0,0,-.01]) cylinder(d=lensod-2.2,h=bthick+thick+2,$fn=100);
      cylinder(d=lensod,h=7,$fn=100);
    }
  }
  }
}
}
module tripod_square_mount() {
  difference() {
  rotate([0,0,45]) {
    cylinder(d1=30,d2=40,h=5,$fn=4);
    translate([0,0,5]) cylinder(d=40,h=2,$fn=4);
  }
  translate([0,0,-.01]) {
    cylinder(d=7,h=10,$fn=40);
    translate([0,0,1]) rotate([0,0,30]) cylinder(d=13,h=8,$fn=6);
  }
}
}
module adapter_holes() {
  od1=lens_adapter_dias[0];
  od2=lens_adapter_dias[1];
  od3=lens_adapter_dias[2];
  hox=(od1-(od1-od3)/2)/2;
  translate([hox,35,-5.2]) cylinder(d=3,h=20,$fn=20);
  translate([-hox,35,-5.2]) cylinder(d=3,h=20,$fn=20);
  for(r=[0,-45,-90,-135,180]) rotate([0,0,r]) translate([hox,0,-5.2]) cylinder(d=3,h=20,$fn=20);
}
module main() {
  od1=lens_adapter_dias[0];
  od2=lens_adapter_dias[1];
  od3=lens_adapter_dias[2];
difference() {
  translate([5-thick,0.1]) cube2([bw+thick*2,bh+3,td]);
  *translate([-.1,0]) rotate([45,0]) cube([180.2,180.2,150]);
  *translate([-.1,3,50]) rotate([30,0]) cube([180.2,180.2,1520]);
  translate([20,0,bthick]) cube([bw-30,7,150]);
  translate([10,10,bthick+5]) cube([bw-10,10,150]);
  translate([5,3,bthick]) difference() {
    cube([bw,4,150]);
    mirrorx(152.7/2) difference() {
      cube([20,4,9]);
      translate([10,-.1,8]) rotate([-90,0]) rotate([0,0,30]) cylinder(d=7.2,h=4,$fn=6);
    }
  }
  translate([10,0,10]) phone_holes(0);
  difference() {
    translate([5+thick,15,thick]) cube2([bw-thick*2,bh-12-thick,150]);
    *translate(lenspos) cylinder(d=bd2,h=bthick,$fn=100);
  }
  translate([5,10,6]) rotate([45,0]) translate([0,2.6]) cube([bw,bw,glassthick]); // main glass
  intersection() {
    difference() {
      translate([5,3,thick]) 
        cube([bw,bh-thick,150]);
      translate(lenspos) cylinder(d=bd2,h=bthick,$fn=100);
    }
    union() {
      translate([5,10,6]) rotate([45,0]) difference() {
        translate([0,2.6,-100]) cube([153,158,190]);
        *rotate([-45,0]) translate([0,bh-9.4,-6]) cube([bw+thick*2,thick,td-4.5]);
        translate([-1,-1,0]) mirror([0,0,1]) translate([0,2.6]) cube([bw+2,158,thick*2]);
        *translate([-1,-1,-101]) cube([155,155,80]);
        translate([-1,-20]) rotate([-45,0]) {
          *cube([155,11,150]);
          rotate([90,0]) rotate([0,90,0]) linear_extrude(155,convexity=5) {
            square([5,150]);
            //polygon([[0,0],[12,0],[12,28],[12,150],[0,150]]);
          }
        }
        translate([-1,-1,glassthick]) cube([155,155,thick*2]);
      }
    }
  } 
  translate(lenspos)
    adapter_holes();

  translate([0,0,-.1]) translate(lenspos) cylinder(d=lens_adapter_dias[1],h=20,$fn=100);
  *translate([5,4+thick,15]) cube([153,5,200]);
}
}

module cube3(dims,r=rr) {
  minkowski() {
    translate([r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]]);
    for(m=[0,1]) mirror([0,0,m]) cylinder(r1=r,r2=0,h=r,$fn=4);
  }
}

module cube2(dims,r=rr)
{
  linear_extrude(dims[2]) {
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=r*4);
  }
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}