difference() {
  cube2([20,30,40],2.5);
  translate([-.01,5,5]) cube([31,20,20]);
  translate([10,-.01,33]) rotate([-90,0]) cylinder(d=25.4*(5/16),h=40,$fn=40);
  translate([-.01,5,26]) cube([31,20,20]);
  translate([-.01,5.5,24.99]) cube([31,19,20]);
}


module rsquare(dims,r=5,center=false,$fn=30)
{
  translate(center?[dims[0]/-2,dims[1]/-2]:[0,0])
  hull() for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=$fn);
}
module rcube(dims,r=5,$fn=30)
{
  linear_extrude(dims[2],convexity=3) {
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=$fn);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
  }
}
module cube2(dims,r=5,$fn=30)
{
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r,$fn=$fn);
  }
}

function inches(in) = 25.4 * in;