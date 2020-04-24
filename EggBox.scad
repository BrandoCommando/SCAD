cols=4;
rows=3;
space=4;
od1=48;
id1=36;
th=40;
difference(){
  cube2([(od1+space)*rows+4,(od1+space)*cols+4,th]);
  for(x=[0:rows-1],y=[0:cols-1])
    translate([4+od1/2+x*(od1+space),4+od1/2+y*(od1+space),-.11]) cylinder(d1=od1,d2=id1,h=8.22,$fn=40);
  translate([2,2,7.98])
    cube2([(od1+space)*rows,(od1+space)*cols,th-7.96],r=3);
  if(th>20)
  translate([0,0,th-3]) cube2([4+(od1+space)*rows,4+(od1+space)*cols,6],r=3);
}
/*
cube([205,2,20]);
translate([0,88,5]) cube([205,2,20]);
cube([2,90,0]);
translate([203,0]) cube([2,90,20]);
translate([0,5,16]) rotate([0,90,0]) rotate([0,0,270]) linear_extrude(205) scale([.8,2])
difference(){
  square(4,4);
  circle(d=8,$fn=30);
}
translate([0,85,16]) rotate([0,90,0]) rotate([0,0,0]) linear_extrude(205) scale([2,.8])
difference(){
  square(4,4);
  circle(d=8,$fn=30);
}
translate([200,0,16]) rotate([0,0,90]) rotate([0,90,0]) rotate([0,0,270]) linear_extrude(90) scale([.8,2])
difference(){
  square(4,4);
  circle(d=8,$fn=30);
}
translate([5,0,16]) rotate([0,0,90]) rotate([0,90,0]) rotate([0,0,0]) linear_extrude(90) scale([2,.8])
difference(){
  square(4,4);
  circle(d=8,$fn=30);
}
*/

module cube2(dims,r=5,bottom=1,top=0)
{
  intersection(){
    cube(dims);
    minkowski(){
      translate([r,r,bottom?r:0])
        cube([dims[0]-r*2,dims[1]-r*2,dims[2]-(bottom?r:0)-(top?r:0)]);
      sphere(r=r,$fn=20);
    }
  }
}