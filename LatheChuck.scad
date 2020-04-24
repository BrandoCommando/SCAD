
*!intersection() {
  translate([-160,250]) rotate([90,0]) import("Fully_3D-printable_wind-up_car_gift_card 2/files/old_gift_card_1.stl");
  translate([5.25,34,0]) cylinder(d=17,h=10,$fn=50);
}
base_maxd=25.4*4.6;
base_dists=[60,base_maxd];
*rotate([0,0,0]) rotate_extrude(angle=120) translate([0,12]) square([51,8]);
*chuck();
*jaw(h=14,deep=20,holes=2);
*for(r=[0:120:359]) rotate([0,0,r])
*translate([21,0,14]) 
  rotate([180,90]) rotate([0,0,90]) jaw(deep=20,holes=2);
*base();
jig();

skip_jaw=1;
include <QRClamp.scad>;

module jig() {
  for(r=[0:120:359]) rotate([0,0,r]) {
    difference() {
      intersection() {
        rotate([90,0]) translate([0,5.7,10]) groove_clamp(40,extrusion_size/2 - extrusion_groove_lip/2);
        translate([-10,-40]) cube([20,40,6]);
      }
      for(y=[-10,-25]) translate([0,y,-.01]) cylinder(d=3,h=10,$fn=20);
    }
  }
}
module base() {
  difference() {
    union() {
      cylinder(d=inches(1.125),h=20,$fn=50);
      linear_extrude(4,convexity=4) {
        difference() {
          union() {
            for(d=base_dists)
              difference() {
                circle(d=d,$fn=100);
                circle(d=d-10,$fn=100);
              }
            for(r=[0:120:359]) rotate([0,0,r]) translate([0,-2.5]) square([base_maxd/2,5]);
              
            for(d=base_dists,r=[0:120:359]) rotate([0,0,r]) translate([d/2-2.5,0]) circle(d=12,$fn=40);
          }
          for(d=base_dists,r=[0:120:359]) rotate([0,0,r]) translate([d/2-2.5,0]) circle(d=5,$fn=30);
        }
      }
    }
    translate([0,0,2])
      cylinder(d=inches(1/2),h=20,$fn=50);
    rotate([0,0,60]) translate([0,0,14]) for(r=[0:120:359]) rotate([0,0,r]) rotate([0,90]) {
      cylinder(d=3,h=20,$fn=20);
      translate([-13.5,-3.5,8]) cube([17,7,3]);
    }
  }
}
module chuck() {
  difference() {
    union() {
      cylinder(d=100,h=20,$fn=100);
    }
    for(off=[5:2.5:50]) rotate_extrude($fn=100) {
      w=off%10==0?1:.2;
      translate([off-w/2,19.6]) square([w,1.01]);
    }
    for(r=[0:120:359]) rotate([0,0,r]) {
      translate([0,0,14]) rotate([0,90]) rotate([0,0,90]) linear_extrude(50.01) {
        keyhole_profile();
  //      translate([0,-4]) square([4,8]);
        
      }
    }
    translate([0,0,-.01]) {
      cylinder(d=inches(1/2)+.2,h=5,$fn=40);
      translate([0,0,4.99])
        cylinder(d1=inches(1/2)+.2,d2=inches(1/2)-2,h=2,$fn=40);
    }
    *translate([0,0,10]) cylinder(d=inches(3/4)/cos(30),h=10.02,$fn=6);
  }
}
module jaw(h=10,deep=16,holes=2)
{
  difference() {
    union() {
      translate([0,5.7,10]) groove_clamp(20,extrusion_size/2 - extrusion_groove_lip/2);
      linear_extrude(deep,convexity=3) {
        translate([-1.8,5.6]) square([3.6,4]);
        translate([-5,6.2]) square([10,h]);
        *offset(-.2) keyhole_profile();
      }
    }
    mirrorx() translate([1,0,deep]) rotate([0,30]) cube(h+8);
    if(holes>0)
    for(z=[(deep-6)/holes/2:(deep)/holes:deep])
    translate([0,0,z]) rotate([-90,0])
      cylinder(d=3,h=7+h,$fn=20);
    
  }
}
module keyhole_profile()
{
  polygon([[-4,0],[-4,2],[-2,4],[-2,6.01],[2,6.01],[2,4],[4,2],[4,0]]);
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