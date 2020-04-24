difference(){
  cube([20,20,9]);
  translate([10,8]) hanging_hook();
}
module hanging_hook() {
  translate([0,0,-.01]) {
    cylinder(d=9,h=5,$fn=30);
    translate([0,5,1]) cylinder(d1=5,d2=9,h=4.01,$fn=26);
    translate([0,5]) cylinder(d=5,h=1.01,$fn=26);
    translate([-2.5,0]) cube([5,5,5]);
    translate([0,0,4]) {
      translate([0,5,1]) cylinder(d=9,h=3,$fn=40);
      translate([-4.5,0,1]) cube([9,5,3]);
      cylinder(d=9,h=4,$fn=40);
    }
  }
}