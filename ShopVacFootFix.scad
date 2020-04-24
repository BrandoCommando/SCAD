translate([0,0,3]) difference() {
  cylinder(d=60,h=2,$fn=70);
  translate([0,0,-1]) cylinder(d=46,h=4,$fn=100);
  for(r=[0:45:359]) rotate([0,0,r]) translate([26,0,-1]) cylinder(d=3,h=4,$fn=20);
}
difference() {
  cylinder(d=60,h=2,$fn=70);
  translate([0,0,-1]) cylinder(d=13,h=4,$fn=30);
  translate([-6.5,0,-1]) cube([13,30,4]);
  for(r=[0:45:359]) rotate([0,0,r]) translate([26,0,-1]) cylinder(d=3,h=4,$fn=20);
}