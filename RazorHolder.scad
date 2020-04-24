*translate([-40,-10]) difference(){
  union(){
    cylinder(d=44,h=4,$fn=80);
    translate([-22,0]) cube([44,22,4]);
  }
  translate([0,0,-.01]) cylinder(d=40,h=4.02,$fn=80);
  difference(){
    translate([-16,-22.01,-.01]) cube([32,10,4.02]);
    translate([-17,-13.5,-.02]) cylinder(d=4,h=4.04,$fn=20);
    translate([17,-13.5,-.02]) cylinder(d=4,h=4.04,$fn=20);
  }
}
difference(){
  union(){
    cylinder(d=14,h=4,$fn=30);
    translate([-7,0]) cube([14,12,4]);
  }
  translate([0,0,-.01]) {
    cylinder(d=12,h=4.02,$fn=30);
    difference(){
      translate([-4,-8]) cube([8,8,4.02]);
      translate([-5,-4.6,-.01]) cylinder(d=3,h=4.04,$fn=20);
      translate([5,-4.6,-.01]) cylinder(d=3,h=4.04,$fn=20);
    }
  }
}
translate([-62,10]) {
  difference(){
    bw=14;
    *cube([bw,4,20]);
    translate([55,4]) rotate([90,0]) linear_extrude(4) union(){
      square([bw,12]);
      translate([4,12]) circle(d=8,$fn=30);
      translate([bw-4,12]) circle(d=8,$fn=30);
      translate([4,12]) square([bw-8,4]);
    }
    translate([0,4.01]) rotate([90,0]) union(){
      for(x=[6,62])
      translate([x,10]) {
        cylinder(d=4,h=4.02,$fn=20);
        translate([0,0,2]) cylinder(d1=4,d2=8,h=2.02,$fn=30);
      }
    }
  }
}