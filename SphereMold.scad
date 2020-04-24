id=25.4*3/4;
difference() {
  translate([id*-.5-1.2,id*-.5-1.2]) cube([id+2.4,id+2.4,id/2+1.2]);
  translate([0,0,id/2+1.2]) sphere(d=id,$fn=80);
}