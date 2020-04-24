cube([10,10,.2]);

difference(){
  cube([10,10,20]);
  intersection(){
    translate([-.01,3,0]) cube([10.02,2,23]);
    translate([0,5,10.99]) {
      for(x=[0:2:17])
        translate([x,0]) rotate([0,0,45]) cube([2,2,23],center=true);
    }
  }
  intersection(){
    translate([-.01,4.99,0]) cube([10.02,2,23]);
    translate([0,5,10.99]) {
      for(x=[0:2:17])
        translate([x+1,0]) rotate([0,0,45]) cube([2,2,23],center=true);
    }
  }
  translate([5,-.05,16]) rotate([-90,0]) {
    rotate([0,0,30]) cylinder(d=6.5,h=2,$fn=6);
    cylinder(d=3.5,h=12,$fn=20);
  }
  translate([5,-.05,5]) rotate([-90,0]) {
    rotate([0,0,30]) cylinder(d=6.5,h=2,$fn=6);
    cylinder(d=3.5,h=12,$fn=20);
  }
}