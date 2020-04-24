stripw=17;
difference()
{
translate([-10,0]) rotate([0,0,90]) import("/Users/brandon/Downloads/3dPrints/BabyNES_Raspberry_Pi_B+_case/files/baby_pi_nes_lid_vented.stl");
color("black") translate([60,0]) {
  //box_ramp(stripw,92,1,1);
  cube([stripw,92,3]);
  cube([stripw,1,20]);
  translate([0,91]) cube([stripw,1,20]);
  translate([0,0,19.2]) mirror([0,0,1]) box_ramp(stripw,2,1,1);
  translate([0,89,19.2]) mirror([0,0,1]) box_ramp(stripw,2,1,1);
}
}

module box_ramp(w,h,d,ramp=1)
{
  mirror([0,1]) rotate([90,0,0]) linear_extrude(h)
    polygon([[0,0],[ramp,d],[w-ramp,d],[w,0]]);
}