kerf=0.1;
thick=5;

fingerspace=4;
fingerwidth=5;
mount_width=60;
mount_height=50;

bigd=110;

b_width=mount_height-fingerspace*2;
b_fingers=round_odd(b_width/fingerwidth);
b_fingerwidth=b_width/b_fingers;

spacers=(mount_width-thick*2)/thick;
echo(str("Each stack will need ", spacers, " spacers"));
echo(str("Fingers: ", b_fingers, " @ ", b_fingerwidth));

*!for(xi=[0:spacers-1],yi=[0:3])
  translate([xi*21,yi*21]) spacer();

for(y=[0,bigd*5/8]) translate([0,y]) hook_hanger();
translate([20+bigd/2-mount_width/2,bigd]) {
  mount_plate();
  translate([0,-mount_height-1]) mount_spacer();
}
*translate([20+bigd/2-20*3,bigd/2]) for(x=[0:21:140]) translate([x,0]) spacer();

module spacer() {
  difference() {
    circle(d=20,$fn=50);
    circle(d=3,$fn=20);
  }
}
module show3d() {
  for(z=[0,mount_width-thick]) translate([0,0,z]) linear_extrude(thick) hook_hanger();
  translate([thick*2,0]) rotate([0,-90]) linear_extrude(thick) mount_plate();
  translate([thick,0]) rotate([0,-90]) linear_extrude(thick) mount_spacer();
}
module mount_spacer()
{
  difference() { translate([thick, 0]) square([mount_width-thick*2,mount_height]); mount_holes(); }
}
module mount_plate()
{
  difference() {
    finger_plate([mount_width,mount_height],xfingers=0);
    mount_holes();
  }
}
module mount_holes() {
  for(x=[mount_width*3/8,mount_width*5/8]) translate([x,mount_height/2]) circle(d=5,$fn=30);
}
module finger_plate(dims,fingerspace=fingerspace,xfingers=1,yfingers=1)
{
  x_fingerspace=fingerspace+thick;
  x_width=dims[0]-x_fingerspace*2;
  x_fingers=round_odd(x_width/fingerwidth);
  x_fingerwidth=x_width/x_fingers;
  
  y_width=dims[1]-fingerspace*2;
  y_fingers=round_odd(y_width/fingerwidth);
  y_fingerwidth=y_width/y_fingers;
  
  echo(str("X Fingers: ", x_fingers, " @ ", x_fingerwidth));
  
  difference()
  {
    square(dims);
    if(xfingers)
    mirrory(dims[1]) for(x=[x_fingerspace:x_fingerwidth*2:x_width+x_fingerspace])
      translate([x,-.01]) square([x_fingerwidth-kerf*2,thick-kerf+.02]);
    if(yfingers)
    mirrorx(dims[0]) for(y=[fingerspace-y_fingerwidth:y_fingerwidth*2:y_width+fingerspace*2])
      translate([-.01,y]) square([thick-kerf+.02,y_fingerwidth-kerf*2]);
  }
}
module hook_hanger()
{
  mount_offsety=-mount_height+30;
  difference() {
    union() {
    hull() {
      translate([0,mount_offsety]) {
        square([20,mount_height]);
        square([30,10]);
      }
      translate([25,15]) circle(d=20,$fn=50);
    }
    translate([0,mount_offsety])
    offset(5)
    difference() {
      translate([20+bigd/2,mount_height/2]) circle(d=bigd,$fn=100);
      translate([20,25]) square([bigd,bigd]);
      translate([20+bigd/2,mount_height/2]) circle(d=bigd-20,$fn=100);
      translate([30,mount_height/2]) square([bigd-20,mount_height]);
    }
  }
      translate([0,mount_offsety]) for(x=[thick]) translate([x,fingerspace])
        for(bx=[0:b_fingerwidth*2:b_width])
          translate([-.01,bx+kerf]) square([thick-kerf+.02,b_fingerwidth-kerf*2]);
    translate([20+bigd/2,mount_height/2+mount_offsety]) for(r=[240:60:359]) rotate([0,0,r]) translate([bigd/2-5,0]) circle(d=3,$fn=20);
      translate([bigd,15]) square([30,20]);
  }
  for(x=[25,bigd+15])
  translate([x,15]) {
    difference() 
    {
      union() {
        translate([-10,-10]) square([20,10]);
        circle(d=20,$fn=50);
      }
      circle(d=3,$fn=20);
    }
  }
}


module mirrorxif(off,case) {
  translate([off/2,0]) for(m=case?[0,1]:[0]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrorx(off) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off) {
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}
function round_odd(num,min=3) = max(min,floor(num)-(1-(floor(num)%2)));
function inches(in) = in*25.4;