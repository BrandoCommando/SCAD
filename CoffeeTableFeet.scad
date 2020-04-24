difference() {
  rotate([0,0,45]) {
    cylinder(d2=24,d1=22,h=1,$fn=4);
    translate([0,0,1]) cylinder(d1=24,d2=22,h=6,$fn=4);
  }
  translate([-7,-7,2]) cube(14);
}