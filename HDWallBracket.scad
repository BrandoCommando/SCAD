dims=[83,50,22];
//minkowski() {
rotate([90,0])
{
linear_extrude(dims[2]+3)
difference() {
  offset(2) square([dims[0],dims[1]]);
  square([dims[0],dims[1]+2]);
}
linear_extrude(2) offset(2) square([dims[0],dims[1]]);
translate([0,0,dims[2]+3]) mirror([0,0,1]) difference() {
  translate([dims[0]/2,0]) for(m=[0,1]) mirror([m,0]) translate([dims[0]/-2,0]) translate([-22,-2]) {
    translate([2,0]) cube([20.02,dims[1]+2,4]);
    translate([2,0,2]) rotate([-90,0]) cylinder(d=4,h=dims[1]+2,$fn=30);
  }
  for(x=[-22,dims[0]+1.99],y=[0,dims[1]-20])
    translate([x,y]) {
      translate([10,10,-.01]) cylinder(d=6,h=4.02,$fn=30);
      translate([10,10,2]) cylinder(d1=6,d2=14,h=2.02,$fn=40);
    }
  }
}