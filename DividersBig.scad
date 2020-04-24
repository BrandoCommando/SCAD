mirror([0,0,1]) rotate([90,90,0])
difference(){
  union(){
    rotate([90,0,90]) {
    rounded_cube([108,45,2],rsides=4,rvert=0);
    translate([48,0,0]) rounded_cube([12,45,6]);
    }
  }
  translate([-.01,52.5,20])
    cube([6.02,3,25.01]);
  translate([2,52.5,-.01])
    cube([4.02,3,45.02]);
}
//translate([-67.6,53]) 
*translate([-15,10])
rotate([-90,0])
difference(){
  rotate([-90,-90,0]) rounded_cube([45,135,2],rsides=4);
  translate([67,-.01,-.01])
    cube([3,2.02,25]);
}

module box(size,r=1,top=1,bottom=1,left=1,right=1,front=1,back=1)
{
  w=size[0];
  d=size[1];
  h=size[2];
  intersection(){
    cube([w,d,h]);
    minkowski(){
      translate([left?r:0,front?r:0,bottom?r:0]) cube([w-(left?r:0)-(right?r:0),d-(front?r:0)-(back?r:0),h-(top?r:0)-(bottom?r:0)]);
      sphere(r,$fn=30);
    }
  }
}
module rounded_rect(w,h,r) {
  translate([r,r]) circle(d=r*2,$fn=30);
  translate([r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,r]) circle(d=r*2,$fn=30);
  translate([r,0]) square([w-r*2,h]);
  translate([0,r]) square([r,h-r*2]);
  translate([w-r,r]) square([r,h-r*2]);
}
module rounded_cube(dims,rsides=2,rvert=0)
{
  w=dims[0];
  h=dims[1];
  d=dims[2];
  if(rvert==0)
  {
    linear_extrude(d) rounded_rect(w,h,rsides);
  } else {
    translate([rsides,rsides,rvert]) scale([1,1,rvert/rsides]) minkowski() {
      cube([w-rsides*2,h-rsides*2,(d-rvert*2)/(rvert/rsides)]);
      sphere(rsides,$fn=30);
    }
  }
}