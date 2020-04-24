difference() {
  cube([124,90,14]);
  translate([12,-.01,-.01])
    cube([100,65,14.02]);
  for(x=[6,118])
  translate([x,5]) rotate([-45,0]) {
    cylinder(d=4,h=30,$fn=20);
    translate([0,0,10]) cylinder(d=10,h=20,$fn=30);
  }
  for(x=[12.5:20:120]) translate([x,84,-.01]) cylinder(d=3,h=14.02,$fn=20);
  for(y=[5,70],x=[6,62,118]) translate([x,y,-.01]) cylinder(d=3,h=14.02,$fn=20);
}