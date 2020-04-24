intersection(){
  translate([-30,-30]) cube([60,60,200]);
  rotate([-20,0]) translate([0,0,-2]) difference() {
  union(){
    difference(){
      cylinder(d1=25,d2=27,h=30,$fn=50);
      translate([-20,-20,-.01]) rotate([14,0]) translate([0,0,-5]) cube([40,14,30.02]);
    }
    translate([0,0,30]) {
      sphere(d=27,$fn=50);
      rotate([20,0]) {
        cylinder(d=27,h=30,$fn=50);
        translate([0,0,30]) {
          sphere(d=27,$fn=50);
          rotate([20,0]) {
            cylinder(d1=27,d2=19,h=30,$fn=50);
            translate([0,0,30])
              cylinder(d=19,h=10,$fn=50);
          }
        }
      }
    }
  }
  difference() {
    translate([0,0,-.01]) cylinder(d1=21,d2=23,h=30.02,$fn=40);
    translate([-20,-20,-.02]) rotate([14,0]) translate([0,0,-5])cube([40,16,30.04]);
  }
  translate([0,0,30]) {
    sphere(d=23,$fn=40);
    rotate([20,0]) {
      cylinder(d=23,h=30.02,$fn=40);
      translate([0,0,30]) {
          sphere(d=23,$fn=40);
        rotate([20,0]) {
          cylinder(d1=23,d2=16,h=30.02,$fn=40);
          translate([0,0,30])
            cylinder(d=16,h=10.02,$fn=40);
        }
      }
    }
  }
}
}