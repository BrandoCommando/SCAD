id=35;
t=.375*4;
od=id+t*2;
h=20;
echo(str("OD: ",od));
difference() { union() {
difference(){
  cylinder(d=od,h=2,$fn=100);
  translate([0,0,-.01]) cylinder(d1=28,d2=32,h=2.02,$fn=50);
}
linear_extrude(h,convexity=3) difference() {
  circle(d=od,$fn=100);
  circle(d=id,$fn=100);
}
}
  translate([0,-5,-.01]) cube([30,10,h+.02]);
}