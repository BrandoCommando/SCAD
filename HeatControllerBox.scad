t=2.2;
tw=120;
tl=120;
th=70;
difference(){
  cube2([tw,tl,th],r=7);
  translate([t,t,t]) cube2([tw-t*2,tl-t*2,th+10],r=5,v=1);
  translate([tw/2-22,-.1,24]) cube([44,100,50]);
  translate([0,0,-.1]) linear_extrude(t+.2) for(x=[tw/2-44,tw/2+10],y=[88])
    translate([x,y]) fuse_holes();
  for(x=[tw/2-25,tw/2+25])
    translate([x,38,-.1]) rotate([0,0,0]) relay_hole();
}
translate([tw/2-17/2,76]) {
  cube([17,4,24]);
  translate([-2,-4]) cube([2,8,26]);
  translate([17,-4]) cube([2,8,26]);
}

module cube2(dims,r=5,v=0,$fn=20)
{
  if(v) minkowski() { translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]); sphere(r=r,$fn=$fn); }
  else linear_extrude(dims[2],convexity=4) {
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=$fn);
  }
}

module relay_hole() {
  translate([-23.5,-32]) difference() {
    cube([47,64,t+1]);
    for(y=[0,61.2])
    translate([47/2-4,y-.1,-.1]) cube([8,3,t+2]);
  }
}
module fuse_holes() {
  square([2,4]);
  translate([7,0]) square([2,4]);
  translate([25,0]) square([2,4]);
  translate([32,0]) square([2,4]);
}