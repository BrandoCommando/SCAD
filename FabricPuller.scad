part="3d";
od=4;
holed=1.5;

if(part=="2d")
{
  difference() {
    hull() {
      translate([-75,0]) circle(d=4,$fn=30);
      translate([75,0]) circle(d=4,$fn=30);
    }
    for(m=[0,1]) mirror([m,0]) translate([-75,0]) hull() {
      circle(d=2,$fn=20);
      translate([10,0]) circle(d=2,$fn=20);
    }
  }
} else {
difference() {
intersection(){
  translate([-100,-100]) cube([250,200,od-1.5]);
  union(){
translate([-50,0,od/2-1]) {
rotate([0,90]) {
  cylinder(d=od,h=150,$fn=40);
  *translate([0,0,-20]) cylinder(d1=2,d2=6,h=20,$fn=30);
}
*translate([40,0]) sphere(d=7,$fn=40);
*translate([90,0]) sphere(d=7,$fn=40);
translate([150,0]) sphere(d=od,$fn=40);
sphere(d=od,$fn=40);
}
*linear_extrude(3,convexity=3) {
translate([-50,-3]) difference() {
  square([10,6]);
  translate([1,1]) square([3,4]);
  *translate([6,.8]) square([3,4.4]);
}
translate([-40,0]) polygon([[0,-3],[0,3],[40,2],[40,-2]]);
}
}
}
  for(x=[-10,40,90]) translate([x,0,od/2-1]) rotate([0,90]) rotate_extrude() { translate([od-1,0]) circle(d=3,$fn=20); }
  translate([-50,0,-2]) linear_extrude(8) {
    //cube([8,3,8]);
    hull() {
      circle(d=holed,$fn=20);
      translate([8,0]) circle(d=holed,$fn=20);
    }
  }
}
}