tw=110; // 58
th=58;
thick=1.01;
lido=.8;
*cube2([10,10,10],r=2,br=2);
difference(){
  cube2([tw,th,12]);
  translate([thick,thick,thick]) cube2([tw-thick*2,th-thick*2,11],r=4,br=3);
}
translate([0,0,thick]) pegs();

translate([0,th + 10]) {
  cube2([tw,th,thick]);
  *translate([thick+1,thick+1,thick]) cube2([tw-(thick*2)-2,th-(thick*2)-2,thick],r=3);
  translate([thick+lido,thick+lido,thick-.01])
    difference(){
      cube2([tw-(thick*2)-lido*2,th-(thick*2)-lido*2,thick*2+1],r=4);
      translate([thick,thick,.01]) cube2([tw-(thick*4)-lido*2,th-(thick*4)-lido*2,thick*2+1],r=3,br=2);
    }
  *translate([0,0,thick*2]) pegs(h=4);
}
module pegs(h=5) {
  nx=floor(tw/25);
  for(x=[(tw-4)/nx-10:(tw-4)/nx-5/6:tw-4],y=[16:25:th-16])
{
  //echo(str("X: ",x," Y: ",y));
  translate([x,y,0]) {
    peg(h);
    *%translate([0,0,1.2]) difference() {
      cylinder(d=22,h=5,$fn=50);
      translate([0,0,-.01]) cylinder(d=8,h=7.02,$fn=40);
    }
  }
}
}
module peg(h1)
{
  h=(h1>=5?5:-5)+h1;
  *translate([-1,0]) cube([2,4,h]);
  difference(){
    cylinder(d=10,h=1,$fn=30);
    if(h<5)
      translate([0,0,-.01]) cylinder(d=8.2,h=2,$fn=30);
  }
  if(h>=5) {
    cylinder(d=6.8,h=h,$fn=30);
    translate([0,0,(h+1)/2]) sphere(d=7.8,$fn=30);
  }
}
module cube2(dims,r=5,br=0)
{
  if(br==0)
    linear_extrude(dims[2]) {
      for(x=[r,dims[0]-r],y=[r,dims[1]-r])
        translate([x,y]) circle(r=r,$fn=30);
      translate([r,0]) square([dims[0]-r*2,dims[1]]);
      translate([0,r]) square([dims[0],dims[1]-r*2]);
    }
  else
    intersection()
    {
      cube(dims);
      minkowski()
      {
        translate([r,r,br]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-br]);
        sphere(r,$fn=26);
      }
    }
}