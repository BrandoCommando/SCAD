part="head";
include <ParametricCableChain.scad>;

dist1=17.4;
dist2=33.2;
dx3=14;
dy3=43.1;
head_spots=[
  [50/2+dist2/2,10],
  [50/2-dist2/2,10],
  [50/2-dist2/2+dx3,10+dy3]
  ];

if(part=="head") laser_head_mount();

module laser_rail_mount() {
linear_extrude(3) difference() {
  square([32,20]);
  for(x=[32/2-dist1/2,32/2+dist1/2])
    translate([x,10]) circle(d=3,$fn=20);
}
}

module laser_head_mount() {
  //linear_extrude(2)
  difference() {
    union() {
  translate([20,20]) square([46,20]);
  translate([60,-20]) square([12,54]);
      translate([66,34]) circle(d=12);
  translate([66,-12]) 
    circle(d=30);
    hull()
      for(i=[0:2])
        translate(head_spots[i]) circle(d=16);
    }

    for(i=[0:2])
      translate(head_spots[i]) {
        hull() {
          translate([0,2]) circle(d=3.5);
          translate([0,-2]) circle(d=3.5);
        }
      }
  
    translate([66,-12]) circle(d=20);
  }
  *translate([30,30,2]) rotate([0,0,90]) output_cablechain([[1,0]]);
}