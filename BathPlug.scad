difference() {
 translate([0,0,-2]) union() {
    cylinder(d=inches(1.25)-2,h=inches(0.5)+6,$fn=100);
  }
difference() {
  union() {
    cylinder(d1=inches(1.5), d2=inches(1.75), h=inches(0.5), $fn=100);
    translate([0,0,inches(0.5)-.01]) cylinder(d=inches(1.75), h=10, $fn=100);
  }
  translate([0,0,-.01]) cylinder(d1=inches(1.2),d2=inches(1),h=inches(0.4),$fn=100);
  *#translate([0,0,inches(0.5)+3]) rotate([0,90]) rotate_extrude($fn=50) translate([5,0]) circle(d=4,$fn=30);
}
}
function inches(in) = 25.4 * in;