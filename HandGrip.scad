intersection()
{
  translate([-10,-25,-17]) cube([200,50,17]);
  union() {
    for(m=[0,1],x=[5,35,70,105]) mirror([0,m]) translate([x,-20,-20]) linear_extrude(28,convexity=3) difference() { circle(d=7,h=28,$fn=40); circle(d=3,$fn=20); }
  scale(1.25) rotate([0,90]) difference() {
  *translate([0,0,-6]) cylinder(d=28,h=72,$fn=100);
  translate([-14,-14,-6]) cube([28,28,98]);
  union() {
    for(z=[0:9]) {
      zr=(z==0?6:(z%4==0?6:5));
      translate([0,0,z*8]) rotate_extrude($fn=60) translate([zr+.1,0]) circle(r=zr,$fn=30);
    }
  translate([0,0,80]) sphere(r=9,$fn=50);
  }
translate([0,0,-6.01]) cylinder(d=12,h=79,$fn=40);
translate([0,0,-6.02]) linear_extrude(3) difference() { circle(d=48,$fn=60);
  //circle(d=24,$fn=80);
}
}
  }
}
