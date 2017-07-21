head();
module head(dims=[63,64.5,32],move=0) {
  left=dims[0]/-2;
  botm=dims[1]/-2;
  translate(move?[0,0,66]:[]) rotate(move?[180,0,-90]:[]) {
    *#import("Otto_DIY/files/OTTO_head_v3.stl");
    difference(){
      translate([-31.5,-32.25,0]) box_chamfer(dims,ch=2,chy1=3.5,chvx=5.5,chvy=4);
      translate([-29.5,-28.751,2]) box_chamfer([59,59,50],ch=1,chvx=2.75,chvy=2.75,inside=1);
      translate([-31.5,-32.26,28.2]) cube([63,1.5,10]);
      mirrorx() translate([-13.25,-32.26,15]) rotate([-90,0]) cylinder(d=16.5,h=4,$fn=50);
      translate([31.51,18.163,12.875]) rotate([0,-90]) cylinder(d=8,h=4,$fn=24);
      translate([28.74,12.5,4.815]) cube([2.06,10.5,14.2]);
      translate([28.74,-2.4,19.5]) rotate([0,90]) rotate([0,0,90]) usb_mini();
      translate([-5.6,-29.555,3.75]) {
        *translate([2.05,0,1]) scale([0.6,0.5,0.7]) box_chamfer2([11.2,1.5,7.6],6);
        translate([11.25,0]) rotate([-90,0]) rotate([0,0,180]) intersection() {
          box_chamfer([11.3,7.6,2],ch=0,chvx=1.6,chvy=1.6);
          translate([0,0,-.8]) box_chamfer([11.3,7.6,4],ch=1.6,chvx=0,chvy=0);
          
        }
      }
    }
    mirrorx() translate([29.5,-9.25,32]) rotate([-90,0]) mirror([0,1,0]) linear_extrude(21) polygon([[0,0],[0,8.4],[1.98,8.4],[4.1,6.3],[4.1,4.2],[2,2.5],[2,0],]);
    mirrory(0.75) mirrorx(0) translate([-27,-30.75,32]) rotate([90,0]) mirror([0,0,1]) linear_extrude(2) polygon([[0,0],[0,6],[2,8],[12,8],[14,6],[14,1.5],[15.5,0]]);
  }
  translate([-25.4,-30,2]) cube([2,4.9,3.9]);
  translate([-29.6,-8,2]) cube([1.5,2,3]);
  translate([-29.6,20,2]) cube([1.5,1.98,3]);
  translate([-25.375,29.075,2]) cube([2,1.5,3.9]);
  translate([23.626,29.075,2]) cube([2,1.5,3.9]);
  translate([27,25,2]) cube([4,2,3]);
  translate([22.877,-30,2]) {
    cube([2,4.875,3.9]);
    cube([2,6,3]);
  }
  translate([0,0,2]) for(pos=[[-27,-7],[-27,20.9],[25.2,26.1],[23.825,-22.25]])
    translate(pos) difference() {
      union(){
        cylinder(d=4.3,h=3,$fn=30);
        cylinder(d1=6,d2=4.3,h=1,$fn=30);
      }
      translate([0,0,-.01]) cylinder(d=2,h=4.02,$fn=20);
    }
}
module usb_mini() {
  linear_extrude(3,convexity=10) {
    translate([0.6,0]) union() {
      translate([0,0.1]) square([8-1.202,4]);
      for(x=[0.1,6.7]) translate([x,0.1]) circle(r=0.1,$fn=20);
      translate([0.1,0]) square([6.6,4]);
    }
    mirrorx(3.999) translate([0.4,1.81]) difference() {
      square([0.2,0.2]);
      circle(r=0.2,$fn=20);
    }
    translate([0,2.008]) union() {
      translate([0.1,0.2]) square([7.8,1.9]);
      translate([0.2,0]) square([7.6,2.1]);
      translate([0,0.1]) square([8,1.9]);
      for(x=[0.2,7.8])
        translate([x,0.2]) circle(r=0.2,$fn=20);
      for(x=[0.1,7.9])
        translate([x,2]) circle(r=0.1,$fn=20);
    }
  }
}
module box_chamfer2(dims,ch=1)
{
  render() minkowski()
  {
    cube(dims);
    intersection()
    {
      rotate([45,0,45]) cube(ch,center=true);
      rotate([45,0,-45]) cube(ch,center=true);
    }
  }
}
module box_chamfer(dims,ch=1,chx1="auto",chx2="auto",chy1="auto",chy2="auto",chvx="auto",chvy="auto",inside=0) {
  x1=chx1=="auto"?ch:chx1;
  x2=chx2=="auto"?ch:chx2;
  y1=chy1=="auto"?ch:chy1;
  y2=chy2=="auto"?ch:chy2;
  vx=chvx=="auto"?ch:chvx;
  vy=chvy=="auto"?ch:chvy;
  difference(){
    cube(dims);
    if(x1)
    {
      translate([x1,-.01]) rotate([0,-45]) mirror([1,0]) cube([x1*2,dims[1]+.02,x1*2]);
      if(vx)
      translate([9.9,0]) rotate([0,0,45]) translate([-5+x1,0]) translate([x1,-.01]) rotate([0,-45]) mirror([1,0])  cube([x1*2,dims[1]+.02,x1*2]);
    }
    if(x2)
      translate([dims[0]-x2,-.01]) rotate([0,45]) cube([x2*2,dims[1]+.02,x2*2]);
    if(y1)
      translate([-.01,y1]) rotate([45,0]) mirror([0,1,0]) cube([dims[0]+.02,y1*2,y1*2]);
    if(y2)
      translate([-.01,dims[1]-y2]) rotate([-45,0]) cube([dims[0]+.02,y2*2,y2*2]);
    if(vx)
    {
      mirrorx(dims[0]/2) {
        translate([vx,0,-.01]) rotate([0,0,45]) mirror([1,0]) cube([vx*2,vx*2,dims[2]+.02]);
        translate([inside?-1.4:-1.5,inside?0:-1.1]) rotate([0,0,45])
        mirror([1,0,0]) rotate([0,45,0])
        translate([-vx,-vx]) translate([0,0,vx/-.75]) cube([10,vx*2,vx*2]);
      }
    }
    if(vy)
      mirrorx(dims[0]/2) {
        translate([0,dims[1]-vy,-.01]) rotate([0,0,-45]) mirror([1,0]) cube([vy*2,vy*2,dims[2]+.02]);
        translate([0,dims[1]+(inside?-0.25:0.5),-.01])
          rotate([0,0,-45]) mirror([1,0,0])
          rotate([0,-45,0])
          translate([-vx,-vx]) translate([0,0,vx/-.75]) 
          cube([10,vx*2,vx*2]);
      }
  }
}
module mirrory(offset=0)
{
  translate([0,offset,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-1,0]) children();
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}
module otto_stl() {
  translate([0,0,66]) rotate([180,0,-90]) import("Otto_DIY/files/OTTO_head_v3.stl");
  import("Otto_DIY/files/OTTO_body_v3.stl");
  translate([0,-34.5,-48]) import("Otto_DIY/files/OTTO_footR_v4.stl");
  translate([0,34.5,-48]) import("Otto_DIY/files/OTTO_footL_v4.stl");
  for(y=[-25,25])
    translate([0,y,-40]) rotate([0,0,0]) import("Otto_DIY/files/OTTO_leg_v4.stl");
}