$fn=50;
ow=23.4;
oh=31.2;
linear_extrude(2) offset(14) square([ow,oh]);
linear_extrude(27)
difference(){
  offset(2.6) square([ow,oh]);
  translate([.5,.5]) offset(1) square([ow-1,oh-1]);
}