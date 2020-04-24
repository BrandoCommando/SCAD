difference() {
  translate([0,0,6]) mirror([0,0,1]) {
  intersection(){
    cube([76,30,3]);
    minkowski(){
      translate([20,20]) cube([36,30,3]);
      cylinder(r=20,h=3,$fn=50);
    }
  }
  translate([-4.5,0,3]) 
    cube([85,30,3]);
}
  translate([20,15,-.01]) cylinder(d=4,h=10,$fn=30);
  translate([56,15,-.01]) cylinder(d=4,h=10,$fn=30);
}