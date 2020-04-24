pipe_grip();
module pipe_grip() {
difference() {
  union() {
    //hull()
    {
      //linear_extrude(6) rsquare([42,42],center=true);
      linear_extrude(6,convexity=3) difference() { union() {
        mirrorx() mirrory() hull() {
          translate([16,16]) circle(d=10,$fn=40);
          circle(d=inches(1),$fn=80);
        }
        square([30,30],center=true);
      }
        mirrorx() mirrory() translate([16,16]) circle(d=3,$fn=20);
        *for(r=[0:90:359]) rotate([0,0,r]) translate([15,0]) circle(d=1,$fn=10);
        circle(d=inches(.922),$fn=100);
      }
      *cylinder(d=inches(1),h=10,$fn=80);
    }
    //translate([0,0,10]) cylinder(d1=inches(1.2),d2=inches(1.1),h=20,$fn=80);
  }  
  for(r=[0:90:359]) rotate([0,0,r]) translate([24.01,0,3]) rotate([0,-90]) {
      cylinder(d=6,h=9.1,$fn=30);
    cylinder(d=3,h=20,$fn=20);
  }
  translate([0,0,-.1]) cylinder(d=inches(.94),h=40,$fn=80);
  mirrorx() mirrory() { translate([16,16,-.1]) {
      cylinder(d=3,h=40,$fn=20);
      translate([0,0,3]) cylinder(d1=3,d2=6,h=2.2,$fn=40);
    translate([0,0,5.2]) cylinder(d=6,h=2,$fn=40);
    }
  }
}
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
module rsquare(dims,r=5,center=false)
{
  translate(center?[dims[0]*-.5,dims[1]*-.5]:[0,0])
  hull() for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=r*4);
}

function inches(in) = 25.4 * in;