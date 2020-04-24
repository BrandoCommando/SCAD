//rotate([0,45,0])
intersection(){
  translate([-18,-20])
    cube([36,40,50]);
  union(){
difference(){
  translate([-18,-20,0.01])
    cube([36,40,4]);
  translate([-12,-12]) cube([24,24,50]);
  translate([0,-14.5]) cylinder(d=2.5,h=50,$fn=20);
  translate([0,14.5]) cylinder(d=2.5,h=50,$fn=20);
}
difference(){union(){
  translate([-18,-20,4]) difference(){
    cube([2,40,40]);
    *translate([-.01,13,5]) {
      rotate([0,90,0]) cylinder(d=6,h=4.02,$fn=30);
      translate([0,8,0]) rotate([0,90]) cylinder(d=6,h=4.02,$fn=30);
    }
  }
  translate([16,-20,4]) cube([2,40,40]);
  translate([-18,-20,4]) cube([36,2,40]);
  translate([-18,18,4]) cube([36,2,40]);
  *translate([-21.99,2.01,29]) rotate([30,0]) translate([-20,-30,0]) cube(78);
  }
  translate([-22,2,30]) rotate([30,0]) translate([-20,-30,0]) cube(80);
}
}
}