//rotate([0,90,0])
difference() {
  mg90s(1);
  for(x=[6]) translate([x,5,-.01]) {
    cylinder(d=3,h=22.3,$fn=20);
    cylinder(d=6.4,h=3.4,$fn=30);
    rotate([0,0,45]) translate([0,0,19.2]) cylinder(d=6.3,h=3.2,$fn=30);
  }
  translate([-1,-5,-1]) cube([14,36,19.2]);
}
module mg90s(mod=0) {
  mh=22.8;
  mw=12;
  bd=22.2;
  difference(){
  union(){
  cube([mw,mh,bd]);
  translate([mw/2,mh-mw/2,bd-.01]) cylinder(d=mw,h=6.22,$fn=50);
  translate([mw/2,mh-mw/2,bd+5.98]) cylinder(d=4.25+(mod?2:0),h=3.22,$fn=20);
  translate([mw/2,mh-mw,bd-.01]) {
    cylinder(d=5.2,h=6.2,$fn=30);
    translate([-2.6,0]) cube([5.2,5.2,6.2]);
  }
  translate([0,-4.5,bd-4]) cube([mw,mh+9,2.8]);
  }
  if(mod)
  translate([mw/2,mh-mw/2,-1]) {
    cylinder(d=3,h=34.22,$fn=20);
    rotate([0,0,45]) cylinder(d=8,h=4,$fn=4);
  }
  translate([0,mh/2]) for(m=[0,1]) mirror([0,m]) translate([0,-mh/2]) translate([mw/2,-2.75,bd-4.01]) {
    cylinder(d=2.5,h=4.02,$fn=20);
    translate([-.75,-2]) cube([1.5,2,4.02]);
  }
  }
}