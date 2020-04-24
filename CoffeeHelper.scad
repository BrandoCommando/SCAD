d=58;
h=14;

difference(){
  union(){
    translate([0,0,3]) cylinder(d1=d,d2=6,h=h-2,$fn=6);
    cylinder(d=d+1,h=4,$fn=60);
    translate([0,0,h]) {
    //minkowski() {
      sphere(1, $fn=20); cylinder(d=6, h=2, center=true, $fn=50);
    //}
      intersection(){
        translate([0,0,-2]) sphere(5,$fn=50);
        cylinder(d=8, h=2, $fn=50);
      }
  }
  }
  translate([0,0,-5]) cylinder(d=4,h=h+10,$fn=20);
  for(deg=[0:60:359])
  {
    rotate([0,0,30+deg]) translate([d*.35,0,-0.01]) {
      cylinder(d=10,h=40,$fn=30);
      translate([0,-5,0]) cube([10,10,40]);
      translate([0,0,5]) rotate([0,-45]) cylinder(d=10,h=18,$fn=60);
    }
  }
}