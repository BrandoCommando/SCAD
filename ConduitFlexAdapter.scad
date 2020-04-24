
ring(28,24.3,10);
translate([0,0,10]) ring2(28,28,24.3,15,8);
translate([0,0,18]) difference(){
  union(){
  cylinder(d=17,h=20,$fn=50);
    for(z=[4,12],m=[0,1])
    rotate([0,0,m*180]) translate([0,0,z+m*4]) rotate([10,0]) rotate([0,0,-45]) rotate_extrude(angle=90,$fn=50) {
      translate([7.8,0]) scale([2,1.5]) circle(d=2,$fn=30);
    }
  }
  translate([0,0,-.01]) cylinder(d=15,h=20.02,$fn=50);
}

module ring(od,id,h) {
difference(){
  cylinder(d=od,h=h,$fn=60);
  translate([0,0,-.01]) cylinder(d=id,h=h+.02,$fn=50);
}
}
module ring2(od1,od2,id1,id2,h) {
difference(){
  cylinder(d1=od1,d2=od2,h=h,$fn=60);
  translate([0,0,-.01]) cylinder(d1=id1,d2=id2,h=h+.02,$fn=50);
}
}