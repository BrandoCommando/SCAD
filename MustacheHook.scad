  translate([20,0,5]) rotate_extrude(angle=180,$fn=50) {
    translate([20,0]) circle(r=5,$fn=30);
  }
  translate([-20,0,5]) rotate_extrude(angle=180,$fn=50) {
    translate([20,0]) circle(r=5,$fn=30);
  }
  translate([40,0,5]) sphere(r=5,$fn=30);
  translate([-40,0,5]) sphere(r=5,$fn=30);
translate([0,0,5]) rotate([90,0]) {
  *scale([1,0.5,1]) rotate([0,0,45]) cylinder(d1=10,d2=25,h=20,$fn=4);
  cylinder(d=10,h=50,$fn=30);
}
difference() {
  union(){
  translate([-16,-50,0]) cube([32,6,10,]);
  for(m=[0,1]) mirror([m,0]) translate([-16,-44,5]) rotate([90,0]) { cylinder(d=10,h=6,$fn=40);
  }
  }
  for(m=[0,1]) mirror([m,0]) translate([-16,-43.99,5]) rotate([90,0]) { cylinder(d1=6,d2=4,h=3,$fn=20);
    translate([0,0,2.99]) cylinder(d=4,h=3.03,$fn=20);
}
}
*translate([-5,-50,5]) difference() {
  cube([10,4,25]);
  translate([5,-.01,20]) rotate([-90,0]) cylinder(d=4,h=6.02,$fn=20);
}
*translate([-6,-3]) cube([12,20,6]);