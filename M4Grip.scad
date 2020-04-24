vcw=76;
vch=20;
vcd=16;
vcrd=12;
vclamp();
module vclamp() {
  difference(){
    cube([vcw,vch,vcd],rvert=0);
    
    translate([0,-.01,2]) rotate([0,-18,0]) cube([vcw,vch+.02,vcd]);
    translate([vcw*2/3,0,0]) {
      translate([vcrd/2+2,-.01,vcd]) rotate([0,40]) cube([vcw,vch+.02,vcd]);
      translate([0,-.01,vcd]) rotate([-90,0]) cylinder(d=vcrd,h=vch+.02,$fn=30);
      translate([0,-.01,vcd-vcrd/2-4]) mirror([0,0,1]) rotate([0,-15,0]) cube([vcw,vch+.02,vcd]);
      translate([0,-.01,vcd-vcrd/2-4]) mirror([0,0,1]) mirror([1,0]) rotate([0,-7,0]) cube([vcw,vch+.02,vcd]);
      for(r=[-35:2.5:50])
        translate([0,vch/2,vcd-.01]) rotate([0,r]) translate([0,0,vcd*-2]) cylinder(d=4.5,h=vch+vcd,$fn=20);
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
