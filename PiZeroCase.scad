*translate([36.5,-79,2.5]) import("Raspberry_Pi_Zero_Case_-_Snapfit_Screwless_inc._camera_slot/files/Pi_Zero_Case_V4_inc_Camera_Slot.stl");
th=12;
long=1;
wrap=0;
part="base";
longy1=30;
longy2=59;
usb_access=1;
include<Battery.scad>;

if(part=="all")
  lid();
if(part=="base"||part=="all"||part=="all2"||part=="combo") base();
if(part=="lid"||part=="all2") translate([40,0,th+2]) rotate([0,180,0]) lid();
if(part=="combo")
{
  translate([-18,-30]) rotate([0,0,90]) pack(4,"AA");
}
module lid() {
  difference(){
    union(){
      translate([-18,-35.5,th]) cube2([36,71,2],3);
      if(wrap)
        translate([-12,32,th]) cube2([24,6,2]);
      else if(long) {
        translate([-12,32,th])
          linear_extrude(2,convexity=10) {
            long_profile();
          }
          translate([-4,longy2+10,th-3]) difference() {
            cube([8,8,3]);
            translate([-1,20]) rotate([135,0]) cube(10);
          }
        }
      translate([-18,-38,th]) cube2([36,8,2],3);
      for(x=[-11.5,11.5],y=[-29,29]) translate([x,y,th-5])  cylinder(d1=5,d2=6,h=5,$fn=30);
    }
    for(x=[-11.5,11.5],y=[-29,29]) translate([x,y,th-5.01]) {
      cylinder(d=2.5,h=6.02,$fn=20);
      translate([0,0,6]) cylinder(d1=2.5,d2=2.5,h=1.99,$fn=30);
    }
    translate([-12.5,-24,th-.01]) cylinder(d=3,h=5,$fn=30);
    if(long)
      translate([0,longy2+28,th-.01]) {
        cylinder(d=7,h=5,$fn=50);
        translate([-4.5,-4.5]) cube([9,9,1]);
      }
  }
  translate([-8,-35,th-4]) cube([12.5,2,5]);
  if(!long)
  translate([-8.5+(wrap?0:1.7),33,th-2]) cube([17-(wrap?0:3.4),2+(wrap?0:.5),3]);
  translate([14,1,th-3]) cube([2.5+(usb_access?1.5:0),25,3]);
  translate([-10,31,th-3]) cube([20,2,3]);
  translate([14,-20,th-3]) cube([2,40,3]);
  translate([-15.5,-20,th-3]) cube([2,40,3]);
}
module long_profile()
{
  translate([6,0]) square([12,longy2+.5]);
  translate([8,longy2+.5]) circle(d=4,$fn=30);
  translate([16,longy2+.5]) circle(d=4,$fn=30);
  translate([8,longy2-.5]) square([8,3]);
  translate([3,0]) square([18,longy1]);
  *translate([1,0]) square([22,longy1]);
  *translate([4,longy1]) circle(r=3,$fn=20);
  *translate([20,longy1]) circle(r=3,$fn=20);
  translate([4,3]) circle(r=3,$fn=20);
  translate([20,3]) circle(r=3,$fn=20);
  translate([1,longy1]) polygon([[2,0],[6,6],[16,6],[20,0]]);
}
module base() {
union(){
  difference(){
    union(){
      translate([-18,-35.5]) cube2([36,71,th],r=3);
      translate([-12,32])
        if(long)
          linear_extrude(th,convexity=10) long_profile();
        else if(wrap)
          cube2([24,6,th]);
      translate([-18,-38]) cube2([36,10,th],3);
    }
    translate([-16,-33.5,2]) cube2([32,67,th],2);
    //translate([
    translate([-9.5,-36,3]) cube([15.5,4,th]);
    translate([-9,32,6])
      if(long)
      {
        translate([0,0,-1]) cube2([18,4,th],2);
        translate([2,2]) cube([14,longy1-2,th],2);
        translate([0,longy1-.01]) linear_extrude(th) polygon([[2,0],[5,4],[13,4],[16,0]]);
        translate([4.5,longy1]) {
          translate([0,0,0]) cube([9,16,th],2);
          translate([0,15.99]) rotate([45,0]) cube([9,10,10]);
          translate([0,15.99,3]) cube([9,6,th]);
          translate([-.5,17.5,3]) cube2([10,longy2-longy1-16,th]);
        }
      }
      else if(wrap)
        cube([18,4,th]);
      else
        translate([2,0,3]) cube([14,4,th-5]);
    if(!long&&wrap) {
    translate([-4.5,-18.5,1.4]) cube([9,9,2]);
    translate([0,-14,-.01]) cylinder(d=7.5,h=2.02,$fn=30);
    translate([-5,5,1]) cube([10,26,2]);
    }
    translate([13,0,4]) cube([4+(usb_access?2:0),28,th]);
    for(x=[-11.5,11.5],y=[-29,29]) translate([x,y])       translate([0,0,-.01]) cylinder(d=2.5,h=4,$fn=20);
  }
  for(x=[-11.5,11.5],y=[-29,29]) translate([x,y]) difference(){
    cylinder(d1=6,d2=5,h=5,$fn=30);
    translate([0,0,-.01]) cylinder(d=2.5,h=6,$fn=20);
  }
}
}

module cube2(dims,r=1)
{
  linear_extrude(dims[2]) {
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=20);
  }
}