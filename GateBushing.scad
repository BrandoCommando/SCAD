difference(){
  union(){
    cylinder(d=40,h=2,$fn=100);
    translate([0,0,2]) cylinder(d1=40,d2=25,h=10,$fn=100);
  }
  translate([0,0,5]) cylinder(d1=8,d2=12,h=10,$fn=30);
  translate([0,0,-.01]) cylinder(d=5,h=30,$fn=20);
}