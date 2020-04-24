part="shaft"; //[bolt,shaft,catch,all]
id=11.5;
idw=id;
t=1;
t2=3;
t3=4;
tb=3;
h=36;
h2=h;
h3=16;
// Catch Offset
co=0;
// Catch Mount Hole Offset
cmho=0;
cdip=5;
so=0;
side=3; //[0:Both,1:Left,2:Right,3:Center Only]
backbump=0;
bumph=10;
bumpw=18;
bumpd=28;
centerhole=2;
$fn=50;

if(part=="shaft"||part=="all")
{
  intersection(){
  translate([-11-(side==3||side==2?.5:12),-so-idw-5,-5]) {
    cube([side==3?22:(side==0?46:34),so+idw+22,50]);
    if(side==2)
      translate([-t2,0]) cube([t2+.01,idw+22,50]);
  }
difference(){
  union(){
    color("blue")
    translate([0,-so/2+idw-11.5]) {
      //box(d=id+so+t*5,h=h,w=id+t*5,bottom=1);
      translate([0,id-2]) box(d=so,h=h,w=id+t*5,bottom=1);
      translate([0,-so+id+t2]) box(d=id+t*5+t2,h=h,w=id+t*5+t2,bottom=1);
    }
    *if(so>0)
      translate([t-1.25,-so+5,-t]) cube([10,so+5,h]);
    //translate([-1.5*id,id/2+t/2+.8,0]) cube([id*3,3,h]);
    translate([0,t]) {
      translate([0,id/2+t*2,h/2-1]) rotate([90,0,0])
        box(w=id*4,d=h+2,h=4,top=1,r=1);
      if(side<1) translate([-1*id-3,id-10,2]) difference(){
        union(){
        cube([4,4,h-2]);
        translate([4,2,0]) sphere(2,center=true);
        }
        translate([0,0,-2.01])
          cylinder(r=4,h=h+8.02);
      }
      if(side==0||side==2) mirror([1,0,0]) translate([-1*id-3,id-10.5,2]) difference(){
        union(){
        cube([4,4,h-2]);
         translate([4,4,0]) sphere(r=2,center=true);
          *rotate([0,-45,0]) cube(4,center=true);
        }
        translate([0,0,-2.01])
          cylinder(r=4,h=h+8.02);
      }
    }
  }
  translate([0,-so,t]) box(d=id+t*3+.8,h=h,r=1);
  for(m=[0,1]) mirror([m,0,0])
  rotate([0,0,90]) translate([-so,id*-.6,18]) rotate([90,0,0]) box(d=h*.55,w=5,h=t*3,r=2.45);
  for(pos=[[id+6,id+t/2,5],
        [-1*id-6,id+t/2,5],
        [id+6,id+t*.5,h-7],
        [-1*id-6,id+t*.5,h-5],
        [0,id+t+.5,h-7],
        [0,id+t+.5,7]
        ])
      if(pos[0]!=0||centerhole==2||(centerhole==1&&pos[2]<8))
    translate(pos) rotate([90,0,0]) union() { cylinder(d=4,h=10); translate([0,0,4]) cylinder(d1=4,d2=9,h=2.01);
        translate([0,0,6]) cylinder(d=9,h=pos[0]==0?so+50:so-t2*2);
     }
}
}
} 
if(part=="bolt"||part=="all") {
  translate(part=="all"?[0,-so-6,50]:[]) rotate(part=="all"?[90,0]:[])
  rotate([0,90]) rotate([135,0,0])
  difference()
  {
    translate([6,h2*.6,h2*.6]) rotate([45+90,0,0])
    {
      difference()
      {
          box(w=idw+t+tb+.8,d=id+t+tb+.8,h=h2);
          translate([-20,0,10]) rotate([90,0,90]) cylinder(d=3,h=30,$fn=30);
          cylinder(d=12.6,h=2,$fn=50);
      }
    }
    translate([0,0,-54]) rotate([-10,0]) cube(100,center=true);
  }
}
if(part=="catch"||part=="all") {
  intersection(){
    translate([-29.25+(side==2?17.5:-2),-idw/2-co-10]) cube([43+(side==0?20:0),idw+co+20,24+bumph]);
  //translate([id*6,0,h3]) mirror([0,0,0]) 
  //translate([0,0,h+5])
  {
//        translate([-.5*(id+t*5),-.5*(h3+t*5),0]) cube([id+t*5,h3+t*5,0.1]);
    difference()
    {
      union(){
        //color("blue")
        translate([0,-co/2-t3/2,1.5]) box(d=idw+t*5+t3/2+co,h=h3-cdip+.5,w=id+t*6,top=0,bottom=1,r=4);
        if(backbump){
          intersection() {
            translate([0,-co-idw/2-t*2.5,-2.5]) box(d=bumpd+t*4,h=h3-cdip+bumph,w=bumpw,top=1,bottom=1,r=4,center=0);
            translate([id-t+1,-co*1.5,0]) {
              cube([bumpw/2,bumpd+10,bumph+h3-cdip+6]);
              translate([-4,0]) cube([5,idw*2,h3-cdip+2]);
            }
          }
        }
        //translate([id*-1.5,id/2+t-.8]) cube([id*3,3,h3]);
        translate([0,idw/2+t*3-.2,h3/2+1]) rotate([90,0,0]) box(w=id+cmho*2+t*14,d=h3+2,h=5,top=1,r=1);
        for(m=[0,1]) mirror([m,0])
        translate([-1*id-t-1.5,idw/2-3.5,0]) difference(){
          union(){
          cube([4,5,h3-cdip+2]);
          *translate([4,2,h3-cdip-2]) sphere(2,center=true);
          }
          for(m=[0,1])
          mirror([0,0,m]) translate([1,3,m==0?-5:-7-h3+cdip]) rotate([45,0,-45]) translate([-2,0]) cube([8,5,8]);
          translate([-1.2,0,-0.01])
            cylinder(r=4,h=h3+cdip+4.02);
        }
      if(cdip>2)
        translate([idw/-2-t*3,3.2,h3-cdip+5]) rotate([0,90,0]) difference() {
          translate([0,0]) cube([6,6,idw+t*6]);
          translate([0,0,-.01]) cylinder(d=6,h=idw+t*6+.02,$fn=40);
        }
      }
      translate([0,-co+t/4+1,2]) box(d=idw+t*4+t3+.8,h=h3+2.02,w=id+t*3+.8,r=1.5,bottom=1);
      //holes:
      cht=[15,-15];
      if(centerhole)
        translate([0,14,h3/2+1]) rotate([90,0]) {
          linear_extrude(35) circle(d=4,$fn=30);
          *translate([0,0,2.49]) linear_extrude(3) hull() {
            circle(d=4,$fn=30); translate(cht) circle(d=8,$fn=30); }
        }
      translate([0,0,1]) {
        for(x=[-1*id-cmho,id+cmho])
      translate([x,idw+1,h3/2]) rotate([90,0,0]) union() { cylinder(d=4,h=10); translate([0,0,4]) cylinder(d1=4,d2=9,h=2); translate([0,0,5.99]) cylinder(d=9,h=20); }
    }
    }
  }
  }
}

module box(d,h,w=0,r=2,top=0,bottom=0,center=1)
{
  translate(center?[]:[w/2,d/2,r])
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