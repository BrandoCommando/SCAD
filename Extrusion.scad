linear_extrude(100) ex_face(20,5);
!translate([35,0]) linear_extrude(140) ex_face(40,8,3,3);

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