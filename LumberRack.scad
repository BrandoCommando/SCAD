dx=feet(8);
dz=feet(4.25);
for(x=[0:dx/2:dx])
{
  for(y=[0:2])
    translate([x,inches(y*18),inches(1.5)])
      cube([inches(3.5),inches(1.5),dz]);
  for(z=[0,dz+inches(1.5)])
    translate([x,0,z]) color("blue")
      cube([inches(3.5),feet(3)+inches(1.5),inches(1.5)]);
}
for(y=[-1*inches(.75),feet(3)+inches(1.5)],z=[0,dz])
  translate([0,y,z]) color("brown") cube([feet(8),inches(.75),inches(6)]);
translate([0,inches(3),dz+inches(6)]) rotate([0,90,0]) linear_extrude(feet(10)) difference() { circle(d=inches(6),$fn=100); circle(d=inches(5), $fn=100); }

translate([0,inches(3.125),inches(1.5)]) rotate([2,0]) color("green") cube([feet(8),inches(.75),feet(4)]);

function inches(mm) = mm * 25.4;
function feet(in) = 12 * inches(in);