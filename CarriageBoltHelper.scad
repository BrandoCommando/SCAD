difference() {
  cube([10,10,4]);
  translate([.8,.8,.8]) cube([8.4,8.4,6]);
  translate([5,5,-.1]) cylinder(d=8,h=4,$fn=40);
}