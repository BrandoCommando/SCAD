facewidth=120;
framebridge=4;
eardist=100;
hingeh=10;
part="all";
if(part=="all")
{
  frame();
  translate([eardist/2+10,-50]) rotate([0,-90,0]) arm();
  translate([eardist/-2-10,-80]) mirror([1,0]) rotate([0,-90,0]) arm();
} else if(part=="arms") {
  translate([eardist/2+10,-50]) rotate([0,-90,0]) arm();
  translate([eardist/-2-10,-80]) mirror([1,0]) rotate([0,-90,0]) arm();
} else if(part=="frame") {
  frame();
} else {
*!rotate([0,-90]) arm();
frame();
mirrorx() translate([facewidth*-.5-6-framebridge/2,4,0]) arm();
}
module arm() {
  difference() {
    union() {

      translate([0,-2]) cube([3,hingeh+4,eardist]);
      intersection() {
      translate([0,-4,9]) rotate([-90,0]) linear_extrude(hingeh+8) {
        polygon([[0,-10],[8,-4],[8,9],[0,9]]);
      }
        translate([0,-10]) cube([8,30,20]);
        translate([6,0]) rotate([0,-90,0]) linear_extrude(8) polygon([[0,hingeh+4],[12,hingeh+4],[16,hingeh+2],[16,-2],[12,-4],[0,-4]]);
      }
      translate([0,0,eardist]) rotate([0,90]) linear_extrude(3) {
        hull() {
          translate([1,hingeh-.5]) circle(d=5.5);
          translate([-15,-2]) circle(d=facewidth/8);
        }
      }
    }
    translate([3,-4.01,5]) rotate([-90,0]) cylinder(d=2,h=hingeh+8.02,$fn=20);
    translate([-.01,-.31,-.01]) cube([6.02,hingeh+.62,10]);
    *translate([-.01,-10.01,10]) {
      cube([2,facewidth/8+20,eardist+20]);
      translate([2,10]) mirror([1,0]) rotate([0,60,0]) cube([4,facewidth/8+20,10]);
    }
    translate([-.01,eardist*-.1,eardist]) rotate([0,90]) cylinder(d=facewidth/4,h=3.62,$fn=40);
    *translate([-.01,-.01,2]) cube([3.62,facewidth/8-2,2.2]);
    *translate([-.01,-.01,-.01]) cube([3.62,facewidth/8-4,2.02]);
    *translate([-.01,facewidth/8-4.02,2]) cube([2.2,4.4,2.2]);
  }
}
module frame() {
  difference() {
    union(){
      mirrorx() translate([facewidth*-.5-3-framebridge/2,4,5]) rotate([-90,0]) {
        difference() {
          union(){
        translate([-3,0]) cube([6,5,hingeh]);
        cylinder(d=6,h=hingeh,$fn=40);
          }
          translate([0,0,-.01]) cylinder(d=3,h=hingeh+.02,$fn=20);
        }
      }
      linear_extrude(2,convexity=3) difference() {
        union(){
          mirrorx() translate([facewidth*-.25-framebridge/2,0])
            bunny_outline();
          translate([facewidth*-.5-framebridge/2,2]) square([facewidth+framebridge,hingeh+4]);
        }
        bridge();
        *mirrorx() translate([facewidth*-.5-.4,facewidth/8-2]) square([2,2]);
        difference() {
        mirrorx() translate([facewidth*-.25-framebridge/2,0]) circle(d=facewidth/2-2*2,$fn=40);
          offset(2) bridge();
      }
      }
    }
    *mirrorx() translate([0,0,.8]) linear_extrude(2) difference() {
      translate([facewidth*-.25,0]) mirrorx() hull() {
        translate([facewidth*-.125,facewidth/2]) circle(d=facewidth/5-2,$fn=24);
        translate([-2,5]) circle(d=2);
      }
      translate([facewidth*-.25-framebridge/2,0]) circle(d=facewidth/2,$fn=40);
    }
  }
  mirrorx() linear_extrude(2) intersection() {
    difference() {
    translate([facewidth*-.25-framebridge/2,0]) circle(d=facewidth/2-2,$fn=40);
        bridge();
    }
    for(y=[facewidth*-.25-.5:4:facewidth*.25])
      translate([facewidth*-.5-framebridge/2,y]) square([facewidth/2,1.6]);
  }
}
module bridge() {
  circle(r=framebridge,$fn=30);
  polygon([[framebridge,0],[framebridge+6,-25],[-framebridge-6,-25],[-framebridge,0]]);
}
module bunny_outline() {
  circle(d=facewidth/2,$fn=40);
  mirrorx() hull() {
    translate([facewidth*-.125,facewidth/2]) circle(d=facewidth/5,$fn=24);
    translate([-2,5]) circle(d=4);
  }
}
module mirrorx() {
  for(m=[0,1]) mirror([m,0]) children();
}