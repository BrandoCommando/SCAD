difference() {
  union() {
    translate([0,-2]) cube([14,25,2]);
translate([0,1,2]) plate_bracket();
  }
  for(y=[0,14.6])
    translate([7,2.95+y,-.1]) {
      cylinder(d=3,h=14,$fn=20);
      translate([0,0,2]) cylinder(d=5,h=5,$fn=40);
    }
}
module plate_bracket() {
  difference() {
    union(){
      translate([3,15,0]) rotate([90,0]) linear_extrude(10, convexity=3) {
        square([8,6]);
        translate([4,6]) circle(d=8,$fn=40);
      }
      translate([0,10]) for(m=[0,1]) mirror([0,m]) translate([0,-10])
      translate([3,5]) mirror([0,0,1]) rotate([90,180,90]) linear_extrude(8,convexity=4) {
        difference(){
          square([4,4]);
          translate([4,4]) circle(r=4,$fn=40);
        }
      }
    }
    translate([7,0,7]) rotate([-90,0]) cylinder(d=3,h=20,$fn=20);
    translate([0,7,-.01]) cube([20,6,20]);
  }
}