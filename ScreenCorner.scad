framing=25.4*(3/8);
fthick=25.4*(1/4);
tabdepth=30;
coffset=4;

intersection(){
  corner();
  translate([-5,coffset*-.5]) cube([50,framing+coffset,fthick+2]);
}
translate([0,10]) intersection(){
  corner();
  translate([0,framing]) cube([framing,50,fthick]);
}

module corner() {
  difference(){union(){
    translate([coffset*-.5,coffset*-.5]) cube([framing+coffset,framing+coffset,fthick+2]);
    translate([framing+coffset/2,0]) cube2([tabdepth,framing,fthick],rx=0);
    translate([0,framing+coffset/2]) cube2([framing,tabdepth,fthick],ry=0);
    }
    translate([0,coffset*-.5]) {
        translate([.2+fthick/3,-.01,.1+fthick/3]) rotate([-90,0]) {
        cylinder(d=3,h=tabdepth-5,$fn=20);
        cylinder(d=5,h=4,$fn=30);
      }
      translate([2.8+fthick*(2/3),-.01,fthick*(2/3)-.2]) rotate([-90,0]) {
        cylinder(d=3,h=tabdepth-5,$fn=20);
        cylinder(d=5,h=4,$fn=30);
      }
    }
  }
}

module cube2(dims,r=4,rx=1,ry=1)
{
  linear_extrude(dims[2]) {
    translate([rx?r:0,0]) square([dims[0]-(rx?r*2:r),dims[1]]);
    translate([0,ry?r:0]) square([dims[0],dims[1]-(ry?r*2:r)]);
    for(x=rx?[r,dims[0]-r]:[dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=20);
  }
}