brushw=55;
brushh=110;
brushd=15;
handlew=40;
thick=1.2;
difference() {
  union() {
    cube([brushw+thick*2,brushd+thick*2,brushh+thick]);
    translate([thick+brushw/2,0.01,20]) rotate([90,180]) linear_extrude(.5) text("SHORT",halign="center", valign="center");
    translate([thick+brushw/2,0.01,32]) rotate([90,180]) linear_extrude(.5) text("CUT",halign="center",valign="center");
  }
  translate([thick,thick,thick]) cube([brushw,brushd,brushh+.02]);
  translate([thick+brushw/2-handlew/2,thick,-.01]) cube([handlew,brushd,thick+.02]);
}