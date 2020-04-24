part="neck";
thick=1.6;
centerd=25.4*(3/8)+.8;
neckh=12;
necklip=0;
if(part=="base"||part=="all")
  color(part=="all"?"blue":undef) base();
if(part=="all"||part=="neck")
  translate([0,0,part=="all"?12.7:0])
    neck();
module neck() {
  difference() {
    union() {
      cylinder(d=centerd+thick*2,h=neckh,$fn=50);
      for(r=[0:90:359]) rotate([0,0,r]) {
        translate([26,0]) cylinder(d=3+thick*2,h=3,$fn=30);
        hull() {
          cylinder(d=centerd+thick*2,h=neckh-2,$fn=50);
          translate([20,0]) cylinder(d=3+thick*2,h=3,$fn=30);
        }
          translate([20,-1.5-thick]) cube([6,3+thick*2,3]);
      }
    }
    translate([0,0,-.01]) difference() {
      cylinder(d=centerd,h=20,$fn=50);
      if(necklip)
      {
        difference() { cylinder(d=centerd,h=necklip,$fn=50); translate([0,0,-.01]) cylinder(d=centerd-necklip,h=necklip+.02,$fn=50); }
      }
    }
    for(r=[0:90:359]) rotate([0,0,r]) translate([26,0,-.01]) cylinder(d=3,h=3.02,$fn=20);
  }
}
module base() {
linear_extrude(12.7) {
  difference() {
    union() {
      circle(d=50,$fn=100);
      for(r=[0:90:359]) rotate([0,0,r]) translate([26,0]) {
        cd=3+thick*2;
        circle(d=cd,$fn=30);
        translate([cd/-2,cd/-2]) square([cd/2,cd]);
      }
    }
    circle(d=50-thick*2,$fn=100);
    for(r=[0:90:359]) rotate([0,0,r]) translate([26,0]) circle(d=3,$fn=20);
  }
}
}