$fn=50;
tw=inches(10);
off=20;
num=7;
dist=(tw-off*2)/(num-1);
echo(str("dist: ",dist));
rotate([0,0,-90]) {
difference() {
  square([tw,inches(1.5)]);
  //linear_extrude(inches(3.25)-3.5)
  for(x=[0:num-1])
    translate([off+x*dist,inches(3/4)]) circle(d=x%2==1?29:24);
}
/*linear_extrude(inches(3)-3.5) for(x=[off:dist:tw-off+1]) translate([x,inches(3/4)]) circle(d=25);
linear_extrude(inches(3.5)-3.5) for(x=[off:dist:tw-off+1])
  translate([x,inches(3/4)]) difference() { circle(d=36); circle(d=29); }
  translate([0,0,inches(3.5)-3.5]) for(x=[off:dist:tw-off+1]) {
    translate([x,inches(3/4)]) rotate_extrude() { translate([(29+3.5)/2,0]) circle(d=3.5,$fn=30); }
    translate([x,inches(3/4),-inches(0.25)]) rotate_extrude() {
      translate([(24+3.5)/2,0]) circle(d=3.5,$fn=30);
    }
  }
*/
}
function inches(in) = 25.4 * in;