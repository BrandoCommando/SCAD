t=1.6;
mirror([0,0,1]) {
linear_extrude(10,convexity=3) difference() {
  circle(d=6.5,$fn=30);
  circle(d=6.5-t*2,$fn=20);
}
translate([0,0,10])
  difference() {
    cylinder(d1=6.5,d2=30,h=20,$fn=50);
    translate([0,0,-.01]) cylinder(d1=6.5-t*2,d2=30-t*2,h=20.02,$fn=40);
  }
 translate([0,0,30])
  linear_extrude(10) difference() { circle(d=30,$fn=50); circle(d=30-t*2,$fn=40);
  }
}