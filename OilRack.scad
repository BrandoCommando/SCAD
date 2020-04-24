layerthick=2.9;
kerf=0.1;
panelsize=[inches(4),inches(8)];
smalld=29;
bigd=29;
dist=(panelsize[1]-5)/6;
disty=panelsize[0]/3;
griphang=6;
show_3d=1;
//$fn=20;

if(show_3d)
{
  panel1();
  translate([0,0,layerthick]) panel2();
  translate([0,0,layerthick*2]) panel3();
  
  color("blue") mirrorx(panelsize[0]) for(y=[5+bigd,panelsize[1]-bigd-5-layerthick])
    translate([-.01,y+kerf]) {
      difference() {
        translate([0,0,-griphang]) cube([griphang*2,layerthick-kerf*2,layerthick*3+griphang*2]);
        translate([griphang,0]) cube([griphang,layerthick-kerf*2,layerthick*3]);
      }
    }
  color("blue") mirrory(panelsize[1]) translate([4,0]) for(x=[(panelsize[0]-10)/3,(panelsize[0]-10)*(2/3)])
    translate([x+kerf,-.01,-griphang]) difference() {
      cube([layerthick-kerf*2,griphang,layerthick*3+griphang*2]);
      translate([griphang,-.01,griphang-kerf]) cube([griphang+.02,griphang*2+.02,layerthick*3+kerf*2]);
    }
} else {
  panel1();
  translate([panelsize[0]+.01, 0]) panel2();
  translate([panelsize[0]*2+.02,0]) panel3();
  *for(x=[0,panelsize[0]*3-5]) {
    translate([x,-5]) square([5,5]);
    translate([x,panelsize[1]]) square([5,5]);
  }
  rotate([0,0,-90]) for(y=[0:7])
    translate([1,y*(1+((griphang*2)+layerthick*3))]) grip();
*translate([panelsize[0],-5]) {
  square([panelsize[0],5]);
  translate([0,panelsize[1]+5]) square([panelsize[0],5]);
}
}

module grip() {
  difference() {
    rsquare([griphang*2,layerthick*3+griphang*2]);
    translate([griphang+kerf,griphang+kerf]) square([griphang,(layerthick*3)-kerf*2]);
  }
}

module panel1() {
panel()
{
  //square(panelsize);
  screwholes();
  translate([disty*2,0]) for(y=[18:dist:panelsize[1]-10])
    translate([16,y]) {
      circle(d=smalld);
      //translate([0,smalld/-2]) square([panelsize[0]-dist*2-16,smalld]);
    }
}
}
module panel2() {
panel()
{
  //square(panelsize);
  screwholes();
  translate([disty,0]) for(y=[18+dist/2:dist:panelsize[1]-19])
    translate([18,y]) circle(d=smalld);
  translate([disty*2,0]) for(y=[18:dist:panelsize[1]-10])
    translate([16,y]) {
      circle(d=smalld);
      //translate([0,smalld/-2]) square([panelsize[0]-dist*2-16,smalld]);
    }
}
}
module panel3() {
panel()
{
  //square(panelsize);
  screwholes();
  for(y=[19:dist:panelsize[1]-10])
    translate([20,y]) circle(d=bigd);
  translate([disty,0]) for(y=[18+dist/2:dist:panelsize[1]-19])
    translate([18,y]) {
      circle(d=smalld);
      //translate([0,smalld/-2]) square([panelsize[0]-dist-18,smalld]);
    }
  translate([disty*2,0]) for(y=[18:dist:panelsize[1]-10])
    translate([16,y]) {
      circle(d=smalld);
      //translate([0,smalld/-2]) square([panelsize[0]-dist*2-16,smalld]);
    }
}
}
module screwholes() {
  mirrorx(panelsize[0]) for(y=[5+bigd,panelsize[1]-bigd-5-layerthick])
    translate([-.01,y+kerf]) square([5,layerthick-kerf*2]);
  mirrory(panelsize[1]) translate([4,0]) for(x=[(panelsize[0]-10)/3,(panelsize[0]-10)*(2/3)])
    translate([x+kerf,-.01]) square([layerthick-kerf*2,5]);
  *for(x=[5,panelsize[0]-5],y=[5,panelsize[1]-5])
    translate([x,y]) circle(d=3,$fn=20);
}
module panel()
{
  if(show_3d) linear_extrude(layerthick) difference() {
    square(panelsize);
    children();
  } else difference() {
    hull() for(x=[5,panelsize[0]-5],y=[5,panelsize[1]-5]) translate([x,y]) circle(r=5);
    children();
  }
}

module rsquare(dims,r=2)
{
  for(x=[r,dims[0]-r],y=[r,dims[1]-r])
    translate([x,y]) circle(r=r);
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
}
module mirrorx(off) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off) {
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}
function inches(in) = in * 25.4;