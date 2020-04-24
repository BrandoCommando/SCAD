difference() {
  union() {
    linear_extrude(8,convexity=3) {
      for(g=[0:4]) {
        translate([g*4,12+g*4*(3/20)]) circle(d=2,$fn=12);
        translate([g*4,-12-g*4*(3/20)]) circle(d=2,$fn=12);
      }
      difference() {
        union() {
          hull() {
            translate([20,0]) circle(d=30,$fn=50);
            circle(d=24,$fn=48);
          }
          translate([-30,-5]) square([20,10]);
        }
        hull() {
          translate([20,0]) circle(d=22,$fn=44);
          circle(d=16,$fn=32);
        }
      }
    }
  }
}