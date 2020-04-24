linear_extrude(20) {
offset(5) //minkowski()
{
//  circle(r=5,$fn=20);
  for(m=[0,1]) translate([0,0]) mirror([m,0]) translate([-30,0]) difference(){
  square([100,180]);
  translate([80,20]) rotate([0,0,15]) minkowski() {
    union() {
    square([100,180]);
      translate([0,-5]) square([10,10]);
    }
    circle(r=10,$fn=20);
  }
  //translate([-1,20]) rotate([0,0,5]) //minkowski()
  {
    square([30,190]);
    //circle(r=10,$fn=40);
  }
  }
}
}