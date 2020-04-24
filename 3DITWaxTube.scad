difference() {
  union(){
    cylinder(d=18,h=93.99,$fn=40);
    cylinder(d=40,h=2,$fn=50);
    translate([0,0,2]) cylinder(d1=40,d2=18,h=10,$fn=50);
    translate([0,0,94]) 
      cylinder(d1=18,d2=34,h=10,$fn=50);
    translate([0,0,104])
      cylinder(d1=34,d2=40,h=6,$fn=50);
  }
  translate([0,0,-0.01]) cylinder(d=10,h=4.02,$fn=20);
  translate([0,0,2]) union(){
    *cylinder(d1=6,d2=14.4,h=2.01,$fn=30);
    translate([0,0,0]) cylinder(d=14.4,h=120,$fn=30);
    translate([0,0,94]) cylinder(d1=14.4,d2=30,h=10,$fn=50);
    translate([0,0,103.99]) cylinder(d1=30,d2=36,h=6,$fn=50);
  }
}
translate([30,0]) difference() {
  union() {
    cylinder(d=9.6,h=2,$fn=20);
    translate([0,0,2]) cylinder(d=14,h=2,$fn=40);
  }
  translate([0,0,3]) cylinder(d1=6,d2=14.4,h=1.01,$fn=30);
}