od=27;
id=20.8;
nozzle_dia=8;
twist=0;
poles=3;
th=48;
add_nozzle=twist>0;
bottom_ring=!twist;
guide_holes=bottom_ring&&0;
zr=360/poles;
*nozzle();
mirror([0,0,bottom_ring==0?1:0])
{
difference() {
  union() {
    if(bottom_ring&&guide_holes)
    for(r=[zr/(twist>0?4:2):zr:360]) rotate([0,0,r]) translate([25,0]) cylinder(d=8.6,h=10,$fn=40);
mirror([0,0,0]) intersection() {
  cylinder(r=26,h=th,$fn=50);
  union() {
    if(bottom_ring)
    linear_extrude(6,convexity=10) { difference() { circle(r=26,$fn=50); circle(r=24,$fn=50); } }
    difference() {
      union() {
        for(r=[0:zr:359]) rotate([0,0,r]) linear_extrude(th-2, convexity=10, twist=twist, scale=.55) {
          translate([20,0]) scale([2,1]) circle(d=8,$fn=40);
        }
      }
      translate([0,0,-.01]) cylinder(d=id,h=th+10,$fn=50);
      translate([0,0,-.01]) cylinder(r1=bottom_ring?24:18,d2=add_nozzle?od:id,h=th-18,$fn=50);
      *translate([0,0,th-18]) cylinder(d=od,h=6.1,$fn=50);
      translate([0,0,th-18.02]) cylinder(d=od+3.6,h=16.1,$fn=50);
      if(!add_nozzle)
        translate([0,0,th-12]) cylinder(d=od+10,h=10,$fn=50);
      *translate([0,0,30]) nozzle();
    }
    if(add_nozzle)
    translate([0,0,30]) nozzle();
  }
}
}
  if(guide_holes)
    for(r=[zr/(twist>0?4:2):zr:360]) rotate([0,0,r]) translate([25,0,-.1]) cylinder(d=5,h=10.2,$fn=40);
    }
*difference() {
  cylinder(d=od,h=50,$fn=60);
  translate([0,0,3]) cylinder(d=id,h=50,$fn=50);
}
}
module nozzle() {
  translate([0,0,16]) difference() {
    union() {
      translate([0,0,-16]) cylinder(d=od+3.6,h=36,$fn=50);
      *translate([0,0,20]) cylinder(d1=od+3.6,d2=od,h=4,$fn=50);
    }
    translate([0,0,-.01]) cylinder(d=nozzle_dia,h=10.02,$fn=30);
    translate([0,0,2]) cylinder(d1=nozzle_dia,d2=id,h=4,$fn=50);
    translate([0,0,5.99]) cylinder(d=od+.4,h=20,$fn=50);
    translate([0,0,od*-.7]) scale([1,1,1.5]) sphere(d=od,$fn=50);
  }
}