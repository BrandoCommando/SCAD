id=11.8;
od=20;
main_thick=4;
wedge_thick=2;
linear_extrude(main_thick) difference() {
  circle(d=od,$fn=60);
  circle(d=id,$fn=40);
}
difference() {
  translate([0,0,main_thick]) cylinder(d1=id+3.2,d2=id+.8,h=wedge_thick,$fn=50);
  translate([0,0,main_thick-.01]) cylinder(d=id,h=wedge_thick+.02,$fn=40);
}