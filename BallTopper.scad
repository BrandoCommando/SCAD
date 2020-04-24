difference() {
  sphere(d=20,$fn=80);
  mirror([0,0,1]) {
    translate([0,0,-4])
      cylinder(d=8.4,h=30,$fn=50);
    translate([-10,-10,6.5]) cube(20);
  }
}