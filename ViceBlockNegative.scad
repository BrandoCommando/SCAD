sides=inches(1.5);
h=inches(1.25)+2;
lip=inches(.125);
r=sides/2;
shell=1;
difference() {
  linear_extrude(h,convexity=3)
    hull()
      for(x=[r,sides-r],y=[r,sides-r])
        translate([x,y]) circle(r=r,$fn=max(12,r*5));
  for(y=[-.01,sides-lip+.01]) translate([-.01,y,h-lip]) cube([sides+.02,lip,lip+.01]);
}
if(shell) {
  translate([sides/2,-sides]) difference() {
    cylinder(d=sides+10,h=h+6,$fn=60);
    translate([0,0,2]) cylinder(d=sides+10-1.61*2,h=h+10,$fn=50);
    translate([0,0,-.01]) cylinder(d=sides+.2,h=2.02,$fn=40);
  }
}
function inches(in) = 25.4 * in;

