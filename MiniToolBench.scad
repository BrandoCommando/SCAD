ttlw=inches(24);
rot=0;

for(x=[0,ttlw-inches(1.75)])
{
  translate([x,0]) twobytwo(3.5);
  translate([x,-1*inches(18)]) twobytwo(1.75);
}
color("green") translate([0,0,inches(12)*3.5+inches(1.75)]) rotate([0,90]) twobytwo(2);
translate([0,inches(3/4),inches(20)]) rotate([rot,0]) translate([0,-inches(3/4),-inches(20)]) union() {
color("green") translate([0,-1*inches(18),inches(1.75)+inches(12)*1.75]) rotate([0,90]) twobytwo(2);
color("blue") for(x=[-inches(1.5),inches(24)],z=[inches(19.25)]) translate([x,-inches(18),z]) cube([inches(1.5),inches(19.5),inches(3.5)]);
translate([-inches(1.5),-inches(18),inches(22.75)]) color("brown") cube([inches(27),inches(18),inches(3/4)]);
}
*for(y=[0:inches(13)/3:inches(13)]) translate([-inches(1.5),-inches(16.5)+y,inches(9.5)]) cube([inches(27),inches(3.5),inches(1.5)]);

module twobytwo(foot_len)
{
  cube([inches(1.75),inches(1.5),inches(foot_len*12)]); 
}
module twobyfour(foot_len)
{
  cube([inches(3.5),inches(1.5),inches(foot_len*12)]); 
}

module mirrorx(off=0) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off=0) {
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}
function inches(in) = in * 25.4;