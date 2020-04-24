skip_wally=1;
skip_switch_panel=1;
include<WALLY_Customizer (original).scad>;
include<SwitchPanel.scad>;

hole_dist = 48.41875 * 2;
switch_offset = 46.0375;
boxw = 116;
boxh = 114;
boxd = 90;

echo(str("Plate Dims: ",solid_plate_width,"x",height_sizes[plate_size]));

*translate([boxw/2-solid_plate_width/2,boxh/2-height_sizes[plate_size]/2,boxd]) wally_customizer();
*translate([boxw+8,boxh/2,10]) rotate([0,-90])
{
  difference(){
    switch_pattern() translate([-8,-16]) cube([18,32,22]);
    switch_pattern() switch();
  }
}
difference(){
  union(){
    cube([boxw,boxh,boxd]);
  }
  translate([2,2,2]) cube([boxw,boxh-4,boxd]);
  *translate([boxw+8,boxh/2,10]) rotate([0,-90]) switch_pattern() switch();
}
translate([boxw-5,7,2]) cylinder(d=8,h=4,$fn=20);
translate([boxw/2-switch_offset/2,boxh/2-hole_dist/2]) for(x=[0:1],y=[0:1])
{
  translate([x*switch_offset, y*hole_dist])
  difference() {
    union(){
      cylinder(d=10,h=boxd,$fn=30);
      if(y==0)
        translate([-5,-8]) cube([10,8,boxd]);
      else
        translate([-5,0]) cube([10,8,boxd]);
    }
    translate([0,0,-.01]) cylinder(d=4,h=boxd+.02,$fn=20);
    translate([0,0,boxd-3]) cylinder(d1=4,d2=6.6,h=3.01,$fn=20);
  }
}
module switch_pattern() {
  translate([0,16]) children(0);
  translate([0,-16]) children(0);
  translate([18,-16]) children(0);
  translate([18,16]) children(0);
}