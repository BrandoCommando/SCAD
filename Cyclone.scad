outer_dia=180;
hi=120;
inner_hi=0.45;
thick=4;
hose_in_dia=56;
hose_out_dia=56;

difference(){
  union(){
    cylinder(d=outer_dia,h=hi,$fn=200);
    translate([0,outer_dia/-2]) cube([outer_dia/2,hose_in_dia+thick*2,hose_in_dia+thick*2]);
    *translate([0,outer_dia/-2+hose_in_dia/2+thick,hose_in_dia/2+thick]) rotate([0,90]) cylinder(d=hose_in_dia,h=outer_dia/2+20,$fn=hose_in_dia*2);
  }
  translate([0,0,thick+outer_dia*inner_hi]) cylinder(d=hose_out_dia+thick*2+1,h=hi,$fn=100);
  translate([0,0,-.02]) {
    cylinder(d=hose_out_dia,h=hi+.04,$fn=80);
  }
  rotate_extrude($fn=200) {
    translate([hose_out_dia/2+thick,thick]) square([outer_dia/2-hose_out_dia/2-thick*2,hi]);
  }
  translate([0,outer_dia/-2+hose_in_dia/2+thick,hose_in_dia/2+thick]) rotate([0,90]) cylinder(d=hose_in_dia-thick,h=outer_dia/2+20.02,$fn=hose_in_dia*2);
}