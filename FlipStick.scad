difference() {
  linear_extrude(4) difference() {
    hull(){
      circle(d=3,$fn=20);
      translate([0,10]) circle(d=3,$fn=20);
      translate([80,0]) circle(d=5,$fn=30);
      translate([80,10]) circle(d=5,$fn=30);
    }
    translate([75,5]) circle(d=8,$fn=40);
  }
  translate([0,-5,2]) rotate([0,-45-90]) cube(20);
}