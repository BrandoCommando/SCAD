part="plate";
font="Verdana:style=Bold";
spacing=1.1;
include <WALLY_Customizer.scad>;
difference(){
  wally_customizer();
*  translate([52,0,-.01]) linear_extrude(1) rotate([0,0,90]) mirror([0,1,0]) text("Hall",halign="center",valign="center",font=font,spacing=spacing);
*  translate([-52,0,-.01]) linear_extrude(1) rotate([0,0,270]) mirror([0,1,0]) text("Living",halign="center",valign="center",font=font,spacing=spacing);
}