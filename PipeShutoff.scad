
union() {
translate([-150,0]) rotate([0,90]) linear_extrude(300) difference() { circle(d=25.4*1.05,$fn=50); circle(d=25.4*.75,$fn=40); }
cylinder(d=15,h=30,$fn=30);
translate([0,0,30]) rotate([90,0]) translate([0,0,-8]) linear_extrude(16) hullkids() {
  circle(d=4,$fn=20);
  translate([20,0]) circle(d=4,$fn=20);
  translate([40,12]) circle(d=4,$fn=20);
  translate([80,12]) circle(d=4,$fn=20);
}
}

module hullkids() {
  for(a=[0:$children-2])
  {
    hull() {
      children(a);
      children(a+1);
    }
  }
}