difference() {
  union() {
    translate([-5,-2]) cube([70,114,1.2]);
    translate([3,14]) cube([54,82,4]);
    for(y=[13.6,110-13.6])
      translate([30,y]) cylinder(d=6.5,h=4,$fn=30);

  }
  translate([5,16,-.01])
    cube([50,78,5]);
  for(y=[13.6,110-13.6])
    translate([30,y,-.01]) cylinder(d=3,h=5,$fn=30);
  for(x=[-1,61],y=[2,108])
    translate([x,y,-.01]) cylinder(d=4,h=5,$fn=30);
}