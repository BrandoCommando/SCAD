%translate([-42,0]) {
  cube(42);
  translate([42,21,21]) rotate([0,90,0]) {
    stepper_cutout(1);
  }
}
translate([5,0]) {
  rotate([0,-90,0]) !difference() {
    cube([15,42,42]);
    translate([-.01,-.01,16]) rotate([50,0]) cube(40);
    translate([3,3,3]) cube([43,37,43]);
    translate([-.01,21,21]) rotate([0,90]) {
      stepper_cutout();
    }
    *translate([21,21,-.01]) stepper_cutout();
    *translate([21,-.01,21]) rotate([-90,0]) stepper_cutout();
    for(y=[8,34])
      translate([9,y,-.01]) cylinder(d=4,h=5,$fn=20);
    translate([15,-.01,-.01]) rotate([0,-17,0]) cube(50);
  }
}

module stepper_cutout(inverse=0)
{
  if(inverse)
    cylinder(d=5,h=20,$fn=30);
  else
    cylinder(d=20,h=4,$fn=30);
  for(x=[-15.5,15.5],y=[-15.5,15.5])
    translate([x,y]) cylinder(d=3,h=5,$fn=20);
}
