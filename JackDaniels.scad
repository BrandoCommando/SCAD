
color("purple") intersection() {
  cube([85,67,3]);
  difference() {
  
  translate([42,23,-.01]) difference() {
    translate([0,-1.6]) scale([2,0.74]) cylinder(d=48,3.01,$fn=60);
    translate([0,0,-.01]) scale([0.98,.54]) cylinder(d=48,h=4.02,$fn=60);
  }
}
}
difference(){
  cube([85,67,3]);
  translate([5,5,1.3]) union(){
  scale([75/125,75/125,1]) translate([62,45,-1]) scale([1,1,10]) translate([0,0,-2]) import("JackDanielsPositive.stl");
    translate([38,10,-1]) linear_extrude(10) text("BRAND",size=4,valign="center",halign="center");
  }
}
*difference(){
  import("Jack_Daniels_-_Logo_-_We3dUK.stl");
  #translate([-80,-60,-.01]) cube([160,120,2]);
}