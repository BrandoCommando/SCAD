depth=16;
difference(){
  union(){
    cube([65,30,depth]);
    translate([0,-30]) cube([20,90,depth]);
  }
  translate([6,6,-.01]) linear_extrude(depth+.02) {
    translate([2.5,-1]) square([50,20]);
    for(x=[0,52.5])
      translate([x,1.25]) square([10,15]);
    for(x=[2.5,52.5],y=[1.5,16.5])
      translate([x,y]) circle(d=5,$fn=30);
  }
  translate([0,15]) for(m=[0,1]) mirror([0,m]) translate([0,-15])
  translate([0,0,-.01]) linear_extrude(depth+.02) {
    for(y=[-5,35]) translate([20,y]) circle(d=10,$fn=50);
    polygon([[5,-30.01],[15.4,-3],[60,-3],[66,3],[66,-35],[30,-35]]);
  }
}