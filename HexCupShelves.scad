bd=50;
bh=80;
bt=2;
bb=0;
dx=bd*.735;
sides=6;
dy=(bd*cos(180/sides))-bt/2;
od=165;
ot=16;
for(y=[1:3])
  {
    xrange=y==3?[2]:[1:3];
    for(x=xrange)
    {
      translate([x*dx,y*dy+(dy*.5*(x%2))]) hex_cup(bd,bh,bt,0.9);
    }
  }
*difference(){
  *cylinder(d=od,h=bh,$fn=100);
  *translate([0,0,-.01]) cylinder(d=od-20,h=bh+1,$fn=100);
  translate([od*-.5,od*-.5]) cube([od,od,bh]);
  translate([od*-.5+ot,od*-.5+ot,-.01])
    cube([od-ot*2,od-ot*2,bh+2]);
  translate([od*-.5+ot/2+bt,od*-.5+bt+ot/2,1.6])
    minkowski(){
      translate([0,0,ot/2]) cube([od-bt*2-ot,od-bt*2-ot,bh]);
      sphere(ot/2);
    }
  *translate([0,0,1.6]) minkowski() {
    translate([0,0,10]) cylinder(d=od-bt-20,h=bh+1,$fn=100);
    sphere(10);
  }
  *translate([0,0,bb>0?bb:-.01])
    cylinder(d=od-bt,h=bh+1,$fn=100);
}
*intersection(){
  *cylinder(d=od,h=bh,$fn=100);
  translate([od*-.5,od*-.5]) cube([od,od,bh]);
translate([-55,dy*-.25]) {

  for(y=[-2:2])
  {
    for(x=[-1:4])
    {
      translate([x*dx,y*dy+(dy*.5*(x%2))]) hex_cup(bd,bh,bt,bb);
    }
  }
}
}
module hex_cup(d,h,t=1,back=0)
{
  difference(){
    cylinder(d=d,h=h,$fn=sides);
    translate([0,0,back>0?back:-.01])
      cylinder(d=d-t,h=h+0.02,$fn=sides);
  }
}