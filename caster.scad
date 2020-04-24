od=inches(4);
od2=od-4.4;
bd=22.2;
bd2=bd+12;
bt=7;
thick=40;
holes=6;
hod=(od2-bd2)/2-6;
hr=(360/holes);

!mirror([0,0,1]) cap();
//translate([0,0,7]) cap();
for(m=[0]) mirror([0,0,m])
{
  difference() { union() {
    difference() {
      cylinder(d=od,h=thick/2,$fn=100);
      translate([0,0,-.01]) cylinder(d=od2,h=thick/2+.02,$fn=100);
    }
    difference() {
      cylinder(d=bd2,h=bt-.02,$fn=60);
    }
    difference() {
      cylinder(d=od2,h=2,$fn=100);
      for(hi=[0:holes-1])
        rotate([0,0,hi*hr]) translate([od2/2-bd2/2,0,-.01]) cylinder(d=hod,h=3,$fn=40);
    }
    for(hi=[0:holes-1])
    {
      rotate([0,0,hi*hr+hr/2]) translate([bd2/2,-1.1]) cube([od2/2-bd2/2,2.2,7]);
      rotate([0,0,hi*hr+hr/2]) translate([od/2-4.4,0]) linear_extrude(thick/2) {
        difference() {
          hull() {
          translate([2,-6]) square([2,12]);
          circle(d=6,$fn=30);
          }
          *cylinder(d=6,h=thick/2,$fn=30);
        }
      }
    }
  }
  cylinder(d=8,h=thick,$fn=40);
      translate([0,0,-.01]) cylinder(d=bd,h=bt,$fn=60);
  for(r=[0:hr:359]) rotate([0,0,r+hr/2]) translate([od/2-4.4,0,-.01]) cylinder(d=3,h=thick/2+.02,$fn=20);
  for(r=[0:60:359]) rotate([0,0,r]) translate([bd2/2-3,0,-.01]) cylinder(d=3,h=bt+3,$fn=20);
  }
}

module cap()
{
  difference() {
    translate([0,0,-.5]) cylinder(d=bd2,h=3.5,$fn=60);
    translate([0,0,-.01]) cylinder(d=9,h=3.02,$fn=40);
    for(r=[0:60:359]) rotate([0,0,r]) translate([bd2/2-3,0,-.51]) cylinder(d=3,h=bt+3,$fn=20);
    mirror([0,0,1]) cylinder(d1=bd-2,d2=bd-1,h=.51,$fn=60);
  }
}
  
function inches(in) = in * 25.4;