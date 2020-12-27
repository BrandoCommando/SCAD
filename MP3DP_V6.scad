yoff=-3; //7
xoff=5; //10
zoff=10; //9
gthick=3;
xrod_cover_angle=230;
if(!part) {
  *translate([-78,-8,-2]) rotate([0,-90]) import("Hemera-BlTouch-FanBracket.stl");
  *#translate([-8,-8,1.65]) rotate([0,-90]) import("Hemera-BlTouch-FanBracket.stl");
  %translate([-.5,-55.5,-26]) rotate([0,-90]) import("HEMERA-MODEL-1.3.stl");
  rotate([0,-90]) {
    
    *XMod();
    V6_Bracket(xpos=-34,ypos=-9);
    *%V6_Bracket_Cap();
  }
  *rotate([0,90]) translate([11,-95.7,21]) rotate([0,90]) mirror([0,1]) rotate([0,0,90]) import("ZProbe_Preview.stl");
/*
rotate([0,-90,0]) {
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
  //*/
}
module V6_Bracket_Cap() {
  zout=17;
  xmid=16.75;
  translate([7.94,-13.52,35+yoff]) mirror([0,1]) rotate([0,90]) {
    translate([-3+yoff,-26.5+zoff,12.9]) mirror([0,0,0]) {
      difference() {
        translate([3,8.4,0]) {
          translate([xmid-15.75,-3,zout+6]) rcube([25.5,5.8+6,4],3);
        }
        translate([xmid,0]) mirrorx() translate([9,11.3,-.01]) {
          cylinder(d=3.5,h=30,$fn=20);
        }
        translate([xmid,8.3,zout]) rotate([-90,0]) {
          cylinder(d=12.4,h=6,$fn=40);
          *translate([-6.2,-6.2]) cube([12.4,6.2,6]);
          translate([0,0,.01]) mirror([0,0,1]) {
            cylinder(d=16.4,h=3.4,$fn=60);
            *translate([-8.2,-8.2]) cube([16.4,8.2,3.4]);
          }
          translate([0,0,5.99]) {
            cylinder(d=16.4,h=3.8,$fn=60);
            *translate([-8.2,-8.2]) cube([16.4,8.2,3.4]);
          }
        }
      }
    }
  }
}
module V6_Bracket(ypos=0,xpos=0,bltouch=1) {
  zout=17;
  xmid=17+xpos;
  translate([7.94,-13.52,35+yoff]) mirror([0,1]) rotate([0,90]) {
    translate([-3+yoff,-26.5+zoff,12.9]) mirror([0,0,0]) {
      difference() {
        union() {
          translate([-4+(xpos<0?xpos:0),-6+(ypos<0?ypos+5:0)]) rcube([42+abs(xpos),46+(ypos<0?abs(ypos)-5:0),4],1);
          translate([3,8.4+ypos]) {
            translate([xmid-15.75,-3]) rcube([25.5,5.8+6,zout+6],3);
            *mirrorx(-28) mirrory(-5.8) intersection(){
              mirror([0,1]) cube([5.4,20,20]);
              translate([0,0,14]) rotate([90+45,0]) mirror([0,1]) cube([14,14,16]);
            }
          }
          if(bltouch)
          translate([0,13.1,4]) difference() {
            union() {
              *translate([-10,20,20]) mirror([0,0]) mirror([0,0,1]) rotate([90,0]) translate([0,0,-4]) {
                fanmount();
              }
              translate([15,0]) mirror([0,1]) rotate([0,-90]) linear_extrude(3) polygon([[0,0],[12,0],[0,12]]);
              translate([0,3]) rotate([90,0]) linear_extrude(3) {
                polygon([[0,0],[0,8],[6,14],[21,14],[27,8],[27,0]]);
                //square([27,14]);
              }
            }
            #translate([0,3]) {
              cube([27,30,13]);
              translate([13.5,15,6.5]) rotate([-90,0]) cylinder(d=1,h=24,$fn=10);
            }
            for(x=[4.6,22.6]) translate([x,-.01,6.5]) rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
          }
          translate([xmid,ypos]) mirrorx() translate([9,11.3,3]) {
            rotate_extrude(){
              difference() {
                square([10,20]);
                translate([19,26]) scale([1,2]) circle(d=31,$fn=80);
              }
            }
            *cylinder(d1=16,d2=7.5,h=19,$fn=40);
            *cylinder(d1=20,d2=13,h=6,$fn=40);
          }
        }
        translate([xmid,8.3+ypos,zout]) rotate([-90,0]) {
          translate([0,0,-.2]) cylinder(d=12.4,h=6.4,$fn=40);
          translate([-6.2,-6.2]) cube([12.4,6.2,6]);
          translate([0,0,.11]) mirror([0,0,1]) {
            cylinder(d=16.8,h=3.4,$fn=60);
            translate([-8.2,-8.2]) cube([16.4,8.2,3.4]);
          }
          translate([0,0,5.89]) {
            cylinder(d=16.8,h=3.8,$fn=60);
            translate([-8.2,-8.2]) cube([16.4,8.2,3.4]);
          }
        }
        translate([xmid,ypos]) mirrorx() translate([9,11.3,-.01]) rotate([0,0,30]) {
          cylinder(d=3.2,h=30,$fn=20);
          cylinder(d=6.2,h=2.2,$fn=6);
          translate([0,0,2.19]) cylinder(d1=6.2,d2=3,h=2,$fn=6);
        }
        for(x=[0,34],y=[0,34],yo=[-2:2]) translate([x,y+yo,-.01]) {
          cylinder(d=3,h=40.02,$fn=20);
          translate([0,0,x>10?4:2]) cylinder(d=7,h=40,$fn=30);
          *translate([-3,-3,x<40?1.5:-1]) cube([6,6,3]);
        }
      }
      %translate([xmid,26+ypos,zout]) rotate([180,0]) import("E3D_V6.stl");
      
    }
  }
}
module XMod() {
  translate([7.94,-13.52,35+yoff]) mirror([0,1]) rotate([0,90]) difference() {
    translate([30,4,-10]) rotate([0,270]) translate([2.5,0,-5]) XMod_Main(yoff,gthick,xoff,zoff);
    translate([-3+yoff,-26.5+zoff,3]) mirror([0,0,1]) for(x=[0,34],y=[0,34]) translate([x,y]) {
      translate([0,0,-xoff]) cylinder(d=3.6,h=5+xoff,$fn=20);
      translate([0,0,3-xoff]) {
        cylinder(d=6,h=6+xoff,$fn=30);
        translate([0,0,6+xoff]) cylinder(d1=6,d2=3,h=5,$fn=30);
        *translate([0,0,gthick]) rotate([0,0,-90]) linear_extrude(xoff,convexity=3) hull() {
          circle(d=6,$fn=30);
          translate([8,0]) circle(d=6,$fn=30);
        }
      }
    }
    }
}
module XMod_Main(yoff=0,gthick=3,xoff=4.7,zoff=0)
{
  strappos=[4,21,38];
  off=(360-xrod_cover_angle)/2;
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
        union() {
          mirrory() translate([0,7.5]) mirror([1,0]) cube([6,gthick,50]);
          rotate([0,0,180+off]) {
            linear_extrude(50,convexity=3) intersection() {
              cr=7.5+gthick;
              circle(r=cr,$fn=80);
              rotate([0,0,180]) polygon([[-cr,0],[0,0],[cr*cos(xrod_cover_angle-90),cr*sin(xrod_cover_angle)],[cr,cr],[cr,-cr],[-cr,-cr]]);
            }
            *rotate_extrude(angle=xrod_cover_angle,$fn=80) square([7.5+gthick,50]);
          }
          for(r=[180-off,180+off]) rotate([0,0,r]) translate([7.5+gthick/2,0]) cylinder(d=gthick,h=50,$fn=30);
        }
      }
      // hemera protector
      *translate([4.7,-35,-yoff]) rotate([0,90,0]) rotate([0,0,90]) linear_extrude(2.4+gthick+xoff,convexity=3) difference() {
        translate([26,37]) hull() {
          for(x=[5,15],y=[29,-32+yoff]) translate([x,y]) circle(r=5,$fn=40);
          square([20,14]);
        }
        *for(x=[-6.25,6.25]) translate([26+10+x,37+29-5]) circle(d=2.6,$fn=20);
      }
      // x min stop
      *translate([0,-40,0]) difference() {
        translate([-15,0]) linear_extrude(4) hull() {
          for(y=[4,11.5]) translate([4,y]) circle(r=4,$fn=30);
          translate([10,0]) square([25.1,15.5]);
        }
        translate([-10,6,-.01]) cylinder(d=3,h=4.02,$fn=20);
      }
      // x max stop
      translate([0,-40,46]) difference() {
        translate([5,0]) linear_extrude(4) hull() {
          for(y=[4,12]) translate([3,y]) circle(r=4,$fn=30);
          translate([10,0]) square([-4.9+xoff,16]);
        }//cube([15.1,16,4]);
        translate([9,6,-.01]) cylinder(d=3,h=4.02,$fn=20);
      }
      translate([-1,25]) cube([10,3,50]);
      translate([4.7,-35,-yoff]) rotate([0,90]) rotate([0,0,90]) linear_extrude(xoff+gthick+2.4,convexity=3) {
        translate([18-8,yoff]) square([35+18,50]);
      }
      translate([4.7+xoff,-35+zoff,-yoff]) rotate([0,90,0]) rotate([0,0,90]) linear_extrude(2.4+gthick,convexity=3)
        translate([0,0]) hull() {
          r=4;
          for(x=[r,42.5-r],y=[r,42.5-r])
            translate([x,y]) circle(r=r,$fn=30);
          *translate([10,0]) square([34,42]);
        }
      }
      // probe holes
      *translate([17,-30,43]) rotate([-90,0]) {
        translate([0,0]) cylinder(d=6.2,h=60,$fn=40);
        translate([0,29]) cylinder(d=3,h=60,$fn=20);
        for(y=[10,24.5,39]) translate([-9.7,38.7-y,48.01]) cylinder(d=3,h=15,$fn=20);
      }
      mirrory() for(z=strappos) {
        translate([-5,6,z]) cube([9.7,2,6]);
        translate([10,35/2,z]) cube([3,18,6]);
      }
      mirrory() translate([-.45,17.5]) rotate([0,0,90]) rotate_extrude(angle=270,$fn=100,convexity=3) {
        for(y=strappos)
        translate([7.5+.01+gthick,y]) square([3,6]);
      }
    
    *translate([-2.5+7,-1.26,15]) rotate([0,-44]) mirror([1,0])  cube([8,2.7,18.1]);
    mirrory() translate([-.45,17.5,-.01]) {
      translate([0,0,.99]) cylinder(d=15,h=51,$fn=80);
      cylinder(d=14,h=1,$fn=50);
    }
  }
}

module fanmount(ang=50) {
  screwpos=[[4.4,45],[47,7]];
  intersection() {
    translate([0,-46,0]) cube([70,50,50]);
    union() {
  difference() {
    translate([5,4]) rotate([90,0]) rcube([32,42,4]);
    for(z=[4.5,38])  translate([10,-1,z]) rotate([-90,0]) cylinder(d=3.5,h=10,$fn=30);
  }
    translate([34,0]) rotate([0,-90]) linear_extrude(4) polygon([[0,0],[30,0],[35*cos(ang),-35*sin(ang)]]);
    *translate([30,0,]) rotate([ang,0]) cube([4,30,28]);
  translate([15,0]) rotate([ang,0]) difference() {
    rotate([90,0]) translate([0,0,-4]) linear_extrude(4,convexity=3) hull() {
      translate([15,0]) square(2);
      for(pos=screwpos)
        translate([pos[0],pos[1]]) circle(d=10,$fn=40);
    }
    for(pos=screwpos)
    translate([pos[0],-.01,pos[1]]) rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
  }
}}
  %rotate([ang,0])
  translate([15,-15]) rotate([90,0]) import("5015_Blower_Fan.stl");

}
module mirrorx(off=0)
{
  translate([off/-2,0]) for(m=[0,1]) mirror([m,0]) translate([off/2,0]) children();
}
module mirrory(off=0)
{
  translate([0,off/-2]) for(m=[0,1]) mirror([0,m]) translate([0,off/2]) children();
}
module mirrorz(off=0)
{
  translate([0,0,off/-2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/2]) children();
}
module rsquare(dims,r=5,center=false,$fn=30)
{
  translate(center?[dims[0]/-2,dims[1]/-2]:[0,0])
  hull() for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=$fn);
}
module rcube(dims,r=5,$fn=30)
{
  linear_extrude(dims[2],convexity=3) {
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=$fn);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
  }
}
module cube2(dims,r=5,$fn=30)
{
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r,$fn=$fn);
  }
}