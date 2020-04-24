difference() {
  union() {
    intersection() {
      sphere(d=60,$fn=50);
      translate([-30,-10,-15]) cube([60,60,60]);
    }
    translate([0,34,-15]) rotate([0,0,-90]) {
      cylinder(d=10,h=3,$fn=40);
      translate([0,-5]) cube([18,10,3]);
    }
    for(m=[0,1]) mirror([m,0])
    translate([-34,-5,-15]) {
      cylinder(d=10,h=3,$fn=40);
      translate([0,-5]) cube([18,10,3]);
    }
  }
  sphere(d=56,$fn=50);
  translate([0,0,-16]) for(pos=[[-34,-5],[34,-5],[0,34]])
    translate(pos)
      cylinder(d=4,h=5,$fn=30);
}