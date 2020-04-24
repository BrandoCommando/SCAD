$fn=40;
for(x=[0,1],y=[0,1])
  translate([x*24,y*24]) difference() {
    union() {
      cylinder(d=20,h=2.01);
      translate([0,0,2]) cylinder(d1=20,d2=14,h=8);
    }
    translate([0,0,-.01]) cylinder(d=4,h=10.02);
    translate([0,0,2]) cylinder(d1=4,d2=14,h=2.01);
    translate([0,0,4]) cylinder(d=10,h=14.01);
  }