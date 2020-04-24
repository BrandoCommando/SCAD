tq = inches(3/4);

color("white") translate([0,0,inches(30)]) {
  *cube([inches(24),inches(24),tq]);
  translate([inches(12),inches(12)]) cylinder(d=inches(24),h=tq,$fn=100);
}
translate([inches(12),inches(12)-tq/2]) union() {
  for(r=[0,90]) color(r==0?"red":"blue") rotate([0,0,r]) translate([-inches(6),tq/2]) rotate([90,0]) linear_extrude(tq) {
      difference() {
      translate([inches(-6),0]) polygon([
        [inches(4),inches(2)],
        [inches(4),0],
        [inches(0),0],
        [inches(0),inches(6)],
        [inches(6),inches(12)],
        [inches(6),inches(22)],
        [inches(2),inches(26)],
        [inches(2),inches(30)],
        [inches(6),inches(30)],
        [inches(6),inches(28)],
        [inches(8),inches(26)],
        [inches(16),inches(26)],
        [inches(18),inches(28)],
        [inches(18),inches(30)],
        [inches(22),inches(30)],
        [inches(22),inches(26)],
        [inches(18),inches(22)],
        [inches(18),inches(12)],
        [inches(24),inches(6)],
        [inches(24),0],
        [inches(20),0],
        [inches(20),inches(2)]]);
        translate([inches(6)-inches(.5),(r/90)*((inches(30)-tq)/2-inches(.25))]) square([inches(1),(inches(30)-tq)/2]);
      }
    }
}
*translate([inches(12)-tq/2,inches(6)]) cube([tq,inches(12),inches(30)-tq]);

module mirrorx(off=0) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off=0) {
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}
function inches(in) = in * 25.4;