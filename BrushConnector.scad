dia=3.18;
space=4;
rows=4;
cols=8;
bigd=(space*(rows+1.5)+dia);
echo(str("BigD: ",bigd));
holes();
module holes() {
difference() {
  hull() {
    translate([space,bigd/2-space*1.5]) circle(d=bigd,$fn=60);
    translate([space*(cols-2)-dia,bigd/2-space*1.5]) circle(d=bigd,$fn=60);
  }
  for(r=[0:rows-1])
    for(c=[0:r%2==0?cols-2:cols-1])
      translate([c*space-(space/2)*(r%2), r*space])
        circle(d=dia,$fn=20);
}
}
module connector() {
  difference() { union() {
    for(xi=[0:5],yi=[0:2])
      if((xi>0&&xi<5)||yi==1)
        translate([xi*5-3,yi*6-0.75,1]) cylinder(d1=4,d2=1,h=2,$fn=30);
    linear_extrude(1)  hull() {
        translate([space,bigd/2-space*1.5]) circle(d=bigd,$fn=60);
        translate([(dia+space)*cols/2-space,bigd/2-space*1.5]) circle(d=bigd,$fn=60);
      }
      translate([-7.5,-5.5,-3]) rcube([34,21,3],10,$fn=40);
    }
    translate([9.5,5]) for(x=[-15.25,15.25],y=[-9.18,9.18]) translate([x,y,-3.01]) cylinder(d=7,h=6,$fn=40);
  }
  
}
module holder() {
  hull() {
    translate([-17,-10.5]) rcube([34,21,3],10,$fn=40);
    translate([0,0,30]) cylinder(d=10,h=1,$fn=40);
  }
  translate([0,0,30]) cylinder(d=10,h=40,$fn=40);
  translate([0,0,70]) sphere(d=10,$fn=40);
}
module rcube(dims,r=2,$fn=20)
{
  linear_extrude(dims[2],convexity=3) hull() {
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=$fn);
  }
}