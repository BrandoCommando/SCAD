difference() {
  union() {
    cylinder(d=20,h=1,$fn=50);
    translate([0,0,1]) cylinder(d1=20,d2=18,h=1,$fn=50);
    translate([0,0,2]) difference() {
      union() {
        cylinder(d=18,h=6.6,$fn=50);
        translate([0,0,6.6]) cylinder(d1=18,d2=20,h=1,$fn=50);
        translate([0,0,7.6]) cylinder(d=20,h=1,$fn=50);
      }
      translate([0,0,0.5]) cylinder(d=16.2,h=10,$fn=50);
      *translate([0,0,-.01]) cylinder(d=15,h=10,$fn=50);
    }
  }
  translate([0,0,-.01]) cylinder(d=15,h=100,$fn=32);
}