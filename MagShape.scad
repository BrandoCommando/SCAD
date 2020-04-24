h=6;
sides=4;
balld=5;
based=25.4*3;
roundr=25.4/4;
//echo(str("Each: ", ea));
ea=360/sides;
od=(based*cos(30))/sin(ea/2);
echo(str("od: ", od));
yo=11;
//long_hyp_triangle();
equilateral();
module long_hyp_triangle() {
  to=(based*cos(30))/sin((360/4)/2)/2.83;
  difference() {
    intersection(){
      linear_extrude(h) polygon([[-1*to,-1*to],[to,-1*to],[to,to]]);
      linear_extrude(h) minkowski(){
        polygon([[-1*to+roundr*2.5,-1*to+roundr],[to-roundr,-1*to+roundr],[to-roundr,to-roundr*2.5]]);
        circle(r=roundr,$fn=40);
      }
    }
    ballholes(4);
    rotate([0,0,180-45]) {
      for(y=[yo,yo*-1])
        translate([-.5*balld,y,h/2]) {
          sphere(d=balld,$fn=20);
          rotate([0,90,0]) cylinder(d=3,h=5,$fn=20);
        }
    }
}
}
module equilateral(sides=sides,roundr=roundr) {
//for(z=[0:h+1:50]) translate([0,0,z])
difference(){
  rotate([0,0,ea/2]) intersection() {
    cylinder(d=od,h=h,$fn=sides);
    linear_extrude(h) minkowski() {
    circle(d=od-(roundr*(5-(sides*.6))),$fn=sides);
    if(roundr>0)
      circle(r=roundr,$fn=40);
  }
}
  
  ballholes(sides);
}
}

module ballholes(sides=sides,yo=yo,od=od,balld=balld) {
  xo=(od*.5)*sin(90-(ea/2))-(balld/2);
  for(r=[0:360/sides:360-1]) rotate([0,0,r])
  for(y=[yo,yo*-1])
  {
    translate([xo,y,h/2]) {
      sphere(d=balld,$fn=20);
      rotate([0,90,0]) cylinder(d=2.4,h=5,$fn=20);
    }
  }
}