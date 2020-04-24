translate([0,0,18]) difference(){
  union(){
    cylinder(d=21.6,h=5.4,$fn=50);
      translate([0,0,4.5]) rotate_extrude($fn=80){
        translate([10.5,0]) circle(d=1.8,$fn=50);
      }
  }
  translate([0,0,-.01]) cylinder(d=19,h=10.02,$fn=40);
  for(r=[0:360/9:360]) rotate([0,0,r]) translate([0,-1]) cube([30,2,6]);

}
ring(28,24.3,10);
translate([0,0,10]) ring2(28,28,24.3,19,8);
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