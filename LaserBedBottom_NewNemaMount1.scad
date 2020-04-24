tw=inches(12)+60;
th=inches(8.45)+60;
aph=(tw-th)/2;
left=(1360-(tw*2+th*2));
yoff=left;
echo(str("Left: ",left));
*!translate([0,200]) {
  for(y=[0:19:40]) translate([4,y]) {
    ring(10,5);
    for(x=[15:19:60])
      translate([x,0]) ring(18,5);
  }
}
*!rotate([0,0,-90]) union() {
  //corner();
  translate([31,0]) stretcher(th);
  stretcher(tw-15);
  translate([62,0]) stretcher(th-15);
}

translate([th/2-50,211]) mirror([0,1]) layer1();
!union() {
  translate([90,91]) rotate([0,0,180]) layer2();
  translate([0,101]) layer1(yoff=left);
  translate([90,91]) rotate([0,0,180]) layer2();
}
*!union(){
translate([90,91,5]) rotate([0,0,180]) linear_extrude(5) layer2();
translate([0,101]) mirror([0,1]) linear_extrude(5) layer1(yoff=left);
  translate([90,91,20]) rotate([0,0,180]) linear_extrude(5) layer2();
}
for(y=[0,102]) translate([0,y]) mirror([0,y>0?1:0]) apron();
translate([6,-1]) rotate([0,0,-90]) stretcher();
translate([6,-62]) mirror([0,1]) rotate([0,0,-90]) stretcher();
for(x=[50.5:41:200])
  translate([x,50.5]) difference() {
    circle(d=36,$fn=100);
    circle(d=22.2,$fn=80);
    for(r=[75:120:359]) rotate([0,0,r]) translate([14,0]) circle(d=3,$fn=20);
  }
/*
for(x=[0,th-30]) translate([x,50]) stretcher();
for(y=[0,tw]) translate([0,y]) mirror([0,y>0?1:0]) apron();
*/
module layer2(yoff=left) {
  rotate([0,0,180]) translate([-90,-90]) difference() {
    *translate([10,8]) rsquare([80,84]);
    hull() {
      mirrorx(100) translate([32,100-12]) circle(d=10,$fn=40);
      translate([10,80-(yoff-10)]) rsquare([80,40],$fn=30);
    }
    translate([50,70]) {
      circle(d=22,$fn=60);
      for(x=[-15.5,15.5],y=[-15.5,15.5])
        translate([x,y]) circle(d=3,$fn=20);
    } 
    for(y=[65,85,75]) mirrorx(100) translate([50-25,y-47]) {
        hull() {
          circle(d=3,$fn=30);
          translate([22,0]) circle(d=3,$fn=30);
        }
        translate([-6,0]) circle(d=3,$fn=20);
      }

  }
}
module corner() {
  difference() {
    union() {
      rsquare([30,30],r=11.1);
      translate([0,15]) square([30,aph]);
      translate([15,0]) square([15,30]);
      translate([30,15]) rotate([0,0,0]) dovetail();
      translate([15,15+aph]) rotate([0,0,90]) dovetail();
    }
    for(x=[15,th-15]) translate([x,15]) circle(d=22.2,$fn=50);
  }
}
module layer1(yoff=yoff) {
  union() {
    difference() {
      *translate([0,8]) rsquare([100,92]);
      hull() {
        mirrorx(100) translate([32,12]) circle(d=10,$fn=40);
        translate([0,yoff-10]) square([100,20]);
      }
      for(p=[30]) translate([50,p]) {
        if(p>30)
          difference() {
            square(41,center=true);
            square(40,center=true);
          }
        circle(d=22,$fn=60);
        
        for(x=[-15.5,15.5],y=[-15.5,15.5]) translate([x,y]) circle(d=p>30?2.5:7.2,$fn=20);
      }
      for(y=[65,85,75.01]) mirrorx(100) translate([50-25,y-3]) {
        hull() {
          translate([y!=75?-7:0,0]) circle(d=8,$fn=30);
          translate([20+(y!=75?10:0),0]) circle(d=8,$fn=30);
        }
        translate([-6,0]) circle(d=3,$fn=20);
      }

    }
    for(x=[20,50,80]) translate([x,yoff+10]) rotate([0,0,90]) dovetail(.1);
  }
}
module apron(yoff=0) {
  if(yoff!=0) translate([th/2-50,-yoff-16]) layer1(yoff);
  difference() {
    union(){
      hull() {
        rsquare([th,30],11.1);
      }
      for(x=[0,th-30])
        translate([x,15]) square([30,35]);
    }
    for(dp=[-30,0,30])
      translate([th/2+dp,-.01]) rotate([0,0,90]) dovetail();
    mirrorx(th)
    for(x=[th-16]) translate([x,16]) {
      circle(d=20,$fn=50);
      
      for(r=[75:120:359]) rotate([0,0,r]) translate([14,0]) circle(d=2.5,$fn=20);
    }
    for(x=[0,th-30]) translate([x+15,50]) rotate([0,0,270]) dovetail();
  }
  *for(x=[16,th-16]) translate([x,15]) circle(d=10,$fn=40);
}
module stretcher(sw=tw,xoff=0) {
  difference() {
  hull() {
    translate([0,0.1]) square([30,sw-100.2]);
    if(xoff!=0) translate([-xoff-10,(sw-100.2)/2-10]) square([xoff,20]);
  }
  if(xoff!=0) translate([-xoff,(sw-100.2)/2]) hull() {
    circle(d=5,$fn=30);
    translate([20,0]) circle(d=5,$fn=30);
  }
  }
  translate([15,0]) rotate([0,0,-90]) dovetail(.1); 
  translate([15,sw-100]) rotate([0,0,90]) dovetail(.1);
}
module dovetail(offset=0) {
  offset(1,$fn=20) polygon([[0,3+offset],[4+offset,6+offset],[4+offset,-6-offset],[0,-3-offset]]);
}
module rsquare(dims,r=2)
{
  for(x=[r,dims[0]-r],y=[r,dims[1]-r])
    translate([x,y]) circle(r=r);
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
}

module mirrorx(off) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off) {
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}
module ring(od,id) { difference() { circle(d=od,$fn=od*5); circle(d=id,$fn=id*5); } }
function inches(in) = 25.4*in;