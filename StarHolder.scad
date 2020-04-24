mirror([0,0,1]) difference() {
  cylinder(d1=12,d2=23,h=80,$fn=50);
  translate([0,0,-.01])
  {
    cylinder(d=9,h=20,$fn=40);
    translate([0,0,24]) cylinder(d1=0,d2=13,h=6.02,$fn=50);
    translate([0,0,24]) intersection() {
      translate([0,0,6]) cylinder(d=20,h=80.02,$fn=50);
      translate([0,0,-24]) cylinder(d1=9,d2=20,h=80.02,$fn=50);
    }
  }
}