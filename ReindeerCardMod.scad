difference() {
//union() {
  *import("Reindeer_card_kit/files/reindeer_card_thin_frame.stl");
  translate([21.315,35.24]) translate([45,66,-.01]) rotate([0,0,2]) linear_extrude(2,convexity=3) offset(0) text("Bowles",spacing=1.1,font="Stencil Std",valign="center",halign="center");
}