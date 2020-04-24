screwd=4.8;
screwd2=4;
hexd1=13;
hexd2=17;

hexagon_half();
translate([60,0]) mirror([1,0]) hexagon_half();

module hexagon_half() {
difference(){
intersection(){
  hexagon_full();
  translate([-8,0]) cube([35,48,8]);
}
  translate([-0.01,-0.01,-0.01]) cube([20.01,8.01,8.02]);
  translate([-0.01,40,-0.01]) cube([20.01,8.01,8.02]);
  translate([19.99,4,4]) rotate([0,90,0]) cylinder(d=screwd2,h=10,$fn=20);
  translate([19.99,44,4]) rotate([0,90,0]) cylinder(d=screwd2,h=10,$fn=20);
}
}
module hexagon_full(){
difference(){
  union(){
difference(){
  cube([54,48,8]);
  translate([27,24,-0.01]) cylinder(d=hexd1,h=8.02,$fn=50);
  translate([27,24,4.4]) cylinder(d=hexd2,h=4,$fn=50);
}
mirror([1,0,0])
translate([0,14]) difference(){
  translate([0,0]) {
    cube([4,20,8]);
    translate([4,0,4]) rotate([-90,0,0]) cylinder(d=8,h=20,$fn=30);
  }
  translate([4,-0.01,4]) rotate([-90,0,0]) cylinder(d=screwd,h=20.02,$fn=30);
}
translate([54,0,0])
translate([0,14]) difference(){
  translate([0,0]) {
    cube([4,20,8]);
    translate([4,0,4]) rotate([-90,0,0]) cylinder(d=8,h=20,$fn=30);
  }
  translate([4,-0.01,4]) rotate([-90,0,0]) cylinder(d=screwd,h=20.02,$fn=30);
}
}
  translate([1,24,-0.01]) cylinder(d=screwd,h=8.02,$fn=30);
translate([52,24,-0.01]) cylinder(d=screwd,h=8.02,$fn=30);
}
}