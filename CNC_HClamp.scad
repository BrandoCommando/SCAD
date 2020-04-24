hcw=80; // clamp width
hch=20; // clamp height
hcd=6;  // clamp depth
hclamp();
module rounded_rect(w,h,r) {
  translate([r,r]) circle(d=r*2,$fn=30);
  translate([r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,r]) circle(d=r*2,$fn=30);
  translate([r,0]) square([w-r*2,h]);
  translate([0,r]) square([r,h-r*2]);
  translate([w-r,r]) square([r,h-r*2]);
}
module rounded_cube(w,h,d,rsides,rvert=0)
{
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
module hclamp() {
  difference(){
    rounded_cube(hcw,hch,hcd,8);
    translate([6,-.01]) mirror([1,0]) rotate([0,60]) cube([10,20.02,20]);
    translate([0,3,-.01]) mirror([0,1,0]) rotate([0,0,10]) cube(20);
    translate([0,17,-.01]) rotate([0,0,10]) cube(20);
    translate([8,7.6,-.01]) rounded_cube(hcw-23,4.4,8.02,2);
    translate([hcw-8,10,-.01]) cylinder(d=4.4,h=8.02,$fn=20);
  }
}