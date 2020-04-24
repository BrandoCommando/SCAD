*!difference() {
  cylinder(d1=14,d2=10.4,h=1.8,$fn=50);
  translate([0,0,-.01]) cylinder(d=8,h=10,$fn=50);
}
maxx=inches(1);
maxy=inches(2);
bearod=16;
bearid=5;
beart=5;
bearxo=(bearod-2)/2;
xpos=[maxx/2];
*translate([-20,maxy-22.5,-12.5]) difference() {
  cube([99,25.4,25.4]);
  translate([-.5,1,1]) cube([100,23,23]);
}
translate([maxx/2,0]) for(m=[0]) rotate([0,m*180,0]) translate([maxx/-2,0]) {
  linear_extrude(2) difference() {
  hull() {
    for(x=[bearxo,maxx-bearxo],y=[bearxo,maxy-bearxo]) translate([x,y]) circle(r=bearxo,$fn=50);
  }
  for(x=xpos,y=[bearxo,maxy-bearxo])
  translate([x,y]) circle(d=3,$fn=40);
}
for(x=xpos) translate([x,maxy-bearxo,2]) difference() {
  union() {
    cylinder(d=bearid+3,h=.9,$fn=50);
    cylinder(d=bearid,h=1.1+beart,$fn=50);
  }
  translate([0,0,-.1]) cylinder(d=3,h=20,$fn=20);
  if(beart>5)
  {
    if(x>maxx/2) translate([0,0,6]) cylinder(d=5,h=3,$fn=40);
    else translate([0,0,6]) cylinder(d=7.1,h=3,$fn=6);
  }
}
}
for(x=xpos,z=[2.9,-10])
%translate([x,maxy-bearxo,z]) linear_extrude(beart) difference() { circle(d=bearod,$fn=50); circle(d=bearid,$fn=40); }

function inches(mm) = mm*25.4;