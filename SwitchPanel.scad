md=25.4*1.5;
mh=25.4*.75;
hole_dist = 48.41875 * 2;
if(!skip_switch_panel) switch_panel();
module switch_panel() {
echo(str("D: ",md," H: ",mh));
difference(){
  union(){
    translate([-15,-20]) box([90,44,mh],r=3,front=0,bottom=1);
    translate([-15,-20,4]) box([90,4,28],r=3,front=0);
    translate([-15,20,4]) box([90,4,28],r=3,front=0);
    translate([-15,-20,4]) box([6.99,44,28],r=3,front=0);
    translate([67.99,-20,4]) box([6.99,44,28],r=3,front=0);
    translate([4,-20,21]) box([12,4,20],r=1,front=0);
    translate([24,-20,21]) box([12,4,20],r=1,front=0);
    translate([44,-20,21]) box([12,4,20],r=1,front=0);
    *cylinder(d=md,h=mh,$fn=50);
    *translate([-24,-24,19]) cube([48,48,4]);
    *translate([0,0,mh-2]) intersection() {
      cylinder(d1=md,d2=md+2,h=2,$fn=50);
      translate([-2,md*-.5-2]) cube([4,md+4,2]);
    }
  }
  translate([10,-20.01,36]) rotate([-90,0]) cylinder(d=4,h=5,$fn=20);
  translate([30,-20.01,36]) rotate([-90,0]) cylinder(d=4,h=5,$fn=20);
  translate([50,-20.01,36]) rotate([-90,0]) cylinder(d=4,h=5,$fn=20);
  for(x=[0:3]) {
    translate([x*20,23,9]) rotate([-90,0])  rotate([0,0,180]) linear_extrude(2) text(x==3?"C":(x==2?"L":(x==1?"V":"D")),halign="center",valign="center",size=8);
    translate([x*20,4]) switch();
  }
}
*mirror([0,0,1]) {
cube([16,30,10.8]);
translate([8,15,2]) cylinder(d=12.4,h=18.8,$fn=30);
}
}
module switch() {
  translate([0,0,-.01])
    cylinder(d=13,h=mh+.02,$fn=20);
    translate([-8,-15,4]) cube([16,30,20.01]);
}

module box(size,r=1,top=1,bottom=1,left=1,right=1,front=1,back=1)
{
  w=size[0];
  d=size[1];
  h=size[2];
  intersection(){
    cube([w,d,h]);
    minkowski(){
      translate([left?r:0,front?r:0,bottom?r:0]) cube([w-(left?r:0)-(right?r:0),d-(front?r:0)-(back?r:0),h-(top?r:0)-(bottom?r:0)]);
      sphere(r,$fn=30);
    }
  }
}