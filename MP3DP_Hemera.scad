xrod_cover_angle=240;
if(!part) {
  rotate([0,90]) XMod();
/*
*rotate([0,-90,0]) {
  translate([-10.55+2.5,-36.1,-5]) import("MP3DP_V2/files/X.STL");
  #translate([2.5,0,-5]) XMod();
    translate([10,-4,30]) rotate([0,90,0]) difference() {
    union() {
      *translate([230.75,-125]) import("Hemera_mk3_Adaptor.stl");
      linear_extrude(5) {
        difference() {
          union() {
            translate([-9.8,-12.4]) {
              square([45,45]);
              polygon([[0,45],[0,53],[14,53],[22,45]]);
              *polygon([[0,45],[0,53],[7,60],[31,60],[31,45]]);
            }
            translate([-42.25,-35]) hull() {
              circle(r=5,$fn=30);
              translate([0,17.6]) circle(r=5,$fn=30);
              translate([0,-5]) square([77.5,27.6]);
            }
          }
          #translate([-2.7,-27.5]) for(xi=[0,34],yi=[0,34]) translate([xi,yi]) circle(d=3.6,$fn=24);
          translate([-2.7,-27.5+64]) circle(d=3.6,$fn=24);
          *translate([-2.7,-27.5+34]) circle(d=3.2,$fn=24);
          *translate([-2.7+34,-27.5]) circle(d=3.2,$fn=24);
          *translate([-2.7+34,-27.5+34]) circle(d=3.2,$fn=24);
          translate([-39.25,-35]) circle(d=3,$fn=24);
          translate([-39.25,-17.35]) circle(d=3,$fn=24);
          translate([-29.9,-35.5]) hull() {
            circle(d=5,$fn=30);
            translate([25,0]) circle(d=5,$fn=30);
            translate([-2.5,-10]) square([30,1]);
          }
        }
      }
      translate([29.3,-47.5]) cube([20,15,21]);
      }
      translate([39.3,-50,12]) rotate([-90,0]) cylinder(d=11,h=30,$fn=40);
      translate([38,-50,-.01]) cube([2.6,20,10]);
      translate([60,-47.5+4,4]) rotate([0,-90]) cylinder(d=3,h=40,$fn=20);
    }
    
  %translate([22,0,-9.5])  rotate([90,0]) cylinder(d=11,h=51.5,$fn=40);
  }
  */
}
module XMod(yoff=7,gthick=3,xoff=10,zoff=9) {
  translate([7.94,-13.52,35+yoff]) mirror([0,1]) rotate([0,90]) difference() {
    translate([30,4,-10]) rotate([0,270]) translate([2.5,0,-5]) XMod_Main(yoff,gthick,xoff,zoff);
    translate([-3+yoff,-26.5+zoff,3]) mirror([0,0,1]) for(x=[0,34],y=[0,34]) translate([x,y]) {
      translate([0,0,-xoff]) cylinder(d=3.2,h=5+xoff,$fn=20);
      translate([0,0,3-xoff]) {
        cylinder(d=6,h=6+xoff,$fn=30);
        translate([0,0,6+xoff]) cylinder(d1=6,d2=3,h=5,$fn=30);
        translate([0,0,gthick]) rotate([0,0,-90]) linear_extrude(xoff,convexity=3) hull() {
          circle(d=6,$fn=30);
          translate([8,0]) circle(d=6,$fn=30);
        }
      }
    }
    }
}
module XMod_Main(yoff=0,gthick=3,xoff=4.7,zoff=0)
{
  difference() {
    union() {
      *translate([-3.5,-9]) cube([10,3.3,12.2]);
      *translate([2.7,-9]) cube([3,7,12.2]);
      *translate([-3.5,-4.1]) cube([10,2.8,12.2]);
      *for(z=[1.3:1.715:10]) translate([-3.5,-4.38,z]) {
        translate([0,0,0.025]) cube([10,1,.95]);
        translate([0,0,.5]) rotate([0,90]) cylinder(d=.95,h=10,$fn=20);
      }
      //23.1
      //#translate([-2.5,-1.25,15]) cube([7,2.5,18.1]);
      translate([0,0,4]) {
        for(z=[0,18]) translate([-2.5,-9,z+6]) cube([4,10.25,10]);
        translate([-2.5,-1.25,6]) cube([7.5,2.5,28]);
      }
      mirrory() translate([-.45,17.5,0]) difference() {
        off=(360-xrod_cover_angle)/2;
        union() {
          mirrory() translate([0,7.5]) mirror([1,0]) cube([6,gthick,50]);
          rotate([0,0,180+off]) rotate_extrude(angle=xrod_cover_angle,$fn=80) {
              square([7.5+gthick,50]);
          }
          for(r=[180-off,180+off]) rotate([0,0,r]) translate([7.5+gthick/2,0]) cylinder(d=gthick,h=50,$fn=30);
        }
      }
      // hemera protector
      translate([4.7,-35,-yoff]) rotate([0,90,0]) rotate([0,0,90]) linear_extrude(2.4+gthick+xoff,convexity=3) difference() {
        translate([26,37]) hull() {
          for(x=[5,15],y=[29,-32+yoff]) translate([x,y]) circle(r=5,$fn=40);
          square([20,14]);
        }
        for(x=[-6.25,6.25]) translate([26+10+x,37+29-5]) circle(d=2.6,$fn=20);
      }
      translate([4.7,-35,-yoff]) rotate([0,90]) rotate([0,0,90]) linear_extrude(xoff+gthick+2.4,convexity=3) {
        translate([18-8,yoff]) square([35+16,50]);
      }
      translate([4.7+xoff,-35+zoff,-yoff]) rotate([0,90,0]) rotate([0,0,90]) linear_extrude(2.4+gthick,convexity=3)
        translate([0,0]) hull() {
          r=4;
          for(x=[r,42.5-r],y=[r,42.5-r])
            translate([x,y]) circle(r=r,$fn=30);
          *translate([10,0]) square([34,42]);
        }
      }
      mirrory() for(z=[2.5,21,40]) {
        translate([-5,6,z]) cube([9.7,2,6]);
        translate([10,35/2,z]) cube([3,18,6]);
      }
      mirrory() translate([-.45,17.5]) rotate_extrude($fn=100,convexity=3) {
        for(y=[2.5,21,40])
        translate([7.5+.01+gthick,y]) square([3,6]);
      }
    
    *translate([-2.5+7,-1.26,15]) rotate([0,-44]) mirror([1,0])  cube([8,2.7,18.1]);
    mirrory() translate([-.45,17.5,-.01]) {
      translate([0,0,.99]) cylinder(d=15,h=51,$fn=80);
      cylinder(d=14,h=1,$fn=50);
    }
  }
}
module mirrory(off=0)
{
  translate([0,off/-2]) for(m=[0,1]) mirror([0,m]) translate([0,off/2]) children();
}