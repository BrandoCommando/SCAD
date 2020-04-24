height=150;
od=61;
maind=54.6;
wt=1.61;
difference(){
  union() {
    cylinder(d=od,h=height,$fn=100);
    translate([-20,od/2-10]) cube([40,15,height]);
  }
  translate([0,0,-.01]) cylinder(d=maind,h=height+.02,$fn=100);
  translate([0,0,3]) cylinder(d=od-(wt*2),h=height+.02,$fn=100);
  translate([0,0,3]) rotate_extrude($fn=100) {
    translate([(od-(wt*2))/2-2,0]) circle(r=2,$fn=20);
  }
  for(z=[20,height/2,height-20])
  translate([0,0,z]) rotate([-90,0]) {
    cylinder(d=4,h=50,$fn=30);
    cylinder(d=12,h=od/2-1,$fn=40);
    translate([0,0,od/2-1.01]) cylinder(d1=12,d2=4,h=2,$fn=40);
    translate([0,0,od/-2-1]) cylinder(d=14,h=4,$fn=40);
  }
}