difference() {
  cylinder(d=12,h=17,$fn=50);
  translate([0,0,-.01]) cylinder(d=8,h=17.02,$fn=40);
  translate([-3,0,-.01]) cube([6,10,17.02]);
}