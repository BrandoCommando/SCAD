intersection() {
  translate([-50,-50]) cube([100,100,2.5]);
  union(){
  translate([2,6,1]) rotate([-90,0]) cylinder(d=5,h=36,$fn=30);
    translate([2,3,1]) rotate([-90,0]) cylinder(d1=1,d2=5,h=3,$fn=30);
  translate([-8,40]) cube([20,8,3.5]);
linear_extrude(1.2) {
  square([4,16]);
}
}
}