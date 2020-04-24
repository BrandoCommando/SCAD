cube([30,80,1]);
for(y=[20:15:70])
  translate([0,y,1]) rotate([90,-90,90]) linear_extrude(30,convexity=3) polygon([[0,0],[2,0],[0,3]]);