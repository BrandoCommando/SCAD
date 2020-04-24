difference() {
  cube([100,100,10]);
  for(x=[10:25:85],y=[12.5:25:90])
    translate([x,y]) rotate([0,15]) cylinder(d=25.4*(3/4),h=20,$fn=40);
}