//translate([-30,80]) rotate([0,0,90]) import("driversNew.stl");
levels=6;
cols=11;
hs=7.4; //25.4/4=6.35
right=cols*9+4;
sides=levels>1?1:0;
height=4+levels*6;
deep=(levels-1)*12-2;
for(y=[0:levels-1])
    translate([0,y*12]) difference() {
      cube2([right,14,12+y*6]);
      for(x=[0:cols-(y%2==1?2:1)])
        translate([(y%2==1?10:6)+9*x,6,1+y*4]) cylinder(d=hs,h=12+y*2,$fn=30);
    }
if(sides) {
mirrorx(right/2) translate([0,0]) {
  translate([-20,deep]) difference(){
  translate([10,3]) cube([11,13,height]);
  translate([10,2,-.01]) cylinder(r=10,h=height+.02,$fn=40);
}
translate([-23,deep+12]) difference() {
  translate([-2,0]) cube([15,4,height]);
  for(z=levels>5?[height-6,14]:[height/2+4]) translate([7,4.02,z]) rotate([90,0]) {
    cylinder(d=4,h=10,$fn=20);
    *translate([0,0,2]) cylinder(d1=4,d2=8,h=2.03,$fn=20);
    if(z>14) {
    translate([0,-6]) cylinder(d=8.2,h=10,$fn=30);
    translate([0,-2]) rotate([0,0,45]) {
      cylinder(d=5.6,h=4.03,$fn=4);
      *translate([0,0,2]) cylinder(d1=5.6,d2=10.2,h=2.03,$fn=4);
    }
  }
  }
}
}
}

module mirrorz(offset=0)
{
  translate([0,0,offset]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,offset*-1]) children();
}
module mirrory(offset=0)
{
  translate([0,offset,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-1,0]) children();
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}
module cube2(dims,r=1)
{
  intersection()
  {
    cube(dims);
    minkowski(){
      translate([r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
      sphere(d=2,$fn=30);
    }
  }
}