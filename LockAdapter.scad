difference(){
  linear_extrude(17.5) {
    rrect(56,16,4);
  }
translate([0,0,1]) linear_extrude(2.01) {
circle(d=13,$fn=40);
translate([17,0]) circle(d=6,$fn=20);
translate([-17,0]) circle(d=6,$fn=20);
polygon([[-17,-3],[0,-5.5],[17,-3],[17,3],[0,5.5],[-17,3]]);
}
  translate([0,0,-.01]) cylinder(d=10,h=3,$fn=40);
  translate([0,0,3]) linear_extrude(20) rrect(53,13,3);
}

module rrect(w,h,r)
{
  for(x=[w/-2+r,w/2-r],y=[h/-2+r,h/2-r])
    translate([x,y]) circle(r=r,$fn=20);
  polygon([[w/-2,h/2-r],[w/-2,h/-2+r],[w/-2+r,h/-2],[w/2-r,h/-2],[w/2,h/-2+r],[w/2,h/2-r],[w/2-r,h/2],[w/-2+r,h/2]]);
}