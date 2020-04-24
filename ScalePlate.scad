btw=120;
bth=80;
btd=10;
ttw=80;
tth=80;
ttd=6;
xd1=15;
xd2=40;
*!for(xo=[xd1*-.5,xd1*.5],xo2=[xd2/2]) translate([btw/2-xo2+xo,bth/2]) cylinder(d=10,h=10,$fn=40);
top_plate();
module top_plate() {
  union() {
    cube([ttw,tth,3]);
    for(y=[0,tth-1.8]) translate([0,y])
      cube([ttw,1.8,ttd]);
    for(x=[0,ttw-1.8]) translate([x,0])
      cube([1.8,tth,ttd]);
    for(xo=[xd1/2,xd1/-2],xo2=[0])
      translate([ttw/2-xo+xo2,tth/2,3])
        rotate([0,0,30]) difference() {
          cylinder(d1=16,d2=12,h=3,$fn=6);
          translate([0,0,-.01]) cylinder(d=8,h=3.02,$fn=6);
        }
  }
}
module base_plate() {
difference() {
  cube([btw,bth,btd]);
  for(x=[5,btw/2+2.5],y=[5,bth/2+10])
  translate([x,y,-.01]) cube([btw/2-7.5,bth/2-15,btd+.02]);
  for(xo=[xd1*-.5,xd1*.5],xo2=[xd2/2])
  translate([btw/2-xo2+xo,bth/2,-.01]) {
    cylinder(d=5,h=btd+.02,$fn=30);
    translate([0,0,btd-5.5]) cylinder(d=9,h=5.52,$fn=40);
  }
}
}