difference() {
  union() {
    linear_extrude(20,convexity=4) {
      difference() {
        union() {
          circle(d=31,$fn=60);
        for(m=[0,1]) mirror([m,0])
          translate([0,-3.8,0]) square([30,7.6]);
          translate([-10,-24]) square([20,20]);
        }
        circle(d=27,$fn=60);
        for(m=[0,1]) mirror([m,0])
        translate([0,-2,0]) square([30,4]);
      }
    }
        for(m=[0,1]) mirror([m,0])
    translate([-30,-8]) cube([16.5,5,13]);
  }
  translate([0,0,10]) rotate([90,0]) {
    cylinder(d=7,h=30,$fn=30);
    cylinder(d=18,h=20,$fn=40);
  }
  for(m=[0,1]) mirror([m,0])
    rotate([0,0,-90]) translate([-10,22,10]) rotate([0,90]) {
      cylinder(d=7,h=20,$fn=30);
      translate([0,0,13.8]) cylinder(d=12.5,h=6,$fn=6);
    }
}