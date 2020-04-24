difference() {
cylinder(d1=1.75*25.4,d2=1.7*25.4,h=8,$fn=80);
  translate([0,0,1]) cylinder(d=41,h=9.01,$fn=80);
}
linear_extrude(1) {
  hull() {
  circle(d=50,h=1,$fn=100);
    translate([50,50]) circle(d=10,$fn=20);
    translate([40,0]) circle(d=10,$fn=20);
  }
}