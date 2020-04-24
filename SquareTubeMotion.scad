//*/
tubesize=20;//25.4;
wide=80;
thick=31;
zoff=8;
c2o=0;
comp=.25;
half=0;
deep=40+tubesize;
translate([-45,20,-tubesize]) tube(2);
translate([-45,40,0]) rotate([0,0,-90]) {
  tube(2);
  translate([130,0]) {
    translate([0,0,-5]) carrier_block(0,1);
    translate([70-tubesize/2,-10,24+tubesize+2]) rotate([0,0,90]) {
      translate([55,-5,20]) {
        rotate([-90,0]) union() {
          carrier_block(0,1);
          rotate([-90,0]) counter();

        }
        
      }
      tube(2);
    }
  }
}
translate([80-10,20,-tubesize-5]) carrier_block(0,1);
translate([120-tubesize/2,50,24]) rotate([0,0,-90]) {
  translate([70,22,0]) {
        rotate([90,0]) carrier_block(0,1);
      }
  tube(2);
}
translate([80-10,20,6]) mirror([0,0,1]) carrier_block(0);
*for(x=[10,60],y=[9,56.4]) translate([x,y,-52]) bolt(3.5);
//*/
//*

module counter() {
  !rotate([90,0]) union() {
    difference() {
      translate([32,-16,-16]) rotate([-90,0]) mirror([0,1]) 
        linear_extrude(5,convexity=3) difference() { union() {
          translate([6,52]) circle(d=18,$fn=40);
          translate([30,52]) circle(d=18,$fn=40);
          hull() {
            //square([36,64]);
            translate([6,52]) circle(d=16,$fn=40);
            translate([30,52]) circle(d=16,$fn=40);
            translate([18,10+comp]) circle(d=18,$fn=50);
          }
        }
      translate([6,52]) circle(d=8,h=10,$fn=30);
      translate([30,52]) circle(d=8,h=10,$fn=30);
      translate([18,10+comp]) circle(d=8,h=10,$fn=30);
      }
    }
    translate([50,-16+5,-6+comp]) rotate([-90,0]) {
      linear_extrude(10) difference() {
        circle(d=18,$fn=50);
        circle(d=8,$fn=30);
      }
      translate([0,0,10]) hump();
      %translate([0,0,12]) bearing();
    }
   }
}
module mpcpc_style() {
xpos=245;
ypos=80;
yfeet=3;
xfeet=4;
zup=100;
{
  translate([0,0,zup-48]) tube(xfeet);
  translate([25.4,0,-25.4]) rotate([0,0,90]) tube(yfeet);
  for(x=[xpos]) {
    translate([x,-20,zup]) rotate([0,0,90]) tube(yfeet);
    translate([x-45,0,zup-48]) carrier_block();
  }
  for(y=[ypos]) {
    translate([-20,y,22.6]) {
      tube(xfeet);
      translate([45.4,-20,-47.6]) rotate([0,0,90]) carrier_block();
    }
  }
  
}
}
module cube2(dims,r=7,o=2)
{
  linear_extrude(dims[2],convexity=4) {
    translate([r-o,r-o]) square([dims[0]-r*2+o*2,dims[1]-r*2+o*2]);
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) rotate([0,0,x>r?(y>r?180:90):(y>r?270:0)]) 
        difference() { hull() {
          circle(r=r,$fn=50);
          translate([10,10]) circle(r=r,$fn=50);
          }
        }
  }
}

module carrier_block(bolts=1,bearings=1) {
  hxpos=wide>45?[wide/2-12,wide/2+12]:[10,wide-10];
  hypos=[-1,tubesize-9]; //[0,15.4];
  vxpos=wide>=60?[10,wide-10]:[wide/2];
  vypos=[-20+comp,2+tubesize-comp];
  *echo(str("diff: ", vypos[1]-vypos[0]));
  intersection() {
    union() {
      translate([10,0]) {
      difference() {
        translate([0,-20,18+zoff]) {
          translate([3,2+comp]) cube2([wide-6,deep-4-comp*2,thick-zoff],o=c2o);
        }
        translate([-.1,-2,17.9]) cube([wide+.2,4+tubesize,10]);
          for(x=hxpos,y=hypos) translate([x,y,35]) {
            rotate([-90,0]) linear_extrude(10) {
              circle(d=25,h=10,$fn=50);
              translate([-12.5,-15]) square([25,30]);
            }
            *translate([-12.5,0,-10]) cube([25,10,10]);
        }
        for(y=vypos,x=vxpos) translate([0,y,18])
          translate([x,9,-.1]) cylinder(d=8,h=thick+.2,$fn=24);
        for(x=hxpos) translate([x,-20.1,36]) rotate([-90,0]) {
          cylinder(d=8,h=66.02,$fn=24);
          cylinder(d=19,h=9.09-c2o+comp,$fn=50);
          translate([0,0,51.11+c2o-comp]) cylinder(d=19,h=8,$fn=50);
        }
        translate([wide/2,deep/2-20]) for(m=[0,1]) mirror([0,m]) translate([0,tubesize/2+6]) cylinder(d=3,h=50,$fn=20);
      }
      for(y=hypos) translate([0,y-7]) mirrory(12) for(x=hxpos) translate([x,7,36]) rotate([-90,0]) hump(1.4);
      for(y=vypos,x=vxpos) translate([x,y+9,18+zoff]) mirror([0,0,1]) hump(2);
    %translate([0,9]) for(y=vypos,x=vxpos) translate([x,y,17]) {
      if(bearings) bearing();
      if(bolts) translate([0,0,0]) bolt(2);
    }
      if(bearings)
      %for(x=hxpos,y=hypos) translate([x,y+1.4,36.4]) rotate([-90,0]) bearing();
      if(bolts)
      %for(x=hxpos) translate([x,-20,36.4]) rotate([-90,0]) bolt(2.75);
    }
  }
  if(half) {
    translate([10,tubesize/2,22]) cube([wide,deep/2,thick]);
  }
}
}
/*
//*/
module bolt(inches)
{
  cylinder(d=25.4*(5/16),h=inches*25.4,$fn=36);
  translate([0,0,-5]) cylinder(d=13,h=5,$fn=6);
}
module tube(feet=1)
{
  color(tubesize==25.4?"black":"silver") 
    if(tubesize==20)
    {
      translate([0,tubesize/2,tubesize/2]) rotate([0,90]) linear_extrude(feet*12*25.4) ex_face(tubesize,5);
    } else {
      difference() {
      cube([feet*12*25.4,tubesize,tubesize]);
      if(tubesize==25.4) translate([-.1,2,2]) cube([feet*12*25.4+.2,21.4,21.4]);
      }
  }
}
module hump(h=2) {
  difference() {
    cylinder(d1=14,d2=11,h=h,$fn=40);
    translate([0,0,-.1]) cylinder(d1=8,d2=9,h=h+.2,$fn=24);
  }
}
module bearing() {
linear_extrude(7) difference() {
  circle(d=22,h=7,$fn=40);
  circle(d=8,$fn=24);
}
}
module mirrorz(offset=0)
{
  translate([0,0,offset]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,offset*-1]) children();
}
module mirrory(offset=0)
{
  translate([0,offset,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-1,0]) children();
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}

module ex_face(size=30,type=6,r=2,sides=4)
{
  hole1s=(type==6?6.8:(type==5?4.2:(type==8?10.5:type)));
  hole2s=(type==6?3:type==8?6:5);
  difference(){
    translate([size*-.5+r,size*-.5+r]) minkowski(){
      square(size-r*2);
      circle(r=r,$fn=20);
    }
    if(type>5) for(r=[0:90:359]) rotate([0,0,r]) translate([size*.5-hole2s/2-2,size*.5-hole2s/2-2]) circle(d=hole2s,$fn=30);
    circle(d=hole1s,$fn=30);
    for(rot=sides==4?[]:(sides==3?[0]:(sides==2?[0,2]:[0]))) rotate([0,0,rot*90]) {
      if(type==8)
        translate([-15,-18]) square([30,hole2s]);
    }
    difference() {
      for(rot=[0:3]) rotate([0,0,rot*90]) {
   //translate([size*-.5+3.4,size*-.5+3.4]) circle(d=2,$fn=16);
       if(type==6)
        polygon([[-4,-15],[-4,-13],[-8.25,-13],[-8.25,-10],[-4.25,-6],[4.25,-6],[8.25,-10],[8.25,-13],[4,-13],[4,-15.01]]);
       else if(type==8)
         polygon([[-5,-20],[-5,-14.5],[-10,-14.5],[-10,-12],[-5.5,-7.5],[5.5,-7.5],[10,-12],[10,-14.5],[5,-14.5],[5,-20]]);
       else
         polygon([[-3,size*-.5],[-3,size*-.5+2],[-6,size*-.5+2],[-6,size*-.5+3],[-2,size*-.5+6],[2,size*-.5+6],[6,size*-.5+3],[6,size*-.5+2],[3,size*-.5+2],[3,size*-.5]]);
     }
 for(rot=sides==4?[]:(sides==3?[0]:(sides==2?[0,2]:[0]))) rotate([0,0,rot*90]) {
   if(type==8)
       translate([-5,-20]) square([10,5.5]);
   }
    }
  }
}
