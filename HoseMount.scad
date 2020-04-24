id=25.4*1.9;
t=6;
h=20;
$fn=80;

difference(){
  union(){
    cylinder(d=id+t,h=10);
    translate([-20,-30]) cube([40,20,h]);
  }
  translate([0,0,-.01]) cylinder(d=id,h=h+0.02);
  translate([-20,0,-0.01]) cube([40,50,h+0.02]);
  translate([-10,0,h/3]) rotate([90,0,0]) cylinder(d=3,h=50);
  translate([10,0,h/3]) rotate([90,0,0]) cylinder(d=3,h=50);
  translate([-10,0,h/3]) rotate([90,0,0]) cylinder(d=8,h=26);
  translate([10,0,h/3]) rotate([90,0,0]) cylinder(d=8,h=26);
  translate([0,0,h*2/3]) rotate([90,0,0]) cylinder(d=8,h=26);
  translate([0,0,h*2/3]) rotate([90,0,0]) cylinder(d=3,h=32);
}
difference(){
translate([-20,id*.33]) cylinder(d=t*.75,h=10);
translate([-20-t,17.9-t*.5,-0.01]) cube([t,t,10.02]);
}
difference(){
translate([20,id*.33]) cylinder(d=t*.75,h=10);
translate([20,17.9-t*.5,-0.01]) cube([t,t,10.02]);
}