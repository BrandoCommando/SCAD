mh=5; // main height
md=56; // main depth
mw=40; // main width
sw=6; // side width
bw=4; // back width
gd=6; // grip depth
gh=0; // grip height
ws=5; // wedge size
midh=20; // middle height
midw=20; // middle width
br=1; // box radius

difference(){
  union(){
    box([mw,bw,mh],1,1,0);
    translate([0,0,0]) box([sw,md+2,mh],r=sw/2-.01,bottom=0);
    translate([mw-sw,0,0]) box([sw,md+2,mh],r=sw/2-.01,bottom=0);
    if(gd>0&&gh>0) {
      translate([0,md-gd+2,0]) box([sw,gd,gh+mh],r=gd/2-.01,bottom=0);
      translate([mw-sw,md-gd+2,mh-2]) box([sw,gd,gh+2],r=gd/2-.01,bottom=0);
    }
    translate([mw/2-midw/2,0,0]) box([midw,bw,midh]);
  }
  if(gd>0&&gh>0)
  translate([-0.01,md+2-ws,0]) rotate([-45,0]) cube([mw+.02,40,20]);
  //#translate([-0.01,20,24]) rotate([200,0]) cube([51,30,10]);
  translate([mw/2,-.01,5]) rotate([270,0]) {
    cylinder(d=4,h=bw+.02,$fn=20);
    translate([0,0,bw-2]) cylinder(d1=4,d2=8,h=2.01,$fn=30);
  }
  translate([mw/2,-.01,14]) rotate([270,0]) {
    cylinder(d=4,h=bw+.02,$fn=20);
    translate([0,0,bw-2]) cylinder(d1=4,d2=8,h=2.01,$fn=30);
  }
  *translate([16,-0.01,8]) rotate([270,0]) {
    cylinder(d=4,h=10,$fn=20);
    translate([0,0,bw-2]) cylinder(d1=4,d2=8,h=2.01,$fn=30);
  }
  *translate([mw-16,-0.01,8]) rotate([270,0]) {
    cylinder(d=4,h=10,$fn=20);
    translate([0,0,bw-2]) cylinder(d1=4,d2=8,h=2.01,$fn=30);
  }
}

module box(size,r=br,top=1,bottom=1)
{
  w=size[0];
  d=size[1];
  h=size[2];
  intersection(){
    cube([w,d,h]);
    minkowski(){
      translate([r,r,bottom?r:0]) cube([w-r*2,d-r*2,h-(top?r:0)-(bottom?r:0)]);
      sphere(r,$fn=30);
    }
  }
}