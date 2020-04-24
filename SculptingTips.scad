translate([-25,-5]) cube([50,10,0.5]);
translate([-28,-10,25]) mirror([0,0,1]) {
  for(x=[8:8:49]) translate([x,10,15]) cylinder(d=6,h=10,$fn=40);
difference()
{
  //cube([56,20,20]);
  translate([-17,0,1]) {
  translate([25,10,8]) rcyl(6,10);
  translate([33,10,12]) fchisel(6);
  translate([41,10,12]) cupchisel(6);
  translate([49,10,13]) taper(6,7);
  translate([57,10,12]) cupround(6,20);
  translate([65,10,12]) achisel(6);
  }
  translate([2,2,18]) cube([52,16,20]);
}
}

module cupround(d=10,h=10,$fn=40)
{
  translate([-8,0,-7]) import("CupRound_F360.stl");
  *intersection() {
    translate([0,0,-d]) cylinder(d=d,h=h+d,$fn=$fn);
    rotate([0,90]) translate([-8,d-24,-10]) cylinder(d=40,h=20,$fn=80);
  }
}
module taper(d=10,h=h,$fn=40)
{
  hull() {
  cylinder(d=d,h=h,$fn=$fn);
  translate([0,0,-h]) sphere(d=1,$fn=20);
  }
  //translate([0,0,-h]) cylinder(d1=1,d2=d,h=h,$fn=$fn);
}
module cupchisel(d=5,h=10,$fn=40)
{
  translate([0,0,.01]) translate([0,0,-7]) import("CupChisel2_F360.stl");
}

module achisel(d=5,h=10,a=30,$fn=40) {
  //translate([0,0,-d])
  hull() {
    translate([0,0,2]) cylinder(d=d,h=1,$fn=$fn);
    translate([d/-2+.5,0,-d]) {
        sphere(d=1,$fn=20);
        translate([d-1,0,h/2])
          sphere(d=1,$fn=20);
    }
  }
}
module fchisel(d=5,h=10,$fn=40) {
  //translate([0,0,-d])
  hull() {
    cylinder(d=d,h=h,$fn=$fn);
    translate([d/2,0,-d]) rotate([0,-90]) {
      //translate([0,0,0.5]) cylinder(d=1,h=d-1,$fn=20);
      for(z=[0.5,d-0.5]) translate([0,0,z]) sphere(d=1,$fn=20);
      }
  }
}
module rcyl(d,h=10,$fn=40) {
  sphere(d=d,$fn=$fn);
  cylinder(d=d,h=h,$fn=$fn);
}