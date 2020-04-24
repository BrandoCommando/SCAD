/**/
base();
//flicker(82);
/*/
translate([0,-20,0]) rotate([90,0]) flicker();
%translate([0,0,-1.5-5.5]) cylinder(d=10,h=6,$fn=60);
/**/
module flicker(angle=0) {
  translate([0,0,10]) rotate([90,0]) rotate([0,0,180+angle]) translate([0,0,-3]) difference() {
  union() {
    scale([2,1,1]) cylinder(d=12,h=6,$fn=50);
    translate([0,-6]) cube([11.5,6,6]);
    translate([-12,0]) cube([11,6,6]);
    rotate([0,0,270-45]) translate([0,-3]) linear_extrude(6) offset(1,$fn=20) polygon([[0,0],[20,2],[20,4],[0,6]]);
  }
  translate([0,0,-.01]) cylinder(d=3,h=6.02,$fn=20);
  translate([-5,6,-.01]) cube([10,5,6.02]);
  translate([11.5,-5,-.01]) cube([20,10,6.02]);
  
}
}
module base() {
difference() {
  translate([-11.25,-17.75,-3]) rcube([22.5,35.5,2],2);
  translate([-7.5,-3.2,-3.01]) cube([4,6.4,2.02]);
  for(m=[0,1]) rotate([0,0,180*m])
  translate([-11.25+4,17.75-4,-3.01]) cylinder(d=3,h=10,$fn=20);
  translate([0,0,-3.01]) cylinder(d=11,h=10,$fn=40);
}
difference() {
  for(r=[0,180]) rotate([0,0,r])
    translate([-6,3.2,-1]) {
      rcube([12,5,12],2);
      translate([0,0,10]) cube2([12,5,6],2);
    }
  translate([0,0,-1.01]) cylinder(d=11,h=5,$fn=40);
  translate([0,-10,10]) rotate([-90,0]) cylinder(d=3.2,h=20,$fn=20);
}
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
  *union() {
    translate([0,0,r]) rcube([dims[0],dims[1],dims[2]-r*2],r,$fn);
    mirrorz(dims[2]) translate([0,0,r])
    {
      for(x=[r,dims[0]-r],y=[r,dims[1]-r])
        translate([x,y]) sphere(r=r,$fn=$fn);
      *mirrory(dims[1]) translate([r,r]) rotate([0,90]) cylinder(h=dims[1]-r*2,r=r,$fn=$fn);
    }
  }
}
