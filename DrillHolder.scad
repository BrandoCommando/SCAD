od=60;

rotate_extrude(angle=360,$fn=100) {
          translate([od/2-2.2,0]) square([2.2,4]);
        }
intersection() {
  cylinder(d=85,h=58,$fn=100);
  difference() {
    scale([1,1]) union(){
      difference() {
        rotate([0,0,-60]) rotate_extrude(angle=300,$fn=100) {
          translate([od/2-2.2,0]) square([2.2,150]);
        }
        *translate([-17,-76,5]) cube([34,76,150]);
      }
      for(r=[240,300]) rotate([0,0,r])
      translate([od/2-1.1,0]) cylinder(d=2.2,h=150,$fn=20);
      translate([-10,od/2-3]) cube([20,4,150]);
    }
    for(z=[7,50,100,140]) translate([0,0,z]) rotate([-90,0]) cylinder(d=4,h=80,$fn=24);
  }
}