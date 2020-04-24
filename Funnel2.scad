bod=100;
lod=12;
h=70;
t=1.6;
difference() {
  cylinder(d1=bod,d2=lod,h=h,$fn=100);
  translate([0,0,-.1]) cylinder(d1=bod-t*2,d2=lod-t*2,h=h+.2,$fn=100);
}
translate([0,0,h]) linear_extrude(16) difference() { circle(d=lod,$fn=50); circle(d=lod-t*2,$fn=40); }
translate([0,0,-8]) {
  linear_extrude(8) difference() { circle(d=bod,$fn=100); circle(d=bod-t*2,$fn=100); }
  rotate_extrude($fn=100) {
    translate([bod/2,0]) {
      square([20,1.2]);
      translate([0,0.9])
        difference() {
          square([6,6]);
          translate([6,6]) circle(r=6,$fn=30);
        }
    }
  }
}