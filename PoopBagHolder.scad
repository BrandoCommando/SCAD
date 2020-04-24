difference(){
  cylinder(d=40,h=70,$fn=90);
  translate([0,0,2]) cylinder(d=37,h=70.02,$fn=80);
  translate([15,0,3]) rotate([0,0,60]) cube([10,2,65]);
}
cylinder(d=5,h=70,$fn=30);
translate([50,0]) difference() { union(){
  difference() {
    cylinder(d=43,h=6,$fn=90);
    translate([0,0,2]) cylinder(d=40.4,h=4.01,$fn=80);
  }
  cylinder(d=8,h=6,$fn=30);
  //translate([0,0,-.01]) cylinder(d=7,h=3,$fn=6);
}
  translate([0,0,-.01]) cylinder(d=5.4,h=10,$fn=20);
}