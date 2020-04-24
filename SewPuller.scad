difference() {
  intersection(){
    cube([100,6,2]);
    minkowski(){
      translate([1,1]) linear_extrude(1) rounded_rect(98,4,1);
      sphere(1,$fn=20);
    }
  }
  translate([3,3,-.01]) cylinder(d=2,h=3,$fn=12);
  translate([97,3,-.01]) cylinder(d=2,h=3,$fn=12);
  *translate([0,-.01,.4]) rotate([0,-3]) cube([40,8,3]);
  *translate([100,-.01,.4]) mirror([1,0]) rotate([0,-3]) cube([40,8,3]);
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