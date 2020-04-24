*mirror([0,0,1]) {
translate([0,0,50]) difference(){
  cylinder(d=170,h=10,$fn=300);
  translate([0,0,-.01]) cylinder(d1=140,d2=150,h=10.02,$fn=300);
}
for(r=[0:60:360]) rotate([0,0,r]) translate([78,-4,52]) intersection(){
  mirror([0,0,1]) rotate([0,10]) cylinder(d=12,h=55,$fn=50);
  translate([-10,-10,-50]) cube([30,20,50]);
}
}
intersection(){
  translate([-10,-10,2]) cube([30,30,45]);
  rotate([0,10]) difference(){
  cylinder(d=20,h=50);
  translate([7,0]) rotate([0,-10]) translate([0,0,40]) intersection() {
    rotate([0,10]) cylinder(d=12.6,h=20,$fn=50);
    translate([-8,-8,1]) cube([24,24,20]);
  }
}
}