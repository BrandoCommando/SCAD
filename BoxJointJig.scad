skip_jaw=1;
include <QRClamp.scad>;
rail_w=19.6;
rail_len=25.4*4;

rail();
module rail(clamp=1) {
  rotate([90,0]) rotate([0,90,0]) cube([10,rail_w,rail_len]);
  if(!clamp)
    intersection() {
      translate([10,0,10]) groove_clamp(20,0);
      translate([0,-10,0]) cube([20,10,rail_w]);
    }
  else difference() {
    union() {
      mirror([0,1,0]) cube([20,20,rail_w]);
      intersection() {
      translate([10,-20,10]) groove_clamp(20,10);
        rotate([0,0,-90]) cube([30,20,rail_w]);
      }
    }
    translate([9.99,-20,10]) cam_sub(20.2);
    translate([10,0]) for(m=[0,1]) mirror([m,0]) translate([-10,0])
    {
      intersection()
      {
      translate([-.01,-14,10]) rotate([0,90]) cylinder(d1=30,d2=15.5,h=7.25,$fn=40);
      translate([-.01,-20.01,15]) cube([7.25,12,5.1]);
      }
      //translate([-.01,-20.01,15]) cube([7.25,11,5.1]);
    }
  }
}
module shim(w=16.1,h=9,r=2)
{
//for(x=[0,32.6]) translate([x,0])

  translate([-.1,0]) cube([16.1,50,7]);
  translate([-.1,0,9]) rotate([-90,0]) cube2([16.1,9,50]);
translate([-17,0]) difference() {
  cube([50,3,12]);
  for(x=[6,44])
    translate([x,-.01,6]) rotate([-90,0]) {
      cylinder(d=4,h=5,$fn=30);
      cylinder(d1=8,d2=4,h=2,$fn=40);
    }
}
}

module cube2(dims,r=2)
{
  linear_extrude(dims[2],convexity=4) {
    hull() {
      for(x=[r,dims[0]-r],y=[r,dims[1]-r])
        translate([x,y]) circle(r=r,$fn=30);
    }
  }
}