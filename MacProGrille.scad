show3d=0;
if(show3d)
{
  linear_extrude(3) cheese(offy=5);
  translate([5,2.5,-3]) linear_extrude(3) difference() {
    translate([-5,-2.5]) square([90,98]);
    cheese(1,cw=80);
  }
} else {
difference() {
  cheese(offy=5);
  for(x=[3,87],y=[3,95]) translate([x,y]) circle(d=3,$fn=20);
}
translate([91,0]) translate([5,2.5]) difference() {
  translate([-5,-2.5]) square([90,98]);
  cheese(1,cw=80);
  translate([-5,-2.5]) for(x=[3,87],y=[3,95]) translate([x,y]) circle(d=3,$fn=20);
}
}
module cheese(type=0,offx=0,offy=0,cw=90,ch=98) {
  ycnt=(ch-10-offy)/8;
  difference() {
  if(type==0) square([cw,ch]);
  translate([5+offx,5+offy]) for(yi=[0:ycnt])
    for(xi=[0:(cw-(yi%2==0?20:10))/10])
      translate([xi*10+(yi%2==0?5:0),yi*8]) {
        if(type==0)
          circle(d=8,$fn=40);
        else
        {
          //circle(d=8,$fn=36);
          for(r=(yi==0)?[240,120]:(yi==ycnt?[0]:[0:120:359])) rotate([0,0,r]) translate([0,-2]) circle(d=5,$fn=30);
        }
      }
}
}