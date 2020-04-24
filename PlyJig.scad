jigw=inches(.75);
difference() {
  translate([-2,0]) cube([jigw+8,70,10]);
  translate([3,-.01,3]) rotate([-90,0]) linear_extrude(70.02) {
    hull() {
      for(x=[0,jigw-2],y=[0,-10]) translate([x,y]) circle(r=1,$fn=20);
      
    }
  }
}
function inches(in) = 25.4 * in;