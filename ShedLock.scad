difference(){
  union(){
    linear_extrude(3.5) {
      circle(d=35,$fn=80);
      translate([0,-17.5,0]) square([40,35]);
    }
    translate([34,-17.5]) cube([6,35,8]);
  }
  translate([0,0,-.01]) cylinder(d=8,h=4.02,$fn=40);
  for(y=[-14,14,0])
    translate([37,y,-.01]) cylinder(d=3,h=10.02,$fn=30);
}