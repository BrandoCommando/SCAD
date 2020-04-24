for(x=[0:50:200])
  translate([x,0,0]) cube([5,160,5]);
cube([205,5,5]);
module centerpiece() {
rotate_extrude($fn=50) {
  difference() {
    square([10,30]);
    translate([36,15]) circle(r=30,$fn=80);
  }
}
}
module leg() {
intersection() {
  square([40,50]);
  outline(3) {
    translate([36,40]) circle(r=30,$fn=80);
  }
}
}
module outline(dist=2)
{
  difference() {
    minkowski() {
      children();
      translate([dist*-.5,dist*-.5]) square([dist,dist]);
    }
    children();
  }
}