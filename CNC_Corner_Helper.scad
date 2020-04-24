difference() {
  cube([70,70,40]);
  translate([-0.01,-0.01]) rotate([0,-45]) cube([20,80,20]);
  translate([-0.01,-0.01]) rotate([45,0]) cube([80,20,20]);
  translate([20,20,-0.01]) cube(60);
  *translate([-.01,-.01,30]) cube(51);
  translate([-.01,-.01,10]) cube([51,16,50]);
  translate([-.01,-.01,10]) cube([16,61,50]);
  translate([40,-.01,-0.01]) cube([40.01,16,41]);
  translate([-0.01,40,-0.01]) cube([16,40.01,41]);
  translate([30,10,-0.01]) {
    cylinder(d=4,h=30,$fn=20);
    translate([0,0,5]) cylinder(d1=10,d2=12,h=6,$fn=30);
  }
  translate([10,30,-0.01]) {
    cylinder(d=4,h=30,$fn=20);
    translate([0,0,5]) cylinder(d1=10,d2=12,h=6,$fn=30);
  }
}