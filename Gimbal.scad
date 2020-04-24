bd=70;
t=1.6;
ib=12;
handh=90;
handt=40;
gap=10.4;
holedeep=handh/2-gap/2-2;
echo(str("Hole depth: ",holedeep));

intersection(){
  *cube([30,35,60]);
  difference() {
    linear_extrude(handt,convexity=3) {
      difference() {
        rsquare([24,handh]);
        translate([12,5]) rsquare([7,handh-10],r=2,$fn=12);
        translate([14,5]) square([10,handh-10]);
      }
      
      mirrory(handh) translate([27.5,10]) rotate([0,0,135]) {
        translate([0,-2]) circle(d=6,$fn=20);
        translate([-2.5,-2]) square([5,12]);
      }
    }
    translate([-.01,handh/2-gap/2,-.01]) difference() {
      cube([20,gap,handh-9.98]);
      mirrory(gap) {
      translate([2.5,0,-.01]) cylinder(d=5,$fn=30,h=handh-9.96);
      translate([9.5,0,-.01]) cylinder(d=5,$fn=30,h=handh-9.96);
      translate([2.5,0,-.01]) cube([7,2.5,handh-9.96]);
      }
    }
    for(z=[8:12:32])
      translate([6,-.01,z]) rotate([-90,0]) {
        cylinder(d=3,h=handh+10,$fn=20);
        cylinder(d=4,h=handh/2,$fn=30);
        translate([0,0,handh+.02]) mirror([0,0,1]) cylinder(d=10,h=holedeep,$fn=40);
        cylinder(d=10,h=holedeep,$fn=40);
      }
  }
}
*difference() {
  cube([70,5,20]);
  translate([5,-.01,5])
    cube([60,5.02,10]);
  translate([10,-.01,14]) cube([50,5.02,10]);
}
*%iPhone7();

module rsquare(dims,r=5,$fn=25)
{
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
  for(x=[r,dims[0]-r],y=[r,dims[1]-r])
    translate([x,y]) circle(r=r,$fn=$fn);
}
module iPhone7()
{
  cube([67.1,138.3,7.1]);
}

*intersection() {
  translate([-100,-100,0]) cube([200,200,5]);
  fullset();
}

module fullset(ring1=1,ring2=1,center=1) {
  if(ring1)
    spinring(bd,skip1=1);
  if(ring2)
    rotate([0,0,90]) spinring(bd-ib-t*2);
*spinring(bd-ib*2-t*4);
  if(center)
    rotate([0,0,90]) difference(){
      cylinder(d=bd-ib*2-t*2,h=10,$fn=50);
      translate([0,0,-.01]) cylinder(d=10,h=10.02,$fn=30);
      rotate([0,0,30]) translate([0,0,1]) cylinder(d=25.4*.6,h=8.02,$fn=6);
      mirrorx() {
        translate([-22,0,5]) rotate([0,90]) cylinder(d=7,h=20,$fn=30);
        translate([-17.75,0,5]) rotate([0,90]) cylinder(d=8.6,h=3.4,$fn=40);
        mirrory() translate([-16,-7.5,-.01]) cylinder(d=3,h=10.02,$fn=20);
        *translate([-16,-3,2]) cube([3,6,10]);
      }
    }
}
module spinring(d,t=t,skip1=0)
{
  difference() {
    union() {
      ring(od=d,t=t,h=10,$fn=max(20,d));
      intersection() {
        for(r=[0:90:360]) rotate([0,0,r]) {
          if(skip1&&r%180==90)
          {
            translate([d*-.5+.75,0]) cylinder(d=7,h=10,$fn=40);
          } else {
            translate([d*-.5-1.6,-10]) {
              translate([0,2.5,0]) cube([6.4,20-2.5*2,10]);
              translate([3.2,2.5]) cylinder(d=6.4,h=10,$fn=40);
              translate([3.2,20-2.5]) cylinder(d=6.4,h=10,$fn=40);
            }
          }
        }
        *cylinder(d=d,h=10,$fn=max(20,d));
      }
    }
    for(r=[0,90]) rotate([0,0,r]) {
      if(skip1&&r==90)
        mirrorx() translate([d*-.5+.75,0,-.01]) cylinder(d=3,h=10.02,$fn=20);
      else
        mirrory() mirrorx() translate([d*-.5+1.6,-7.5,-.01]) cylinder(d=3,h=10.02,$fn=20);
    }
    for(r=skip1?[0,180]:[0:90:360]) rotate([0,0,r])
    translate([d*-.5-2,0,5]) rotate([0,90,0]) cylinder(d=7,h=10,$fn=30);
    *translate([0,d*-.5-2,5]) rotate([-90,0]) cylinder(d=7,h=10,$fn=30);
    for(r=skip1?[0]:[0,90]) rotate([0,0,r]) mirrorx() translate([d*-.5+t-1.6,0,5]) rotate([0,90]) {
        translate([0,0,-.11]) cylinder(d=8.6,h=3.4,$fn=40);
      *translate([0,-4.1,0]) mirror([1,0]) cube([8.2,8.2,3.2]);
    }
  }
}

module ring(od,t,h,$fn=50)
{
  linear_extrude(h,convexity=3) {
    difference(){
      circle(d=od,$fn=$fn);
      circle(d=od-t*2,$fn=$fn);
    }
  }
}
module mirrorx(off=0) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([-off/2,0]) children();
}
module mirrory(off=0) {
  translate([0,off/2,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,off/-2,0]) children();
}