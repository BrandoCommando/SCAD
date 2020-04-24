$fn=30;
/*
#translate([-50,-20]) square([200,20]);
#translate([-20,-50]) square([20,200]);
*/
rotate([0,0,45]) {
  difference()
  {
  translate([15,15]) rotate([0,0,15]) offset(2,$fn=20) circle(d=36,$fn=6);
  *hull(){
    translate([-20,25]) rsquare([20,30]);
    translate([25,-20]) rsquare([30,20]);
  }
  for(x=[30,45]) {
    translate([x,-10]) circle(d=5,$fn=30);
    translate([-10,x]) circle(d=5,$fn=30);
  }
  translate([15,15]) {
    circle(d=22.2,$fn=60);
    for(r=[15:60:359]) rotate([0,0,r]) translate([15,0]) circle(d=3,$fn=20);
  }
}
translate([15,15]) circle(d=18,$fn=40);
}

module rsquare(dims,r=2)
{
  for(x=[r,dims[0]-r],y=[r,dims[1]-r])
    translate([x,y]) circle(r=r);
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
}