*translate([-3.2,6]) rotate([0,0,1.4]) difference(){
  cube([2,29,30]);
  translate([-.01,5,25]) rotate([0,90,0]) {
    cylinder(d=4,h=4,$fn=20);
    translate([0,0,1.5]) cylinder(d1=4,d2=8,h=1.52,$fn=20);
  }
  translate([-.01,24,25]) rotate([0,90,0]) {
    cylinder(d=4,h=4,$fn=20);
    translate([0,0,1.5]) cylinder(d1=4,d2=8,h=1.52,$fn=20);
  }
}
difference(){
  translate([-2,-2,.01]) {
    *cube([40,49,15]);
    intersection() {
      linear_extrude(16) outline(39,49);
      minkowski() {
        translate([2,2]) linear_extrude(15) outline();
        sphere(2,$fn=50);
      }
    }
  }
  translate([-2,10,7.5]) rotate([0,90]) {
    cylinder(d=4,h=50,$fn=20);
    translate([0,0,2]) cylinder(d1=4,d2=8,h=1,$fn=20);
    translate([0,0,36]) cylinder(d1=8,d2=4,h=1,$fn=20);
  }
  translate([-2.5,30,7.5]) rotate([0,90]) {
    cylinder(d=4,h=50,$fn=20);
    translate([0,0,2]) cylinder(d1=4,d2=8,h=1,$fn=20);
    translate([0,0,37]) cylinder(d1=8,d2=4,h=1,$fn=20);
  }
  intersection(){
    linear_extrude(16.02) outline();
    minkowski(){
      translate([1,1,1]) linear_extrude(15.02) outline(33,43);
      sphere(1,$fn=50);
    }
  }
}

module outline(mw=35,mh=45)
{
  polygon([[1,-2],[0,mh-5],[mw/2,mh-2],[mw,mh-5],[mw-1,-2]]);
}