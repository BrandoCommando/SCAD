difference(){
  cylinder(d1=13,d2=11,h=6,$fn=50);
  translate([0,0,-.01]) cylinder(d1=10,d2=9,h=6.02,$fn=50);
}
for(z=[0:5]) translate([0,0,z]) rotate([0,0,-15]) rotate_extrude(angle=30,$fn=50) translate([4.5,0]) square([1,0.3]);
difference(){
  translate([0,0,3]) cylinder(d=6,h=3,$fn=40);
  translate([0,0,-.01]) cylinder(d=4,h=6.02,$fn=30);
}
translate([0,0,6]) difference() {
  cylinder(d=11,h=1,$fn=50);
  translate([0,0,-.01]) cylinder(d=4,h=1.02,$fn=30);
}
translate([0,0,7]) difference() {
  cylinder(d1=11,d2=6,h=4,$fn=40);
  translate([0,0,-.01]) cylinder(d=4,h=4.02,$fn=30);
}
translate([0,0,11]) difference() {
  cylinder(d=6,h=4.5,$fn=40);
  translate([0,0,-.01]) cylinder(d=4,h=4.52,$fn=30);
}