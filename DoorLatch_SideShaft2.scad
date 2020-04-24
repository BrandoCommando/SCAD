part="catch"; //[bolt,shaft,catch,all]
id=11.5;
idw=id-.5;
t=2;
h=34;
h2=h;
h3=10;
$fn=50;

if(part=="shaft"||part=="all")
{
  intersection(){
  translate([-11,-11,-5]) cube([22,30,50]);
difference(){
  union(){
    color("blue")
    translate([0,-1]) box(d=id+t*3+.8*2,h=h,w=id+t*4+.8*2,bottom=1);
    //translate([-1.5*id,id/2+t/2+.8,0]) cube([id*3,3,h]);
    translate([0,id/2+t*2,h/2-1]) rotate([90,0,0]) box(w=id*4,d=h+2,h=2,top=1,r=1);
      translate([-1*id-3,id-8,2]) difference(){
        union(){
        cube([4,4,h-2]);
        translate([4,2,0]) sphere(2,center=true);
        }
        translate([0,0,-2.01])
          cylinder(r=4,h=h+8.02);
      }
      mirror([1,0,0]) translate([-1*id-3,id-8,2]) difference(){
        union(){
        cube([4,4,h-2]);
        translate([4,2,0]) sphere(2,center=true);
        }
        translate([0,0,-2.01])
          cylinder(r=4,h=h+8.02);
      }
  }
  for(m=[0,1])
  mirror([m,0,0])
  rotate([0,0,90]) translate([0,id*-.6,18]) rotate([90,0,0]) box(d=h*.55,w=5,h=t*3,r=2.45);
  translate([0,0,t]) box(d=id+t+.8*2,h=h,r=1);
  for(pos=[[id+6,id+t/2,5],
        [-1*id-6,id+t/2,5],
        [id+6,id+t*.5,h-5],
        [-1*id-6,id+t*.5,h-5],
        [0,id+t/2,h-7],
        [0,id+t/2,7]
        ])
    translate(pos) rotate([90,0,0]) union() { cylinder(d=4,h=10); 
      translate([0,0,4]) cylinder(d1=4,d2=8,h=2);
        translate([0,0,6]) cylinder(d=8,h=20);
     }
}
}
}
if(part=="bolt"||part=="all") {
  rotate([0,90]) rotate([135,0,0]) difference()
  {
    translate([6,h2*.6,h2*.6]) rotate([45+90,0,0])
    {
      difference()
      {
          box(w=idw+t+.8,d=id+t+.8,h=h2);
          translate([-20,0,10]) rotate([90,0,90]) cylinder(d=3,h=30,$fn=30);
          cylinder(d=12.6,h=2,$fn=50);
      }
    }
    translate([0,0,-53]) cube(100,center=true);
  }
}
if(part=="catch"||part=="all") {
  translate([id*6,0,h3]) mirror([0,0,0]) 
  //translate([0,0,h+5])
  {
//        translate([-.5*(id+t*5),-.5*(h3+t*5),0]) cube([id+t*5,h3+t*5,0.1]);
    difference()
    {
      union(){
        color("blue")
        translate([0,0,1.5]) box(d=id+t*2+2,h=h3+.5,w=id+t*5,top=0,bottom=1,r=1.5);
        //translate([id*-1.5,id/2+t-.8]) cube([id*3,3,h3]);
        translate([0,id/2+t*2,h3/2+1]) rotate([90,0,0]) box(w=id*4,d=h3+2,h=2,top=1,r=1);
        translate([-1*id-t-1,id-8,1]) difference(){
          union(){
          cube([4,4,h3-2]);
          translate([4,2,h3-2]) sphere(2,center=true);
          }
          translate([0,0,-0.01])
            cylinder(r=4,h=h3+4.02);
        }
        mirror([1,0,0])
        translate([-1*id-2.75,id-8,1]) difference(){
          union(){
          cube([4,4,h3-2]);
          translate([4,2,h3-2]) sphere(2,center=true);
          }
          translate([0,0,-0.01])
            cylinder(r=4,h=h3+4.02);
        }
      }
      translate([0,0,2.5]) box(d=id+t+.8,h=h3+.02,w=id+t*3+.8,r=1.5,bottom=1);
      //holes:
      translate([0,0,1]) {
      translate([-1*id-6,12,h3/2]) rotate([90,0,0]) union() { cylinder(d=4,h=10); translate([0,0,4]) cylinder(d1=4,d2=8,h=2); }
      translate([id+6,12,h3/2]) rotate([90,0,0]) union() { cylinder(d=4,h=10); translate([0,0,4]) cylinder(d1=4,d2=8,h=2); }
    }
  }
}
}

module box(d,h,w=0,r=2,top=0,bottom=0)
{
  translate([(w==0?d:w)*-.5,d*-.5])
    intersection(){
      translate([0,0,bottom?-1*r:0]) cube([w==0?d:w,d,h+(top?r:0)+(bottom?r:0)]);
    minkowski() {
      sphere(r=r,h=1);
      translate([r,r]) cube([(w==0?d:w)-r*2,d-r*2,h]);
    }
  }
  //cylinder(d=d,h=h);
}
