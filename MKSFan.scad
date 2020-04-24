difference(){
  cube([90,16,2]);
  translate([5,5,-.01]) cylinder(d=3.5,h=3,$fn=20);
  translate([85,5,-.01]) cylinder(d=3.5,h=3,$fn=20);
}
translate([0,10]) {
  difference(){
    cube([40,6,40]);
    translate([20,-.01,20]) rotate([-90,0]) {
      cylinder(d=36,h=11,$fn=40);
      translate([-16,-16]) cylinder(d=3.5,h=11,$fn=20);
      translate([16,-16]) cylinder(d=3.5,h=11,$fn=20);
      translate([-16,16]) cylinder(d=3.5,h=11,$fn=20);
      translate([16,16]) cylinder(d=3.5,h=11,$fn=20);
    }
  }
}