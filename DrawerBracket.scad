in=25.4;
ft=12*in;
tq=in*3/4;
openbox(2*ft,2*ft,8*in);
translate([-1,3*in,-6]) rotate([0,-90])
{
  difference() {
    cylinder(d=22,h=7,$fn=50);
    translate([0,0,-.01]) cylinder(d=8,h=7.02,$fn=30);
  }
  translate([0,0,in*-6]) cylinder(d=8,h=6*in,$fn=30);
  translate([0,0,7.2]) cylinder(d=12,h=5,$fn=6);
}
translate([0.2,3*in,-0]) rotate([0,-90]) translate([0,0,-10]) rotate([0,0,-90]) bracket(11);
module bracket(t=9) {
  difference(){
      intersection() {
        translate([-34,-7]) cube([68,13,t]);
        union() {
          translate([0,0,t-1]) cylinder(d1=12,d2=10,h=1,$fn=30);
          translate([-18,0]) cube([36,6,t-1]);
            mirrorx() translate([-18,6]) cylinder(r=6,h=t-1,$fn=40);
          cylinder(d=14,h=t-1,$fn=30);
        }
      }
    mirrorx() translate([-13.5,-.01,(t-1)/2]) rotate([-90,0]) {
      cylinder(d=4,h=6.02,$fn=20);
      translate([0,0,0]) cylinder(d1=8,d2=4,h=2,$fn=30);
    }
    translate([0,0,-.01]) cylinder(d=8.2,h=t+.02,$fn=24);
  }
}
module mirrorx(offset=0)
{
  translate([0,offset]) for(m=[0,1]) mirror([m,0]) translate([0,offset*-1]) children();
}
module openbox(w,d,h,t=tq)
{
  #cube([w,d,t]);
  *translate([0,0,t]) cube([t,d,h-t]);
  translate([w-t,0,t]) cube([t,d,h-t]);
  translate([t,0,t]) cube([w-t*2,t,h-t]);
  translate([t,d-t,t]) cube([w-t*2,t,h-t]);
}