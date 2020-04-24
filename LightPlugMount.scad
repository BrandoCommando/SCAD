
difference() {
  linear_extrude(6,convexity=3) shell();
  *cube([2,58,19.99]);
  *for(y=[5,23,41]) translate([-0.01,y,4.01]) cube([3.02,12,16]);
}
mirrory(58) for(x=[10,140]) translate([x,2]) difference() {
  union() {
    cube([8,4,2]);
    translate([4,4]) cylinder(d=8,h=2,$fn=40);
  }
  translate([4,4,-.01]) cylinder(d=3,h=2.02,$fn=20);
}
*for(y=[0,56]) translate([0,y]) cube([160,2,20]);
*cube([160,58,2]);
*translate([158,0]) cube([2,58,20]);

module lid() {
  difference() {
    translate([2,2]) offset(2,$fn=30) square([154,54]);
    mirrory(58) for(x=[10,140]) translate([x,2]) translate([4,4]) circle(d=3,$fn=20);
  }
}
module shell() {
  difference() {
    translate([2,2]) offset(2,$fn=30) square([154,54]);
    translate([3,3]) offset(1,$fn=20) square([152,52]);
  }
}
module mirrory(off=0)
{
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}