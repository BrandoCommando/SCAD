difference(){
  cube2([40,11,3]);
  for(x=[5,35]) translate([x,4,-.01]) linear_extrude(3.02) {
    circle(d=4,$fn=24);
    translate([-2,0]) square([4,3]);
    translate([0,3]) circle(d=4,$fn=24);
  }
}
translate([10,0,2.5]) difference() {
  cube2([20,10.5,9]);
  translate([-.01,10,8.5]) rotate([0,90]) {
    cylinder(d=16,h=20.02,$fn=50);
    cylinder(d1=18,d2=16,h=1,$fn=50);
    translate([0,0,19.02]) cylinder(d1=16,d2=18,h=1,$fn=50);
  }
}

module cube2(dims,r=0.5,bottom=0,top=1) {
  intersection(){
    cube([dims[0],dims[1],dims[2]]);
    minkowski() {
    translate([r,r,bottom?r:0])
      cube([dims[0]-r*2,dims[1]-r*2,dims[2]-(bottom?r:0)-(top?r:0)]);
      sphere(r=r,$fn=30);
    }
  }
}