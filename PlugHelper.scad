*
  difference(){
    translate([-5,-4]) cube([10,8,6]);
    translate([0,0,-.01]) cylinder(d=4,h=6.02,$fn=20);
}
linear_extrude(3)
difference(){
  translate([-25,-43]) minkowski(){
    square([50,86]);
    circle(d=2,$fn=20);
  }
  minkowski(){
    square([40,70],center=true);
    circle(r=2,$fn=16);
  }
  for(x=[0],y=[41.6,-41.6])
    translate([x,y]) circle(d=3,$fn=20);
  for(x=[-16,-11,6,11],y=[-52.5,52.5])
    translate([x,y]) circle(d=4,$fn=20);
}
