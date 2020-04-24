wheelr=6;
difference() {
  rotate_extrude($fn=100) {
    hull() {
      translate([30-wheelr,wheelr]) circle(r=wheelr,$fn=40);
      translate([30-wheelr,24-wheelr]) circle(r=wheelr,$fn=40);
      square([1,24]);
    }
  }
  for(r=[0:60:359]) rotate([0,0,r]) {
    translate([20,0,-.01]) {
      cylinder(d=3,h=30,$fn=20);
      translate([0,0,r%120==0?21.02:0])
        translate([-2.95,-2.95]) cube([5.9,5.9,4]);
        //rotate([0,0,30]) cylinder(d=6.9,h=5,$fn=6);
      translate([0,0,r%120!=0?20.02:0])
        cylinder(d=6,h=4,$fn=30);
    }
  }
  *cylinder(d=60,h=24,$fn=100);
  translate([0,0,-.01]) {
    cylinder(d=18,h=24.02,$fn=40);
    cylinder(d=22,h=7,$fn=60);
    translate([0,0,17]) cylinder(d=22,h=7.02,$fn=60);
  }
}
