width=5;
translate([0,width*-.5])
  cube([30,width,4]);
translate([2.5,0]) cylinder(d=3,h=6,$fn=20);
translate([2,width*-.5,4]) intersection() {
  rotate([0,50,0]) cube([20,width,30]);
  translate([7,0]) cube([14,width,15]);
}
  translate([20.5,0,17]) cylinder(d=width,h=3,$fn=20);
translate([21,0,19]) rotate([0,-30,0]) {
  cylinder(d=width,h=2,$fn=20);
  translate([0,0,2]) sphere(d=width,$fn=20);
}
translate([11,-6.5,9]) rotate([-90,0]) rotate([0,0,210]) difference(){
  cylinder(d=4.2,h=13,$fn=20);
  translate([0,-5]) rotate([0,45,0]) cube(10);
  translate([0,-5,13]) rotate([0,45,0]) cube(10);
}
translate([20,0])
{
  intersection(){
    rotate([0,0,-45]) cube([20,20,4]);
    translate([0,-12]) cube([11,24,4]);
  }
}
translate([34,-12]) rotate([0,-90,0])
{
  difference(){
    cube([10,24,4]);
    translate([7,-0.01,0]) rotate([0,45]) cube([10,40,10]);
    translate([0,-.01,3]) rotate([0,135]) cube([10,40,10]);
  }
}
translate([-10,0])
difference(){
  cylinder(d=5,h=25,$fn=8);
  translate([0,0,-.01]) cylinder(d=3.5,h=26.02,$fn=8);
}