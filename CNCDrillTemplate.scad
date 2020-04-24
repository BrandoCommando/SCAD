difference() {
  cube([25,105,20]);
  translate([12.5,-.5,12.5]) rotate([-90,0,0]) cylinder(d=24,h=106,$fn=80);
  translate([12.5,22.5]) cylinder(d=4,h=2,$fn=20,center=true);
  translate([12.5,97.5]) cylinder(d=4,h=2,$fn=20,center=true);
}
translate([0,-.8]) cube([25,.8,20]);