rotate([90,0]) sphericon(0);
translate([50,0,2.5]) rotate([0,45]) wobbler(thick=5);
module sphericon(both=1) {
  for(side=both?[0,1]:[0]) intersection() {
    mirror([0,side,0]) translate([-20,0,-20]) cube(40);
    rotate([0,side*90,0]) for(m=[0,1]) mirror([0,0,m]) cylinder(d1=40,d2=0,h=20,$fn=80);
  }
}

module wobbler(slice_r=45,thick=10) {
  difference()
  {
    intersection() {
      rotate([0,slice_r]) cube([thick,30,50],center=true);
      rotate([0,90]) cylinder(d=20,h=thick*10,center=true,$fn=80);
    }
    rotate([0,90]) {
      cylinder(d=3,h=20,center=true,$fn=20);
      for(m=[0,1]) mirror([0,0,m]) translate([0,0,thick/4]) cylinder(d=8,h=thick*2,$fn=40);
    }
  }
}