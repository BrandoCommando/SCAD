include <ISOThread.scad>;
adapter(d2=44,p2=2.5,h2=10);
//*
//translate([40,0])
module adapter(d1=27.4,h1=10,p1=2,d2=44,h2=20,p2=4)
{
difference() {
  translate([0,0,.01]) cylinder(d=d1+5,h=h1-.02,$fn=60);
  iso_thread(m=d1,l=h1,p=p1);
  cylinder(d1=d1,d2=d1,h=2,$fn=d1*3);
}
translate([0,0,h1])
  difference() {
    cylinder(d1=d1+5,d2=d2+5,h=10,$fn=80);
    translate([0,0,-.01]) cylinder(d1=d1-2,d2=d2-2,h=10.02,$fn=60);
  }
translate([0,0,h1+10])
{
  difference() {
  cylinder(d=d2+5,h=h2-.02,$fn=80);
  translate([0,0,-.01]) iso_thread(m=d2,l=h2,p=p2);
    translate([0,0,h2-2]) cylinder(d2=d2,d1=d2,h=2,$fn=d2*3);
  }
}
}
//cylinder(d=39,h=40,$fn=80);
//*/
//pipe_thread();
//*/
module pipe_thread(th=2) {
difference(){
  union(){
    cylinder(d=30,h=9.89,$fn=60);
    *cylinder(d=120,h=2,$fn=400);
    *translate([0,0,2]) cylinder(d1=36,d2=30,h=2,$fn=60);
  }
  //*/
  tlh=0.3;
  mh=10;
  mr=mh;
  rx=183.33*tlh;
  translate([0,0,-.01]) for(r=[0:floor(mh/tlh)]) translate([0,0,r*tlh]) rotate([0,0,r*rx]) translate([0.6,0]) cylinder(d=25.4,h=tlh+.01,$fn=50);
}
}

