import("Catan/Settlers_of_Catan_Dual_Extrusion_Complete_Original___5-6_Player_Expansion_with_magnetic_tile_bases_and_full_storage_case/files/Sandstorm.stl");
translate([-1.14,-1.01]) {
  translate([0,0,5]) cylinder(d1=24,d2=5,h=1.4,$fn=32);
  *cylinder(d=16,h=3.2,$fn=20);
  difference(){
    cylinder(d=25,h=5,$fn=32);
    translate([0,0,-.01]) cylinder(d=20,h=3.5,$fn=32);
  }
}