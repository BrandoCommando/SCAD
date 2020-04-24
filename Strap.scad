intersection(){
    translate([-40,-30]) cube([52,30,30]);
strap(pd=22,mount=2,type=1,offset=8,h=12);
}
*for(x=[0:4])
{
  translate([32*x,(x<=2?x:4-x)*-20]) {
    strap(mount=(x==0||x==4?1:0),t=2,type=1,offset=2,h=20);
    if(x>0&&x<4)
      translate([-19,(x<=2?x:4-x)*-2]) cube([38,(x<=2?x:4-x)*22,20]);
  }
}
module strap(pd=25,t=2,h=30,type=1,mount=1,offset=4)
{
translate([-40,0]) rotate([90,0]) intersection(){
  cube([80,h,pd+offset+(type==0?2:4)]);
  difference(){
    union(){
      translate([40,0,pd/2+offset+(type==1?2:0)]) rotate([-90,0])
        cylinder(d=pd+t,h=h,$fn=50);
      cube([80,h,pd/2+(type==1?2:0)+offset-.01]);
    }
    translate([40,-.01,pd/2+offset+(type==1?2:0)]) rotate([-90,0]) 
        cylinder(d=pd,h=h+.02,$fn=50);
    translate([40,0]) for(m=[0,1]) mirror([m,0]) translate([-40,0])
      translate([-.01,h+1,2]) rotate([90,0]) linear_extrude(31.02) {
        translate([0,4]) square([40-t/2-pd/2,pd/2+offset]);
        translate([40-t/2-pd/2-4,4]) circle(d=8,$fn=40);
        square([35-pd/2,4]);
      }
    if(type!=0||mount==0) translate([44-pd/2,-.01,(type==0?-.01:offset+pd/2+4)]) cube([pd-8,30.02,pd/2]);
    if(mount==2) {
      translate([40/2-(pd+2)/4,h/2,-.01]) cylinder(d=4,h=2.02,$fn=20);
      translate([60+(pd+2)/4,h/2,-.01]) cylinder(d=4,h=2.02,$fn=20);
    } else if(mount==1) {
      for(ho=[h/2])//h/4,h*3/4])
      translate([40,ho,-.01]) {
        cylinder(d=4,h=offset+4,$fn=20);
        translate([0,0,offset-1]) cylinder(d1=4,d2=8,h=2.01,$fn=40);
        translate([-4,-4,offset+1]) cube([8,8,2]);
      }
    }
  translate([40,0]) for(m=[0,1]) mirror([m,0]) translate([-40,0]) difference(){
    translate([-.01,-.01,-.01]) cube([30.02,h+.02,3.02]);
    if(mount==2||mount==3) {
      translate([15,h/2,-.01]) cylinder(d=30,h=3.02,$fn=80);
      translate([15,-.01,-.01]) cube([40-pd/2,30.02,3.02]);
    } else
      translate([40-pd/2-4,-.01,-.01]) cube([pd/2,30.02,3.02]);
  }
}
}
}