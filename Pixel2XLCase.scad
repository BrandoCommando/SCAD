phw=77.1; //76.7;
phh=158.3; //157.9;
phd=6.6;
buttons=1;
bumper=0;
*translate([phw/2+1,phh/2+4]) import("Pixel_2_XL_caseFlex.stl");
//intersection()
{
difference() {
  union() {
    //mirrorz(phd+4)
    intersection() {
      cube([phw+4,phh+4,phd+4]);
      cube2([phw+4,phh+4,phd*.5],r=8,vr=0.5,cr=0.5);
    }
    *translate([2,2,3]) linear_extrude(phd-2,convexity=4) difference() {
      offset(2) pixel2xlprofile();
      pixel2xlprofile();
    }
  }
  translate([2,2,1])
    pixel2xl(phd=phd+2);
  translate([phw/2-1,-.01,phd/2+1]) rotate([-90,0]) {
    hull() {
      translate([-1,0]) cylinder(d1=10,d2=5,h=2,$fn=40);
      translate([7,0]) cylinder(d1=10,d2=5,h=2,$fn=40);
    }
    linear_extrude(10,convexity=3) {
      hull() {
        translate([-1,0]) circle(d=7,h=10,$fn=30);
        translate([7,0]) circle(d=7,$fn=30);
      }
    }
  }
  translate([30,phh+4,phd/2+2]) rotate([90,0]) {
    cylinder(d1=7,d2=2,h=1,$fn=20);
    cylinder(d=4,h=4,$fn=20);
  }
  d1=buttons==1?6:8;
  d2=buttons==1?8:5;
  translate([phw-(buttons==1?0:1.01),122,phd/2+2]) rotate([0,90,0]) {
    translate([0,0,2]) hull() {
      cylinder(d1=d1,d2=d2,h=2,$fn=40);
      translate([0,-8]) cylinder(d1=d1,d2=d2,h=2,$fn=40);
    }
    translate([0,0,2]) hull()
      for(y=[-22,-40]) translate([0,y]) cylinder(d1=d1,d2=d2,h=2,$fn=40);
    linear_extrude(10) {
      hull() {
        circle(d=d1,$fn=20);
        translate([0,-8]) circle(d=d1,$fn=20);
      }
      hull() {
        translate([0,-22]) circle(d=d1,$fn=20);
        translate([0,-40]) circle(d=d1,$fn=20);
      }
    }
  }
  if(buttons==1)
  {
    translate([phw+3,87-d1/2,-.02]) linear_extrude(phd/2+2) {
      hull() {
        circle(d=10,h=phd/2+2,$fn=40);
        translate([0,11+d1/2]) circle(d=10,h=phd/2+2,$fn=40);
      }
      hull() {
        translate([0,32]) circle(d=10,h=phd/2+2,$fn=40);
        translate([0,33+d1/2]) circle(d=10,h=phd/2+2,$fn=40);
      }
    }
  }
  linear_extrude(3) hull() for(x=[-1,1]) translate([x,0]) translate([2+phw/2,0],-.02) circle(d=12,h=3,$fn=40);
  translate([2,6,-.01])
    hull() {
      translate([phw-16,phh-20.6]) cylinder(r1=8,r2=7,h=1.02,$fn=40);
      translate([phw-30,phh-20.6]) cylinder(r1=5,r2=4,h=1.02,$fn=30);
    }
  translate([2,6,-.01]) //linear_extrude(phd+4.02,convexity=3)
    {
    translate([phw/2,111]) hull() for(y=[0,-6]) for(x=y==0?[0]:[-3,3]) translate([x,y]) cylinder(r1=11-(y<0?1:0),r2=10-(y<0?1:0),h=1.02,$fn=50);
    linear_extrude(phd+3.02,convexity=3) translate([6,4]) difference() {
      hull() for(x=[5,phw-17],y=[4,phh/2-14]) translate([x,y]) circle(r=5,$fn=30);
      hull() for(x=[-6,6]) translate([x,-4]) translate([2.5+(phw-17)/2,0]) circle(r=8,$fn=40);
    }
    *translate([phw/2,30]) mirror([1,0]) text("B",size=30,valign="center",halign="center",font="Stencil Std");
    
  }
  translate([2,4,bumper?-.01:2]) linear_extrude(20,convexity=3) hull()
      for(x=[7,phw-7],y=[6,phh-11])
        translate([x,y]) circle(r=5,$fn=30);

  translate([2,2,5]) linear_extrude(18,convexity=3) {
    
  }
}
  //cube([phw+10,phh/2-5,phd+10]);
}
if(!bumper)
  translate([2,6,1]) linear_extrude(.4) trace() {
      translate([phw/2,111]) hull() for(y=[0,-6]) for(x=y==0?[0]:[-3,3]) translate([x,y]) circle(r=10-(y<0?1:0),$fn=50);
    hull() {
      translate([phw-16,phh-20.6]) circle(r=7,$fn=40);
      translate([phw-30,phh-20.6]) circle(r=4,$fn=30);
    }
  }

if(buttons==2)
{
  
  translate([phw+3.5,122,phd/2+2]) scale([.5,1,1]) rotate([0,90,0]) {
    rotate([90,0]) cylinder(d=5,h=8,$fn=30);
    for(y=[0,-8]) translate([0,y]) sphere(d=5,h=2,$fn=30);
    translate([0,-22]) rotate([90,0]) cylinder(d=5,h=18,$fn=30);
    for(y=[-22,-40]) translate([0,y]) sphere(d=5,$fn=30);
  }
}
module trace(d=1)
{
  difference() {
    offset(d) children();
    children();
  }
}
module pixel2xl(phw=phw,phh=phh,phd=phd,rr=5)
{
  p2xl=[phw,phh,phd];
  *hull() for(x=[rr,phw-rr],y=[rr,phh-rr],z=[rr,phd-rr])
    translate([x,y,z]) hull() for(iy=[rr/-2,rr/2]) translate([0,iy]) circle(r=rr);
  translate([rr,rr,rr/2]) minkowski() {
    cube([p2xl[0]-rr*2-.4,p2xl[1]-rr*2-.4,p2xl[2]-rr]);
    scale([1,1,0.5]) sphere(r=rr,$fn=40);
  }
}
module pixel2xlprofile(phw=phw,phh=phh,phd=phd,rr=5)
{
  p2xl=[phw,phh,phd];
  translate([rr,rr,rr/2]) minkowski() {
    square([p2xl[0]-rr*2-.4,p2xl[1]-rr*2-.4]);
    circle(r=rr,$fn=40);
  }
}
module cube2(dims,r=5,vr=0.85,cr=0.9,$fn=40)
{
  translate([r,r,r*vr]) minkowski() {
    cube([dims[0]-r*2,dims[1]-r*2,max(0.1,(dims[2]))]);
    scale([1,1,vr/cr]) intersection() {
      translate([0,0,0]) sphere(r=r,$fn=$fn);
      translate([-r,-r,-r*cr]) cube([r*2,r*2,r*2*cr]);
    }
  }
}
module mirrorz(off=0)
{
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/-2]) children();
}