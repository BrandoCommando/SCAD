id=32;
t=1.2;
cylh=20;
num=3;
*!difference(){
  cylinder(d=id+t*2,h=10,$fn=60);
  translate([0,0,-.01]) cylinder(d=id,h=30,$fn=50);
}
translate([((num-1)*38)/2-(60/2),33,0]) rotate([-90,0]) mirror([0,1]) difference() {
  cube([60,3,50]);
  translate([20,-.01,-.01]) cube([20,3.02,18]);
  translate([60/2-50.8/2,0]) for(x=[0:2])
    translate([x*25.4,-.01,45]) rotate([-90,0]) cylinder(d=4,h=5,$fn=20);
}
difference(){
  union() {
    translate([((num-1)*38)/2-(60/2),0]) {
      cube([60,29.6,20]);
      cube([60,33.01,0.3]);
      translate([21,29,0]) cube([18,9,8]);
      translate([28,38,0]) intersection() {
        cube([4,6,4]);
        translate([2,0,1]) rotate([-90,0]) cylinder(d=5,h=6,$fn=20);
      }
    }
    translate([0,-2]) cube([(num-1)*38,4,20]);
    for(x=[0:num-1]) translate([x*38,0]) 
      cylinder(d=id+t*2,h=cylh,$fn=60);
  }
  for(x=[0:num-1]) translate([x*38,0]) 
    translate([0,0,t]) cylinder(d=id,h=cylh,$fn=50);
}