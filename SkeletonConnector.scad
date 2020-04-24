tl=40;
translate([0,0,2]) intersection() {
  union() {
    rotate([0,90]) cylinder(d=12,h=tl,$fn=40);
    translate([tl/2,0]) for(m=[0,1]) mirror([m,0]) translate([tl/-2,0]) {
      hull() {
      translate([-1,0]) sphere(d=12,$fn=40);
      rotate([0,90]) rotate_extrude() {
        translate([8,5]) circle(d=5,$fn=40);
      }
    }
    }
  }
  translate([-15,-15,-5]) cube([80,30,20]);
}