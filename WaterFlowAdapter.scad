$fn=40;
difference() {
  union() {
    translate([inches(-1/8),inches(-1/8)]) cube(inches(1/4));
    translate([0,0,inches(1/4)]) {
      cylinder(d1=inches(1/4),d2=9,h=4);
      translate([0,0,4])
        cylinder(d1=9,d2=7,h=2);
      translate([0,0,6])
        cylinder(d1=7,d2=8,h=1);
      translate([0,0,7])
        cylinder(d1=8,d2=7,h=2);
      translate([0,0,9])
        cylinder(d1=7,d2=8,h=1);
      translate([0,0,10])
        cylinder(d1=8,d2=7,h=2);
      translate([0,0,12])
        cylinder(d=7,h=2);
      translate([0,0,14])
        cylinder(d1=7,d2=8.5,h=1);
      translate([0,0,15])
        cylinder(d1=8.5,d2=5,h=6);
    }
  }
translate([0,0,-.01]) cylinder(d=4,h=inches(2),$fn=40);
}
function inches(in) = 25.4*in;