
*import("Massage_Roller/files/roller_balls_f608zz.stl");
difference(){
  union(){
    th=360/8;
    cylinder(d=40,h=38,$fn=80);
    for(r=[0:th:359],z=[5,24]) {
      rotate([0,0,r]) translate([17.5,0,z]) sphere(d=10,$fn=30);
      rotate([0,0,r+th/2]) translate([17.5,0,z+9]) sphere(d=10,$fn=30);
    }
  }
  translate([0,0,-.01]) cylinder(d=10,h=40,$fn=30);
  translate([0,0,-.01]) cylinder(d=22.8,h=8,$fn=40);
  translate([0,0,7.98]) cylinder(d1=22.8,d2=10,h=14,$fn=40);
  translate([0,0,30]) cylinder(d=22.8,h=8.02,$fn=40);
}