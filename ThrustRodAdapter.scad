thrust=[10,24,9];
%cylinder(d=8,h=100,$fn=40);
//*
mirror([0,0,1]) linear_extrude(20,convexity=3) difference() {
  circle(d=5,$fn=25);
  translate([2,-2]) square([2,4]);
}
%translate([0,0,-12]) cylinder(d=19,h=24,$fn=70);
translate([0,0,13]) linear_extrude(7,convexity=3) difference() {
  circle(d=22,$fn=80);
  circle(d=8,$fn=40);
}
//*/
color("gold") translate([0,0,24]) linear_extrude(thrust[2],convexity=3) difference() {
  circle(d=thrust[1],$fn=80);
  circle(d=thrust[0],$fn=50);
}

translate([0,0,22.2+thrust[2]]) {
  color("gray") !difference() {
    union() {
      translate([0,0,2]) cylinder(d=24,h=8,$fn=70);
      *translate([0,0,-3])
        cylinder(d=8.6,h=1,$fn=40);
      *translate([0,0,-2])
        cylinder(d1=8.6,d2=thrust[2],h=2,$fn=40);
    }
    translate([0,0,-4.02]) cylinder(d=8.02,h=20,$fn=40);
    for(r=[0:120:359]) rotate([0,0,r]) {
      translate([6,-3,10-6]) cube([3,6,6.02]);
      translate([0,0,10-3]) rotate([0,90]) cylinder(d=3,h=20,$fn=20);
    }
  }
}