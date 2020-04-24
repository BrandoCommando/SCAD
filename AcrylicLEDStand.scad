awidth=25.4*4;
ledcols=15;

difference() {
  translate([50-awidth/2-3,-2]) cube([awidth+6,24,20]);
  for(y=[3,10,17]) translate([50,y])
  {
    translate([awidth*-.5,-1.6,10]) cube([awidth,3.2,20]);
    for(n=[0:ledcols-1]) translate([n*7-((ledcols-1)/2)*7,0,-.01]) {
      cylinder(d=5.4,h=8.01,$fn=30);
      translate([0,0,8]) cylinder(d1=5.4,d2=3,h=1.4,$fn=30);
      translate([0,0,9]) cylinder(d=3,h=10,$fn=20);
    }
  }
}
