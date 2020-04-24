difference() {
  union() {
    translate([-5,-5]) intersection(){
      union() {cube([10,20,30]);
      rotate([0,-15,0]) cube([10,20,40]);
      }
      translate([-20,0]) cube([30,16,26]);
    }
    translate([0,0,26]) cylinder(d=7,h=6,$fn=40);
  }
  translate([0,0,6]) cylinder(d=3,h=27,$fn=20);
}

!linear_extrude(3) {
  difference() {
    circle(d=7.2,$fn=40);
    circle(d=3,$fn=20);
  }
}