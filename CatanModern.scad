translate([0,0,-3.4]) cylinder(d=15,h=3.4,$fn=32);
translate([-4.25,-4.25,0]) cube([8.5,8.5,14.7]);
for(f=[1:0.82:11])
  translate([0,0,2.8+f]) rotate([0,0,45]) {
    cylinder(d1=12,d2=12.5,h=0.4,$fn=4);
    translate([0,0,0.4]) cylinder(d=12.5,h=0.3,$fn=4);
  }
for(vm=[0:1],hm=[0:1],wr=[0,90]) rotate([0,0,wr])  mirror([vm,0]) mirror([0,hm]) translate([4.045,-1.55]) linear_extrude(16.5) rotate([0,0,-90]) scale(0.375) {
  translate([0,0]) square([2,2]);
  translate([-1,0]) square([4,1]);
}
for(f=[1,2.6,13.6]) translate([0,0,f]) rotate([0,0,45]) {
    cylinder(d1=12,d2=13.5,h=0.4,$fn=4);
  translate([0,0,0.4]) cylinder(d=13.5,h=f>5?0.8:0.5,$fn=4);
}
  translate([-2.125,-2.125,14.8]) {
    difference() {
      cube([4.25,4.25,2.8]);
      translate([0.2,0.2,2.6]) cube([3.85,3.85,2]);
    }
    translate([2.125,2.125,2.4]) linear_extrude(0.4) {
      difference(){
        circle(d=3.2,$fn=20);
        circle(d=2.8,$fn=20);
      }
      text("H",size=1.8,valign="center",halign="center");
    }
  }
  translate([-4.2,-2.125,14.8]) difference() {
    cube([8.4,4.25,1.4]);
    translate([0.2,0.2,1.2]) cube([8,3.85,2]);
  }
  translate([-2.125,-4.2,14.8]) difference(){
    cube([4.25,8.4,1.4]);
    translate([0.2,0.2,1.2]) cube([3.85,8,2]);
  }
  translate([-4.2,-4.2,14.8]) difference() {
    cube([8.4,8.4,.4]);
    translate([0.2,0.2,0.2]) cube([8,8,.6]);
  }
*#translate([0,0,-1]) import("Settlers_of_Catan_Dual_Extrusion_Complete_Original___5-6_Player_Expansion_with_magnetic_tile_bases_and_full_storage_case/files/Player-Modern-City.stl");