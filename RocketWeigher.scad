difference() {
  union(){
    *translate([-10,0]) cube([20,31.5,16.5]);
    translate([0,12.5,16.5]) cylinder(d=31.2,h=26,$fn=100);
    translate([0,12.5,0]) cylinder(d1=24,d2=31.2,h=16.5,$fn=100);
  }
  translate([0,12.5,20]) cylinder(d=28,h=40,$fn=100);
  *translate([-6.5,-20.01,-.01]) cube([13,48.02,13]);
  for(y=[5,20])
    translate([0,y,-1]) {
      cylinder(d=4,h=22,$fn=24);
      translate([0,0,16.5]) cylinder(d=12,h=20,$fn=40);
    }
}