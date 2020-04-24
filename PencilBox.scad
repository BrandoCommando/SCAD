mw=180;
mh=120;
md=50;
wt=2;
lw=mw+wt*4;
lh=mh+wt*4;
ld=20;
//translate([wt*-2,wt*-2,md+wt]) mirror([0,0,1])
lid();
*base();
module lid() {
difference() {
  intersection(){
    cube([lw,lh,ld]);
    rounded_cube([lw,lh,ld+5],rsides=5,rvert=5);
  }
  translate([wt,wt,wt]) rounded_cube([lw-wt*2,lh-wt*2,ld+5],rsides=4,rvert=4);
  translate([wt*2,wt*2,-30]) knobs(0);
  intersection(){
    translate([10,10,-.01]) cube([lw-20,lh-20,wt*2+.02]);
    translate([5,-152]) rotate([0,0,45]) for(x=[0:10:mw*2],y=[0:10:mh*2])
      translate([x,y,-.01]) cube(7);
  }
}
}
module base() {
difference() {
//minkowski(){
  intersection(){
    cube([mw,mh,md]);
    rounded_cube([mw,mh,md+5],rsides=5,rvert=5);
  }
  translate([wt,wt,wt]) rounded_cube([mw-wt*2,mh-wt*2,md],rsides=4,rvert=4);
}

translate([wt,mh/2-wt/2,wt]) cube([mw-wt*2,wt,md-10]);
  knobs();
}
module knobs(half=1) {
for(x=[1:mw-2:mw],y=[10:mh-20:mh])
{
  translate([x,y,md-7]) {
    difference(){
      sphere(d=half?8:10,$fn=20);
      if(half)
      translate([x==1?-10:0,0])
        translate([-5,-5,-5]) cube([5,10,10]);
    }
  }
}
}

module rounded_rect(w,h,r) {
  translate([r,r]) circle(d=r*2,$fn=30);
  translate([r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,r]) circle(d=r*2,$fn=30);
  translate([r,0]) square([w-r*2,h]);
  translate([0,r]) square([r,h-r*2]);
  translate([w-r,r]) square([r,h-r*2]);
}
module rounded_cube(dims,rsides=2,rvert=0)
{
  w=dims[0];
  h=dims[1];
  d=dims[2];
  if(rvert==0)
  {
    linear_extrude(d) rounded_rect(w,h,rsides);
  } else {
    translate([rsides,rsides,rvert]) scale([1,1,rvert/rsides]) minkowski() {
      cube([w-rsides*2,h-rsides*2,(d-rvert*2)/(rvert/rsides)]);
      sphere(rsides,$fn=30);
    }
  }
}