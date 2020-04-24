rotate([0,-90])
{
difference(){
  cube([28,26,4]);
  translate([7.5,7.5,-.01]) cube([13,11,4.02]);
}
translate([0,26]) difference() {
  cube([28,4,20]);
  for(x=[8,20]) translate([x,-.01,12]) rotate([-90,0]) {
    cylinder(d=4,h=4.02,$fn=30);
    cylinder(d1=8,d2=4,h=2,$fn=40);
  }
}
translate([0,20,-10]) difference() {
  cube([28,10,10]);
  translate([-.01,0,0]) rotate([0,90,0]) scale([2,1]) cylinder(d=10,h=28.02,$fn=30);
}
}