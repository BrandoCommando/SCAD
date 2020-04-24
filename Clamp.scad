boltd=inches(1/4);
nutd=0;//boltd/sin(30);
nuth=5;
bigh=30;
bigd=24;
drop=30;
dropt=25;
wipew=14;
wipeh=65;
wipet=3;
echo(str("Diameters: Bolt:",boltd," Nut:",nutd));
difference() {
  union() {
    cylinder(d=bigd,h=bigh,$fn=50);
    translate([-wipew/2,0]) rcube([wipew,wipeh,wipet]);
    translate([-2,9]) rotate([0,90,0]) linear_extrude(4) polygon([[0,0],[-bigh,0],[-wipet,wipeh-11]]);
    translate([bigd/-2,-drop]) cube([bigd,drop,dropt]);
  }
  translate([0,0,-.01]) cylinder(d=boltd,h=bigh+.02,$fn=30);
  translate([0,0,bigh-nuth]) cylinder(d=nutd,h=nuth+.02,$fn=6);
}

module mirrorx(off=0) {
  translate([off/-2,0]) for(m=[0,1]) mirror([m,0]) translate([off/2,0]) children();
}
module mirrory(off=0)
{
  translate([0,off/-2]) for(m=[0,1]) mirror([0,m]) translate([0,off/2]) children();
}
module mirrorz(off=0)
{
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/-2]) children();
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