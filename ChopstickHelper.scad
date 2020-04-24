difference(){
  cylinder(d=29.5,h=10,$fn=60);
  translate([0,0,-.01]) cylinder(d=27.1,h=12.02,$fn=60);
  translate([-16,-16,-.01]) cube([32,15,12.02]);
}
for(m=[0,1]) mirror([m,0])
translate([-19.5,-1,6]) {
  difference(){
    union(){
      translate([4.5,-4,0]) translate([1.47,4,4]) rotate([10,0]) mirror([1,0]) mirror([0,1]) mirror([0,0,1]) cube([1.2,16,4]);
      rotate([90,0]) cylinder(d=12,h=16,$fn=50);
      translate([-6,-16,-6]) cube([12,16,6]);
    }
    translate([0,.01]) rotate([90,0]) cylinder(d=9.5,h=16.02,$fn=40);
    translate([-3,-16.01,3])
      cube([6,16.02,3]);
    translate([-5,-16.01,5]) cube([10,16.02,3]);
  }
  for(f=[0,1]) mirror([f,0])
  translate([-3.2,-16,4.32]) intersection(){
    rotate([-90,0]) cylinder(d=1.4,h=16.03,$fn=20);
    translate([0,0,-2]) cube([2,16,4]);
  }

}