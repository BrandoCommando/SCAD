difference(){
  union(){
wiimote();
translate([72,22,35]) nunchuck();
translate([2,0]) mirror([1,0,0]) {
wiimote();
translate([72,22,35]) nunchuck();
}
  }
  translate([23,41,60]) rotate([-90,0]) cylinder(d1=8,d2=4,h=3,$fn=20);
  translate([-24,41,60]) rotate([-90,0]) cylinder(d1=8,d2=4,h=3,$fn=20);
}
module nunchuck()
{
  difference(){
    linear_extrude(55) scale([1.2,1]) circle(d=40);
    translate([0,0,-0.01]) linear_extrude(56) scale([1.2,1,1]) circle(d=36);
    translate([18,-8,-.01]) cube([10,16,56]);
    translate([-25,-22,-.01]) rotate([0,40]) cube(80);
  }
}
module wiimote()
{
difference(){
  box(49,44,90,r=4,top=0);
  translate([2,2,2]) box(45,40,90.1,r=3,top=0);
  translate([10,-.01,15]) cube([29,3,90]);
}
}

module box(w,h,d,r=1,top=1,bottom=1)
{
  intersection(){
    cube([w,h,d]);
    minkowski() {
      translate([r,r,bottom?r:0]) cube([w-r*2,h-r*2,d-r*((top?1:0)+(bottom?1:0))]);
      sphere(r,$fn=10+r*6);
    }
  }
}