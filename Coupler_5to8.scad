difference(){
  union(){
    cylinder(d=25,h=14,$fn=60);
    translate([0,0,12]) 
      for(r=[0:45:360]) rotate([0,0,r]) translate([10,0]) {
        sphere(d=12,$fn=24);
        *translate([0,0,-5]) cylinder(d1=2,d2=7,h=3,$fn=24);
      }
    
    translate([0,0,24]) cylinder(d1=10,d2=8,h=2,$fn=50);
    translate([0,0,14]) cylinder(d=21,h=10,$fn=50);
  }
  translate([0,0,-.01]) {
    for(r=[0:120:359]) rotate([0,0,r]) {
      translate([-2.9,6]) cube([5.8,2.8,7.4]);
      translate([0,0,4]) rotate([-90,0]) cylinder(d=3,h=20,$fn=20);
    }
    for(r=[0:90:90]) rotate([0,0,r+60]) translate([0,0,16.62]) {
      translate([-2.9,5]) cube([5.8,2.8,7.4]);
      translate([0,0,4]) rotate([-90,0]) cylinder(d=3,h=20,$fn=20);
    }
    rotate([0,0,60]) difference() {
      cylinder(d=5.4,h=30,$fn=30);
      for(r=[0,90]) rotate([0,0,r]) translate([-2,2.25,-.01]) cube([6,2,30.02]);
    }
    cylinder(d=8.2,h=10,$fn=40);
    translate([0,0,9.99]) cylinder(d1=8.2,d2=5.4,h=6,$fn=30);
  }
}