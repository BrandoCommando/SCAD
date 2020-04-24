difference() {
  cube([60,10,4]);
  translate([5,0]) for(x=[0,50]) translate([x,5]) cylinder(d=3,h=20,$fn=20);
}
import("gopro-spare-parts/fast_clip.stl");