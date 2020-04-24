bolt_d=inches(1/2);
set_ang=[45:90:359];
m4_dist=18;
od=48;
wall_id=44;
difference() {
  union() {
    cylinder(d=od,h=10,$fn=90);
    cylinder(d=20,h=20,$fn=60);
    translate([0,0,17]) for(r=set_ang) rotate([0,0,r]) rotate([0,90]) translate([-3,-5,7]) cube([12,10,6]);
  }
  translate([0,0,16]) for(r=set_ang) rotate([0,0,r]) rotate([0,90]) {
      cylinder(d=3,h=20,$fn=20);
      translate([-14,-3,8]) cube([17.1,6,2.4]);
    }
  translate([0,0,-.01]) {
    cylinder(d=bolt_d,h=20.02,$fn=30);
    for(r=[0:90:359]) rotate([0,0,r]) translate([m4_dist,0]) cylinder(d=4.4,h=10.02,$fn=30);
  }
}
//mirror([0,0,1])
!translate([0,50])
{
  difference(){
    cylinder(d=od,h=7,$fn=90);
    translate([0,0,-.01]) {
      cylinder(d=m4_dist*2-6,h=10.02,$fn=80);
      for(r=[0:90:359]) rotate([0,0,r]) translate([m4_dist,0]) cylinder(d=4.4,h=10.02,$fn=30);
     
    }
    *for(r=[0,90]) rotate([0,0,r]) translate([-25,-5,5+1.2]) cube([50,10,5]);
    *translate([0,0,5+1.2]) difference() {
      translate([0,0,.01]) cylinder(d=od+1,h=5,$fn=80);
      cylinder(d=wall_id,h=5,$fn=80);
    }
  }
}
function inches(mm) = 25.4 * mm;