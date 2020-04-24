difference() {
  cylinder(d1=6,d2=5.5,h=6,$fn=40);
  translate([1.6,0,-.01]) cylinder(d=4,h=6.02,$fn=28);
}
linear_extrude(1) difference() {
  translate([-1.6,0]) circle(d=9,$fn=60);
  translate([1.6,0]) circle(d=4,$fn=28);
}
translate([-1.5,0,5]) rotate([0,-30,0]) cylinder(d=2.5,h=3,$fn=20);