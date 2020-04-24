intersection(){
  cube([24.7,14.9,7.1]);
  union(){
    translate([0,0])
      linear_extrude(7.1,convexity=10) intersection(){
        square([24.7,4.9]);
        translate([0,4.9]) mirror([0,1])
        polygon([[0,0],[0,2.6],[3,2.6],[3.2,4.9],[6,4.9],[6.2,2.6],
  [9.9,2.6],[10,4.9],[13.4,4.9],[13.6,2.6],[17.4,2.6],[17.6,4.9],[21.8,4.9],[22,2.6],[24.7,2.6],[24.7,0]]);
      }
    translate([0,4.9])
    difference(){
      translate([0,0,1.55]) cube([24.7,10,4]);
      translate([12.85,5.4,-.01]) cylinder(d=4.4,h=7.12,$fn=30);
    }
  }
}