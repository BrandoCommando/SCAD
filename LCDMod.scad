*import("LCD_Bottom.stl");
*translate([-105,-105]) import("LCD_Front.stl");
translate([-55,-25.7,10])
difference() {
  translate([0,0,4]) mirror([0,0,1]) cube2([110,51.4,4],2,$fn=30,top=0);
  translate([25,0,-.01]) cube([110-50,47.4,10],$fn=30,r=2,top=0);
  for(hx=[-44,50],hy=[-20.5,20.5]) translate([110/2+hx,51.4/2+hy,-.01]) cylinder(d=3,h=20,$fn=20);
}
translate([-40,-30,10]) {
  translate([0,0]) cube([80,20,4]);
  rotate([19+90,0]) translate([0,0,-5]) difference() {
    cube2([80,20,5],r=2,top=0);
    *linear_extrude(5) hull() {
      for(x=[2.5,77.5]) translate([x,17.5]) circle(d=5,$fn=30);
      translate([0,0]) square([80,10]);
    }
    for(x=[10,70]) translate([x,12,-.01]) {
      cylinder(d=4,h=20,$fn=30);
      cylinder(d1=10,d2=4,h=3,$fn=40);
    }
  }
}

module cube2(dims,r=4,$fn=20,top=1)
{
  for(z=(top?[r,dims[2]-r]:[r])) translate([0,0,z]) for(x=[r,dims[0]-r],y=[r,dims[1]-r])
  {
    translate([x,y]) {
      sphere(r=r,$fn=$fn);
      if(z==r)
        cylinder(r=r,$fn=$fn,h=dims[2]-r-(top*r));
      if(y==r)
        rotate([-90,0]) cylinder(r=r,$fn=$fn,h=dims[1]-r*2);
      if(x==r)
        rotate([0,90]) cylinder(r=r,$fn=$fn,h=dims[0]-r*2);
    }
  }
  translate([r+.01,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]]);
  translate([0,r+.01,r]) cube([r,dims[1]-r*2,dims[2]-r-(top*r)]);
  translate([dims[0]-r-.01,r+.01,r]) cube([r,dims[1]-r*2,dims[2]-r-(top*r)]);
  translate([r+.01,0,r]) cube([dims[0]-r*2,r,dims[2]-r-(top*r)]);
  translate([r,dims[1]-r-.01,r]) cube([dims[0]-r*2,r,dims[2]-r-(top*r)]);
}