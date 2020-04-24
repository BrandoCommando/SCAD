%import("Servo13.stl");
servo();
*translate([-20,-20,0]) difference() {
  cylinder(d=20,h=3,$fn=40);
  for(r=[0:45:359]) rotate([0,0,r]) translate([7.5,0,-.01]) cylinder(d=2,h=3.02,$fn=12);
  translate([0,0,-.01]) cylinder(d=3,h=3.02,$fn=30);
  translate([0,0,1.2]) cylinder(d=9,h=3,$fn=40);
}
!union()
{
  foot();
  translate([-30,-18,0]) cube([50,30,5]);
  translate([-25.8,16.8,5.5]) rotate([90,0])
  {
    topmod();
    sidemod();
  }
}
*vertical();
module foot() {
  *translate([-121.11,-33.82]) import("Chip-E_-_RobotGeek_Biped/files/Foot_Left.stl"); 
  *translate([-32.8,-37.11]) cube([65.6,74.3,5]);
  footpath=[[-22.8,-37.11],[32.8,-37.11],[32.8,37.11],[-32.8,37.11],[-32.8,-27.11]];
  difference() {
    linear_extrude(5) polygon(footpath);
    translate([32.8-7,-33.82+3.6,4.4]) cylinder(d=7,h=2,$fn=30);
  }
  linear_extrude(6) difference() {
    polygon(footpath);
    offset(r=-3) polygon(footpath);
  }
}
module vertical() {
  mirror([0,0,1])
  difference() {
    intersection() {
      sidemod(1);
      translate([-7,-5]) cube([54,30,16]);
    }
    translate([-4,5]) cube([10,10,30]);
  }
}
module sidemod(both=0) {
  translate([0,10]) for(m=both?[0,1]:[0]) mirror([0,m,0]) translate([-7,-5-10,8.2]) difference(){
    union(){
      cube([54,4.5,22]);
      translate([0,0,4.3]) cube([6.5,25,30]);
      translate([47,0,4.3]) cube([6.5,25,17.7]);
    }
    *translate([-.01,-.01,22]) cube([8,5,14.5]);
    translate([-.01,12,20]) cube([10,14,11.3]);
    translate([7,-.01,both?8:3]) cube([39,28,16]);
    /*
    rotate([0,0,45]) translate([-1,-8,-2]) cube([5.3,30,40]);
    translate([-1,-8,-2]) cube([5.3,13,40]);
    translate([48,0]) rotate([0,0,-45]) translate([-1,-8,-2]) cube([5.3,30,40]);
    translate([50,0]) translate([-1,-8,-2]) cube([5.3,13,40]);
    */
    for(x=[3,51],y=[9.5,20.5])
      translate([x,y,0]) cylinder(d=3,h=40,$fn=20);
    for(x=[9.6,24.5,29.5,44.5])
      translate([x,2.5,-.01]) cylinder(d=2.5,h=30,$fn=20);
  }
}
module topmod() {
translate([0,0,40.5]) {
  difference(){
    union(){
      translate([-1,0,-1]) cube([21,20,3]);
      translate([10,10]) cylinder(d=5,h=3,$fn=40);
    }
    translate([10,10,-1.02]) cylinder(d=3,h=5.02,$fn=30);
  }
  *translate([10,10]) 
    cylinder(d=6,h=3,$fn=30);
}
}
module servo() {
cube([40,20,37]);
  #translate([11,10,-2]) cylinder(d=6,h=48,$fn=20);
translate([-6.25,0,10]) difference() {
  cube([52.5,20,2.3]);
  for(x=[2,50.5],y=[4.5,15.5])
  translate([x,y,-.01]) cylinder(d=4.5,h=3,$fn=30);
}
}