difference() { union() {
linear_extrude(2) hull() {
  circle(d=7,$fn=30);
  translate([15,0]) circle(d=4,$fn=20);
}
cylinder(d=7,h=6,$fn=30);
translate([0,0,1]) cylinder(d1=7,d2=9,h=2,$fn=30);
translate([0,0,3]) cylinder(d=9,h=3,$fn=30);
}
  translate([0,0,-.01]) cylinder(d=4,h=2.02,$fn=20);
  translate([0,0,2]) linear_extrude(10,convexity=3) {
    for(r=[0:30:120]) rotate([0,0,r])
    circle(d=6,h=10,$fn=3);
  }
}