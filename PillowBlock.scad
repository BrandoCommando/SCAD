rotate([90,0]) difference(){
  cube([50,8,23]);
  for(x=[13,37],z=[3.5,20.5])
  translate([x,-.01,z]) rotate([-90,0]) cylinder(d=3,h=20,$fn=20);
  translate([25,12.5,13]) rotate([90,0]) difference(){
    union(){
      cylinder(d=24,h=9,$fn=50);
     *translate([-12,0]) cube([24,12,9]);
    }
    translate([0,0,-.01]) cylinder(d1=12,d2=8,h=1,$fn=20);
    translate([0,0,8]) cylinder(d1=10,d2=12,h=1,$fn=20);
  }
  translate([25,-.01,13]) rotate([-90,0]) 
    cylinder(d=8,h=20,$fn=30);
  for(m=[0,1]) translate([25,0]) mirror([m,0]) translate([-25,0]) {
    translate([6,-.01,8]) rotate([-90,0]) scale([1,1]) cylinder(d=8,h=20,$fn=30);
    translate([-.01,-.01,4]) cube([6,20,30]);
    for(y=[4,12])
      translate([4,y,-.01]) cylinder(d=3,h=10,$fn=20);
  translate([-.01,-.01,8]) cube([10,20,30]);
  }
}
*%translate([25,12,12]) rotate([90,0]) difference() {
  cylinder(d=22,h=7,$fn=50);
  translate([0,0,-.01]) cylinder(d=8,h=7.02,$fn=30);
}