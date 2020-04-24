difference() {
  rotate_extrude($fn=60) {
    square([7,4]);
    translate([7,2]) scale([0.5,1]) circle(r=2,$fn=40);
  }
  translate([0,0,-.01]) cylinder(d=8,h=inches(1/6)+.02,$fn=40);
}
function inches(in) = 25.4 * in;