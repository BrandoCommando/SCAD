for(n=[0:4])
{
  translate([n*5,0,4]) cube([4,14+n*20,0.6]);
  translate([n*5,0,0]) cube([4,2,4]);
  translate([n*5,12+n*20,0]) cube([4,2,4]);
  if(n<4)
  translate([n*5+4,12+n*20,0]) cube([1,22,1]);
}
cube([20,2,1]);