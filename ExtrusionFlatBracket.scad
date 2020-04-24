rotate([0,0,90]) linear_extrude(3) difference() {
  hull(){
    circle(d=20,$fn=50);
    translate([180,0]) circle(d=20,$fn=50);
  }
  for(x=[0:20:200]) translate([x,0]) circle(d=5,$fn=25);
}