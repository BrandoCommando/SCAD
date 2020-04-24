difference() {
  cube([102,30,16]);
  for(x=[0:5])
    translate([2+20*x,2,2]) cube([18,26,20]);
}
translate([21,30]) {
  cube([60,3,0.3]);
  translate([0,2.1]) rotate([0,0]) difference() {
    linear_extrude(2,convexity=3) {
      difference() { union() {
      square([60,25]);
      *translate([5,20]) square([50,5]);
      translate([5,25]) circle(d=12.5,$fn=30);
      translate([55,25]) circle(d=12.5,$fn=30);
      }
      for(x=[5,55])
        translate([x,25]) circle(d=8.5,$fn=24);
    }
  }
  }
}