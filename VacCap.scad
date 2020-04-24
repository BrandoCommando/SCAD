difference() {
  translate([0,0,-2]) cylinder(d=66,h=21.99,$fn=100);
  cylinder(d=61,h=20,$fn=100);
}
zh=6/(360/5);
translate([0,0,8]) for(i=[0:75]) translate([0,0,zh*i]) rotate([0,0,5*i]) rotate([2,0]) rotate_extrude(angle=5,$fn=200) {
  translate([31,0]) {
    circle(d=2,$fn=20);
  }
}