//90,136,120;
difference() {
  translate([0,0,-15]) scale(1.1) crucible();
  scale(1.095) crucible();
  translate([0,0,-16]) cylinder(d=120,h=12,$fn=100);
}
translate([0,0,-4]) for(r=[0,180]) rotate([0,0,r]) linear_extrude(154,twist=180,scale=[1.3,1.3],$fn=100) translate([55,0]) scale([1,1.25]) circle(d=12,$fn=40);
! rotate([180,0]) difference() {
    *translate([-64,-8,-20]) cube([128,16,14]);
translate([55,0,-10]) {
  sphere(d=12,$fn=30);
  translate([-110,-6]) cube([110,12,6]);
  scale([1,1.25,1]) cylinder(d1=10,d2=12,h=6,$fn=50);
  rotate([0,-90]) cylinder(d=12,h=110,$fn=30);
  translate([-110,0]) {
    sphere(d=12,$fn=30);
  scale([1,1.25,1]) cylinder(d1=10,d2=12,h=6,$fn=50);
  }
}
  for(x=[-55,55]) translate([x,0,-20]) cylinder(d=3,h=20,$fn=20);
}

module crucible() {
  hull() {
cylinder(d1=90,d2=100,h=20,$fn=100);
translate([0,0,20]) cylinder(d1=100,d2=110,h=30,$fn=100);
translate([0,0,50]) cylinder(d1=110,d2=120,h=50,$fn=100);
translate([0,0,100]) cylinder(d=120,h=50,$fn=100);
  }
}