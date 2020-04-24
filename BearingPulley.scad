part="arm";
if(part=="arm") arm();
else if(part=="skin") skin();
else if(part=="all") {
  translate([0,0,2]) arm();
  translate([0,0,5]) mirror([0,0,1]) arm();
  %skin();
}
module arm(){
  difference(){
    translate([0,0,-5]) {
      translate([0,0,2]) cylinder(d1=10,d2=8,h=1.5,$fn=30);
      translate([0,0,3.5]) cylinder(d=7,h=3,$fn=20);
      difference() { union() {
          cylinder(d=32,h=4,$fn=50);
          translate([0,-10]) cube([20,20,4]);
          translate([20,-10]) cube([10,20,2]);
          translate([30,-10]) cube([5,20,6.5]);
          translate([15,-10]) cube([5,20,6.5]);
        }
        translate([17.5,-6.5,-.01]) cylinder(d=3,h=10,$fn=20);
        translate([17.5,6.5,-.01]) cylinder(d=3,h=10,$fn=20);
        translate([32.5,-6.5,-.01]) cylinder(d=3,h=10,$fn=20);
        translate([32.5,6.5,-.01]) cylinder(d=3,h=10,$fn=20);
        translate([0,0,2]) cylinder(d=30,h=2.02,$fn=50);
      }
    }
    translate([0,0,-5.01]) cylinder(d=3,h=6.52,$fn=20);
    translate([35.01,0,1.5]) rotate([0,-90]) cylinder(d=5,h=6,$fn=30);
  }
}
module skin() {
  difference(){
    cylinder(d=28,h=7,$fn=50);
    translate([0,0,-.01]) cylinder(d=22.6,h=7.02,$fn=50);
    translate([0,0,3.5]) rotate_extrude($fn=50) {
      translate([15,0,0]) scale([1.5,2]) circle(d=3.5,$fn=30);
    }
  }
}