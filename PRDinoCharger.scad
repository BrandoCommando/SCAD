union() {
intersection() {
  translate([0,10,8]) rotate([0,90]) {
    cylinder(d=20,h=2);
    translate([0,0,2]) cylinder(d1=20,d2=18,h=2);
    translate([0,0,4]) cylinder(d1=18,d2=20,h=2);
    translate([0,0,6]) cylinder(d=20,h=50);
    translate([0,0,56]) cylinder(d1=20,d2=18,h=2);
    translate([0,0,58]) cylinder(d1=18,d2=20,h=2);
    translate([0,0,60]) cylinder(d=20,h=2);
  }
  cube([62,20,16]);
}
translate([-2,-1,4]) difference() {
  linear_extrude(9,convexity=5) {
    polygon([[13,20],[15,27],[20,28],[20,20],[25,25],[30,20],[32.5,24],[35,20],[40,25],[45,20],[47,25],[50,25],[52,20],[30,10]]);
  }
  translate([0,15,-5]) rotate([-45,0]) cube([62,20,20]);
}
}