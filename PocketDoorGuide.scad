intersection() {
  translate([-5,-5,3]) cube([80,60,50]);
minkowski()
  //union()
  {
  hardsides();
  sphere(r=3,$fn=20);
}
}
*translate([inch(2.75)/2-inch(1.5)/2,0]) cube([inch(1.5),inch(10),inch(10)]);
module hardsides() {
difference() {
  cube([inch(2.75)-4,inch(.5),inch(1)]);
  translate([inch(2.75)/2-inch(1.75)/2-2.5,-.1,3]) cube([inch(1.75)+1,inch(.5)+.2,inch(2)]);
  translate([inch(2.75)/2-2,0]) for(m=[0,1]) mirror([m,0]) translate([-.5*inch(2.75),0])
    translate([9,-.1,3]) rotate([0,0,-20]) cube([10,60,40]);
}
}
/*translate([-4,-14,-4]) cube([28,48,4]);
minkowski()
{
difference() {
  cube([20,20,50]);
  translate([0,10]) for(m=[0,1]) mirror([0,m]) translate([0,-10])
  translate([18,-.1,-.1]) rotate([0,0,70]) mirror([0,0]) mirror([1,0]) cube([50,50,50]);
  translate([-.1,-.1,35]) rotate([0,-40]) cube(50);
  translate([20,-.1,10]) rotate([0,-10]) cube(50);
}
  sphere(4,$fn=20);
}*/
function inch(num) = num * 25.4;