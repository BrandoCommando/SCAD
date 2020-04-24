//difference(){
//translate([-80,-64.6]) import("RampsBase2.stl");
  translate([9,-.01,7]) {
    cube([4,3.03,4]);
    translate([0,0,4]) rotate([0,45,0]) cube([4,3.03,4]);
  }
//}
*translate([0,0,3]) {
translate([56.5,20]) {
  difference(){
    cylinder(d=6,h=3,$fn=30);
    cylinder(d=3,h=3.01,$fn=20);
  }
  translate([0,82.5,0]) difference(){
    cylinder(d=6,h=3,$fn=30);
    cylinder(d=3,h=3.01,$fn=20);
  }
  translate([-49,1])
  {
    difference(){
      cylinder(d=6,h=3,$fn=30);
      cylinder(d=3,h=3.01,$fn=20);
    }
    translate([0,75])
      difference(){
        cylinder(d=6,h=3,$fn=30);
        cylinder(d=3,h=3.01,$fn=20);
      }
  }
}
}