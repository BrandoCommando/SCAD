*translate([0,0,9]) import("arduino_uno_bottom.stl");
rotate([180,0])
difference(){ 
  translate([-12,62]) rotate([180,0,0]) import("Raspberry_Pi_3_Pi_2_and_Model_B+_case_with_VESA_mounts_and_more/files/rpi2-top_netfabb.stl");
  translate([0,0,-10]) dohole() cylinder(d=2,h=20,$fn=20);
}
*union(){
difference(){
  translate([-2.5,-4]) cube2([74.08,61.34,30],r=3);
  translate([-.5,-2,2]) cube2([70.08,57.34,30.02],r=2);
  translate([0,0,-.01]) dohole() cylinder(d=2,h=20.02,$fn=20);
  translate([-2.51,2.2,7]) cube([2.02,10.4,30]);
  translate([-2.51,31.5,7]) cube([20.02,13,30]);
  translate([69.57,14,12]) cube([2.02,18,20]);
}
dohole() hole();
}

module cube2(dims,r=5,top=0)
{
  intersection(){
    cube(dims);
    minkowski(){
      translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r-(top?r:0)]);
      sphere(r=r,$fn=30);
    }
  }
}

module hole() {
  difference(){
    cylinder(d=5,h=5.5,$fn=30);
    translate([0,0,-.01]) cylinder(d=2,h=20.02,$fn=20);
  }
}
module dohole() {
  translate([13.95,2.5]) for(pos=[[0,0],[1.3,48.3],[52.1,5.12],[52.1,33]])
    translate(pos) children(0);
}