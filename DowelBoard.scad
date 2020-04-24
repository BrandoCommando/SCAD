translate([-10,-10]) cube([170,170,4]);
translate([0,0,2]) intersection() {
  for(x=[0:6],y=[0:6])
    translate([x*25,y*25]) rotate([0,10]) {
      cylinder(d=8,h=40,$fn=40);
      translate([0,0,2]) cylinder(d1=12,d2=8,h=6,$fn=40);
      translate([0,0,40]) sphere(d=8,$fn=40);
    }
  translate([-10,-10]) cube([180,170,60]);
}
