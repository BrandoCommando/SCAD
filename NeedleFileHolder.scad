rotate([0,0,90]) difference(){
  intersection(){
    cube([85,20,20]);
    minkowski() {
      translate([2,2,-2]) cube([85-4,20-4,20]);
      sphere(2,$fn=30);
    }
  }
  for(x=[1:6])
    translate([x*10,10,4]) {
      translate([0,0,14]) cylinder(d1=4,d2=6,h=2,$fn=30);
      cylinder(d=4,h=20,$fn=20);
    }
  translate([73,10,4]) {
    cylinder(d1=5,d2=8.3,h=10,$fn=30);
    translate([0,0,9.99]) cylinder(d=8.3,h=6.02,$fn=40);
    translate([0,0,14.01]) cylinder(d1=8.3,d2=10.5,h=2,$fn=50);
  }
}