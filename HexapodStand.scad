!base();
rod();
translate([0,0,60]) !top();
module base() {
  difference() {
    union() {
    cylinder(d=20,h=7.2,$fn=50);
    for(r=[0:60:360])
    {
      rotate([0, 0, r])
      {
        translate([0,-2]) cube([50,4,4]);
        translate([50,0]) {
          cylinder(d=10,h=4,$fn=40);
          cylinder(d=6,h=7.5,$fn=25);
        }
      }
    }
  }
    translate([0,0,-.01]) cylinder(d=8,h=5.02,$fn=30);
    translate([0,0,2]) cylinder(d=14.5,h=5.23,$fn=6);
  }
      
}
module rod() {
  difference() {
    union() {
      cylinder(d=10,h=60,$fn=30);
      translate([0,0,60]) cylinder(d=7.6,h=3,$fn=30);
      translate([0,0,63]) cylinder(d=5,h=3,$fn=20);
      translate([0,0,50]) cylinder(d1=10,d2=20,h=10,$fn=30);
      translate([0,0,2]) cylinder(d1=30,d2=7.6,h=10,$fn=30);
      cylinder(d=30,h=2,$fn=30);
    }
  }
}
module top() {
  h1=3;
  h2=10;
  h3=3;
difference() {
  union() {
    cylinder(d=60,h=h1,$fn=100);
    for(r=[0:360/6:360])
      rotate([0,0,r]) translate([24,0,h1]) {
        translate([0,0,h2]) cylinder(d=5,h=h3,$fn=20);
        cylinder(d=10,h=h2,$fn=40);
      }
  }
  translate([0,0,-.01]) cylinder(d=8,h=h1+.02,$fn=30);
}
}