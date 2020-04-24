translate([0,0,30]) {
linear_extrude(30)
difference() {
  circle(d=46.5,$fn=100);
  circle(d=43.5,$fn=90);
}
translate([0,0,25]) rotate_extrude($fn=100) translate([22,0]) circle(d=2,$fn=20);
}
difference() {
  union(){
  cylinder(d=38,h=20,$fn=100);
  translate([0,0,20]) cylinder(d1=38,d2=46.5,h=10,$fn=100);
  }
  translate([0,0,-.01]) cylinder(d1=35,d2=35,h=20,$fn=90);
  translate([0,0,19.98]) cylinder(d1=35,d2=43.5,h=10.03,$fn=90);
}