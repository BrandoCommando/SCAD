translate([22.5,0]) cube([5,30,1]);
for(y=[0,30])
  translate([0,y]) {
    hull()
      for(x=[10,40]) translate([x,5]) cylinder(d=10,h=1,$fn=50);
    for(x=[10,40])
      translate([x,5,1]) cylinder(d1=10,d2=4,h=3,$fn=40);
  }