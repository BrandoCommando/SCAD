*%translate([0,-25,2]) cube([17.78,43.18,6]);
*%translate([0,0,12]) top();
*minkowski() {
  linear_extrude(16) base_shape();
  sphere(d=5,$fn=20);
}
*mirror([1,0]) top();
*body();
circle9();
module circle9() {
difference() {
  rotate_extrude($fn=100) {
    translate([0,2]) square([28,2]);
    square([26,4]);
    translate([26,2]) circle(d=4,$fn=20);
  }
  translate([0,0,4]) rotate_extrude($fn=100) {
    translate([0,2]) square([23.5,11]);
    translate([0,0]) square([21.5,6]);
    translate([21.5,2]) circle(d=4,$fn=20);
  }
  translate([-15.5,-10]) for(x=[0:3],y=[0:2])
    translate([x*(2.54*4),y*(2.54*4),-.01]) button_hole(10);
}
}

module body() {
  difference() {
    union() {
      for(m=[0,1]) mirror([m,0]) translate([50,0]) rotate([0,0,-180]) rotate_extrude($fn=100) {
        square([34,14]);
        translate([34,12]) circle(d=4,$fn=20);
        translate([31,2]) square([5,10]);
        translate([34,2]) circle(d=4,$fn=20);
      }
      translate([-50,-25,14]) rotate([0,90]) {
        linear_extrude(100) {
          for(x=[2,12],y=[2,58])
          translate([x,y]) circle(d=4,$fn=20);
          translate([2,0]) square([10,60]);
          translate([0,2]) square([14,56]);
        }
      }
    }
    for(x=[-50,50]) translate([x,0,2]) {
      rotate_extrude($fn=100) {
        square([30,14]);
        translate([27,2]) square([5,14]);
        translate([30,2]) circle(d=4,$fn=20);
      }
    }
    translate([-50,-25,14.1]) rotate([0,90]) {
        linear_extrude(100) {
          for(x=[10],y=[5.1,54])
            translate([x,y]) circle(d=4,$fn=20);
          translate([0,5]) square([12.1,50]);
          translate([-2,3]) square([12.1,53]);
        }
      }
  }
}

module base_shape()
{
  translate([-50,0]) circle(d=70,$fn=100);
  translate([50,0]) circle(d=70,$fn=100);
  translate([-50,-25]) square([100,60]);
}
module top() {
  difference() {
    linear_extrude(2) base_shape();
    translate([-70,-20,-.01]) {
      *square([40,40]);
      for(x=[5:10.16:40],y=[5:10.16:40])
        translate([x,y]) button_hole(3);
    }
    translate([30,-20,-.01]) {
      for(pos=[[0,2],[2,0],[2,4],[4,2],[2,2]])
        translate([10.16*pos[0],10.16*pos[1]]) button_hole(3);
    }
  }
}
module button_hole(3d=0) {
  *circle(d=5,$fn=24);
  if(!3d)
    translate([-3.3,-3.3]) square([6.6,6.6]);
  else {
    translate([-3.1,-3.1,.3]) cube([6.2,6.2,3d]);
    cylinder(d=6,h=1,$fn=30);
  }
}
module outline(t=2)
{
  difference() {
    minkowski() {
      children();
      circle(d=t,$fn=t*10);
    }
    children();
  }
}