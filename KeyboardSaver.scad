boff=1;
intersection() {
  translate([0,boff]) cube([140,24,20]);
  union(){
linear_extrude(4) {
  intersection() {
  square([138,24]);
  translate([12,12]) rotate([0,0,-7]) offset(4) keyboard_profile();
  }
}
translate([12,12,4]) rotate([0,0,-7]) {
  //linear_extrude(4) keyboard_profile();
 intersection() {
   union(){
     translate([-12,-12]) cube([12,24,4]);
     translate([0,6]) cube([130,10,4]);
   }
linear_extrude(4,convexity=10) difference() {
  minkowski() {
    keyboard_profile();
    circle(d=4,$fn=20);
  }
  keyboard_profile();
}
}
}
}
}
  translate([19,boff]) cube([110,7,4]);
  translate([19,boff]) cube([40,11,4]);
for(x=[30,50]) translate([x,boff,4]) {
  *translate([0,0,-4]) cube([8,4,8]);
  difference(){
    cube([12,7,4]);
    translate([-.01,7,4]) rotate([0,90]) cylinder(d=8,h=13,$fn=40);
  }
  difference() {
    cube([12,3,16]);
    translate([6,-.01,10]) rotate([-90,0]) cylinder(d=4,h=3.02,$fn=24);
  }
}
/*
difference() {
  union(){
    square([140,10]);
    square([30,24]);
  }
  translate([12,12]) rotate([0,0,-7]) 
    keyboard_profile();
//*
}
//*/

module keyboard_profile()
{
  //translate([10,10])
  {
    circle(d=18.6,$fn=40);
    translate([4.65,0]) square([4.65,9.3]);
    translate([9.3,2.65])
      difference() {
        square([2.4,2.4]);
        translate([2.4,0]) circle(r=2.4,$fn=30);
      }
    translate([0,5]) square([123,4.3]);
  }
}