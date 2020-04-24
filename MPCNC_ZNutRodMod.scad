rotate([0,0,90]) difference(){
  rotate([-90,0,-90]) linear_extrude(102) intersection() {
    circle(d=20,$fn=50);
    translate([-20,0]) square([40,6]);
  }
  for(x=[5,30,55,80]) translate([x,0,-8.01]) rotate([0,0,30]) {
    cylinder(d=3,h=10,$fn=20);
    translate([0,0,5]) cylinder(d=6.8,$fn=6,h=4);
  }
}