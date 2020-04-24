difference(){
  cube([77,55,14]);
  translate([1.8,1.8,1]) cube([73.4,51.4,14]);
}
translate([5.2,5.2]) difference(){
  union(){
  translate([-5.2,-5.2]) cube([5.2,5.2,12.85]);
  cylinder(d=8,h=12.85,$fn=20);
  }
  translate([0,0,4]) cylinder(d=2,h=12,$fn=12);
}
translate([71.8,5.2]) difference(){
  union(){
  translate([0,-5.2]) cube([5.2,5.2,12.85]);
  cylinder(d=8,h=12.85,$fn=20);
  }
  translate([0,0,4]) cylinder(d=2,h=12,$fn=12);
}
translate([5.2,49.8]) difference(){
  union(){
  translate([-5.2,0]) cube([5.2,5.2,12.85]);
  cylinder(d=8,h=12.85,$fn=20);
  }
  translate([0,0,4]) cylinder(d=2,h=12,$fn=12);
}
translate([71.8,49.8]) difference(){
  union(){
  translate([0,0]) cube([5.2,5.2,12.85]);
  cylinder(d=8,h=12.85,$fn=20);
  }
  translate([0,0,4]) cylinder(d=2,h=12,$fn=12);
}