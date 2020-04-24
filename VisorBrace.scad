id1=18;
id2=20;
thick=10;
tw=id2+thick;
th=20;
difference(){
  union() {
    translate([0,0]) cube([tw,th,30]);
    translate([tw/2,th]) cylinder(d=id2+thick,h=30,$fn=100);
    for(x=[thick/2,tw-thick/2])
      translate([x,0]) cylinder(d=thick,h=30,$fn=20);
  }
  translate([tw/2,th,-.01]) linear_extrude(30.02) {
    hull() {
    circle(d=id1,$fn=40);
    translate([0,-60]) circle(d=id2,$fn=50);
    }
  }
  for(z=[8,22]) translate([-.01,5,z]) rotate([0,90,0]) cylinder(d=3,h=30.02,$fn=20);
}