//14x10-3/8
//355x263
connection_type=2;
$fn=40;
difference() {
  translate([0,0,4]) linear_extrude(10,convexity=3) !union() {
    translate([10,10]) difference() {
      union() {
        translate([-10,-10]) {
          rsquare([20,20]);
          translate([2,0]) square([16,23.99]);
          translate([0,2]) square([23.99,16]);
          if(connection_type==1)
          {
            translate([2,0]) square([22,2]);
            translate([0,2]) square([2,22]);
          } else {
            translate([2,0]) rsquare([177.5,20]);
            translate([0,2]) rsquare([20,131.5]);
          }
        }
        
      //circle(d=22.2,$fn=80);
      }
      if(connection_type==2)
      {
        for(x=[20:24:180])
        {
          translate([x,0]) circle(d=5,$fn=35);
          translate([0,x]) circle(d=5,$fn=35);
        }
      }
      translate([0.5,0.5]) {
        circle(d=10.2,$fn=40);
        rotate([0,0,45]) for(r=[0:90:359]) rotate([0,0,r])
          translate([8.05,0]) circle(d=3,$fn=20);
      }
    }
  }
  for(x=[20,32])
  {
    translate([x+10,10,6]) cylinder(d=10,h=20,$fn=40);
    translate([10,x+10,6]) cylinder(d=10,h=20,$fn=40);
  }
  //translate([10,10,17]) cylinder(d=23,h=4,$fn=80);
  if(connection_type==1) {
    translate([10-7.8/2,17.5,10]) cube([7.8,5.3,20]);
    translate([17.5,10-7.8/2,10]) cube([5.3,7.8,20]);
    translate([20,10,10]) rotate([0,-90]) translate([0,0,-5]) {
      cylinder(d=5,h=15,$fn=40);
      translate([0,0,2.2]) cylinder(d=9,h=5.3,$fn=6);
    }
    translate([10,20,10]) rotate([90,0]) translate([0,0,-5]) {
      cylinder(d=5,h=15,$fn=40);
      translate([0,0,2.2]) rotate([0,0,30]) cylinder(d=9,h=5.3,$fn=6);
    }
  }
}

module rsquare(dims,r=2)
{
  for(x=[r,dims[0]-r],y=[r,dims[1]-r])
    translate([x,y]) circle(r=r);
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
}