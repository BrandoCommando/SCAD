rotate([90,0]) difference(){
  cube([80,6,10]);
  for(x=[0:3])
  {
    translate([5+25*x,-.01,5])
      cube([25.4*.8,20.02,99]);
    if(x>0&&x<3)
      translate([2+25*x,-.01,5])
      cube([1,20.02,99]);
  }
}