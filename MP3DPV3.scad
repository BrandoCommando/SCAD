part="preview";
screwd=2.8;
plate_thick=5.4;
yclip_extra=10; // compensate for shorter Y rods
fingers=20;
xfingers=12;
main_bottom=30;
bottom_fingers=22;
bottom_thick=3;
bottom_width=83.2;
bottom_depth=114;
ymotor_plate_dist=25;
rod_x=330;
rod_y=330;
rod_z=330;
x_pos=113; // range: 13 - 208
y_pos=110; // range: 0 - 210
z_pos=106; // range: 0 - 200
hemera_off=7;
hemera_dist=10;
hemera_zoff=9;
frame_width=rod_x-122.4; // 247.6
frame_height=rod_z+40; // 370
kerf=(part=="preview"?1:-.1);
xcut=370-rod_x;
ycut=(350-rod_y)-yclip_extra*2;
zcut=330-rod_z;
ypw=200;
yph=rod_y-130;
ybelt_offset=50;
include<MP3DP_Hemera.scad>;

echo(str("Frame Size: ", frame_width, "x", frame_height));

if(part=="preview")
{
  color("yellow") translate([0,ycut,21.75]) rotate([90,0]) linear_extrude(plate_thick) front2d();
  yplate();
  color("teal") translate([0,339.5,0])
    translate([0,0,21.75]) rotate([90,0]) mirror([0,0,1]) linear_extrude(plate_thick) back2d();
  mirrorx() translate([78,ycut+yclip_extra,43.5]) rotate([-90,0]) cylinder(d=8,h=rod_y,$fn=40);
  linear_extrude(bottom_thick) bottom_parts();
  //mirrory(-339.5-ycut) color("blue") mirrorx(2.1) translate([87.475,6+ycut,43.5]) rotate([90,0]) YClip();
  mirrory(-339.5-ycut) color("blue") mirrorx() translate([78,6+ycut,43.5]) rotate([90,0]) YClip();
  if(!fingers)
    mirrory(-339.5) mirrorx() color("purple") CornerL();
  %mirrorx() translate([frame_width/2+plate_thick+1,169.75,26.25+3]) rotate([0,0,90]) rotate([90,0]) mirror([0,0,1]) linear_extrude(plate_thick) yframe2d();
  color("green") translate([0,214.1+plate_thick,183.55+3]) rotate([90,0]) linear_extrude(plate_thick) mainframe2d();
  for(m=[0,1]) mirror([m,0]) translate([frame_width/-2-38.5,177,55.5]) {
    //-162
    rotate([0,0,0]) {
      zmount(m);
      zstab(m);
      %cylinder(d=22,h=20,$fn=50);
      %translate([0,0,10]) cylinder(d=8,h=300,$fn=40);
      %translate([-20.25,8.35,-plate_thick]) cylinder(d=8,h=rod_z,$fn=40);
    }
    *translate([0,0,z_pos+90]) mirror([0,0,1]) translate([-105-9.5,-89.15+10,0]) import("MP3DP_V2/files/XZ-End.STL")
    translate([0,0,300])
    {
      cylinder(d=22,h=7,$fn=50);
      translate([-20.25,8.35]) cylinder(d=22,h=7,$fn=50);
    }
    *translate([-7.45,36.35,290])
    {
      translate([0,-36.35/2,.3]) rotate([0,0,180]) translate([-105,-128.17]) import("MP3DP_V2/files/Upper_L.STL");
    }
  }
  translate([frame_width/2+38.5,177,55.5+z_pos+90]) //mirror([0,0,1])
    translate([-105+30,-89.15+9,-55.2]) union() {
    translate([105,89.15]) translate([0,0,55.2]) rotate([180,0,180]) import("MP3DPV3_XZMotorM.stl");
    *import("MP3DP_V2/files/XZ_Motor.STL");
    translate([126.1,91+21,27.5]) rotate([90,0]) {
      cylinder(d=5,h=20,$fn=20);
      mirror([0,0,1]) difference() {
        translate([-20,-20]) cube([40,40,30]);
        mirrorx() mirrory() translate([15.5,15.5,-.01]) cylinder(d=3,h=10,$fn=20);
      }
    }
  }
  translate([frame_width/-2-38.5,177,55.5+z_pos+90]) mirror([0,0,1]) translate([-105-9.5,-89.15+10,0]) import("MP3DP_V2/files/XZ-End.STL");
  translate([-150+x_pos,188.5,6.3+z_pos+90]) {
    translate([0,10,4]) rotate([0,90,0]) rotate([0,0,-90]) {
      translate([8.5,-45.5-hemera_zoff]) translate([24.38,41.51]) rotate([0,0,180]) translate([-24.38-hemera_dist,-41.51]) color("gold") import("HEMERA-MODEL-1.3.stl");
      XMod(yoff=hemera_off,xoff=hemera_dist,zoff=hemera_zoff);
      %for(x=[0,35]) translate([0,-x,(370-rod_x)/2-x_pos-32.9]) cylinder(d=8,h=rod_x,$fn=40);
    }
  }
  if(bottom_fingers)
    bottom_plate();
  translate([ybelt_offset-8,340]) ymotor_mount();
  translate([ybelt_offset-3,ycut]) ypulley();
  //translate([52,340]) ymotor_mount();
  //translate([54.2,ycut]) ypulley();
} else if(part=="yclip") YClip();
else if(part=="yplate") yplate_2d();
else if(part=="2d") {
  translate([0,60]) yframe2d();
  translate([-60,130]) zmount_top2d();
  translate([70-60,130]) rotate([0,0,180]) translate([-30,-25]) zmount_support2d();
  back2d();
  translate([0,-50]) front2d();
  translate([-150,50]) rotate([0,0,90]) mainframe2d();
  //if(bottom_fingers)
  {
    translate([-240,10]) ymotor_plate(0);
    translate([-260,-40]) ymotor_plate(1);
    for(y=[250,300]) translate([-10,y]) ypulley_plate();
  }
} else if(part=="bottom")
  bottom_parts();
else if(part=="yframe")
  yframe_part();
else if(part=="mainframe")
  mainframe();
else if(part=="small")
  small_parts();
else if(part=="other")
  other_parts();
else if(part=="xzmotor")
  xzmotor();

module xzmotor() {
  import("MP3DPV3_XZMotorM.stl");
  *mirror([1,0]) difference() {
    translate([-105,-68.4]) import("MP3DP_V2/files/XZ_Motor.STL");
    translate([-50,0,55]) cube([60,20,30]);
    #for(z=[-6.25,6.25]) translate([-22,15,z+27.5]) rotate([-90,0]) cylinder(d=2.5,h=10,$fn=20);
  }
}
module bottom_parts() {
  if(part!="preview")
  translate([200,-10]) ymotor_topplate();
  translate([0,part=="preview"?339.5/2:0])
  for(w=(part=="preview")?[1]:[1,2]) translate([(w-1)*frame_width,0]) difforkid(w,1)
  {
    square([frame_width-bottom_width+12,frame_height-bottom_depth-30],center=true);
    for(mx=[0,1],my=[0,1]) mirror([mx,0]) mirror([0,my]) translate([0,339.5/-2]) {
      difference() {
        bottom_2d(mx&&my,mx&&!my,!my?ycut:0);
        translate([frame_width/-2-plate_thick-6+bottom_width/2,-10+ycut+bottom_depth/2]) pnotch_sub([bottom_width/2,bottom_depth/2],right=1,top=1,scale=mx==my?-1:1);
      }
      translate([frame_width/-2-plate_thick-6+bottom_width/2,-10+ycut+bottom_depth/2]) pnotch_add([bottom_width/2,bottom_depth/2],right=1,top=1,scale=mx==my?-1:1);
    }
    for(x=[6-bottom_fingers:bottom_fingers*2:frame_width])
      translate([frame_width/-2+x,339.5/-2+214.1-kerf]) square([bottom_fingers,plate_thick+kerf*2]);
  }
}
module difforkid(w=1,kid=1)
{
  if(w==1)
    difference(){
      children(0);
      children([1:$children-1]);
    }
  else children(kid);
}
module yplate()
{
  translate([0,62+y_pos,54]) {
    linear_extrude(10) union() {
      *translate([-4.5,0]) import("MP3DP_V2/files/Y-SpeedPlate_mm.DXF");
      yplate_2d();
    }
    translate([0,0,inches(1/2)+5]) %rcube([inches(8),inches(8),3],center=true);
    //for(pos=[[92,-25.25],[92,49.5],[-84,12]])
    mirrorx() mirrory() translate([78,40]) translate([-17,12.5]) rotate([90,0]) translate([0,-19.5])  import("MP3DP_V2/files/Y_Bed_Bearing_Blocks.STL");
  }
}
module yplate_2d() {
  echo(str("Yplate dims: ",ypw,"x",yph));
  difference() {
    rsquare([ypw,yph],center=true);
    mirrorx() mirrory() translate([ypw/2-5,yph/2-5]) circle(d=2.9,$fn=20);
    mirrorx() for(x=[0,24],y=[-40,40])
      translate([90-x,y]) circle(d=screwd,$fn=20);
    translate([ybelt_offset,-22.2]) {
      translate([-4.5,0]) circle(d=screwd,$fn=20);
      translate([4.5,19]) circle(d=screwd,$fn=20);
    }
  }
}
module ypulley()
{
  //#rotate([0,0,180]) translate([-105,-120.69,6.5]) import("MP3DP_V2/files/Y-bearing.STL");
  mirrorx() translate([-5,0]) rotate([0,-90,0]) linear_extrude(plate_thick,convexity=3) ypulley_plate();
}
module ypulley_plate()
{
  difference() {
    union() {
      translate([bottom_thick*2,-plate_thick-3]) square([12,3]);
      translate([bottom_thick*2+24,-plate_thick-3]) square([12+1.6,3]);
      polygon([[0,-plate_thick],[43.5,-plate_thick],[43.5,5],[5+bottom_thick,40],[0,40]]);
      translate([21.5,13.5]) circle(d=24,$fn=40);
    }
    translate([12*1.5,-plate_thick-.01]) square([6,plate_thick+kerf]);
    for(x=[0:12*2:40]) translate([x,-plate_thick-.01]) square([12,plate_thick+kerf]);
    for(y=[-3:12*2:40]) translate([-.01,y-plate_thick]) square([bottom_thick+kerf,12]);
    translate([21.5,13.5]) circle(d=3,$fn=20);
  }
}
module ymotor_mount() {
  translate([16,0,43.5]) mirror([1,0]) mirror([0,0,1]) rotate([0,0,-90]) union() {
    //#import("MP3DP_V2/files/Y_Mount.STL");
    for(y=[0,-ymotor_plate_dist]) translate([0,y,0])
    translate([-plate_thick,20+plate_thick]) rotate([90,0]) linear_extrude(plate_thick) ymotor_plate(y);
    %translate([0,-6+plate_thick,0]) linear_extrude(bottom_thick) ymotor_topplate();
  }
  %translate([-5-plate_thick,-46.5]) mirror([1,0]) {
    difference() {
      cube([50,43,43]);
      translate([-.01,21.5,21.5]) for(x=[-15.5,15.5],y=[-15.5,15.5]) translate([0,x,y]) rotate([0,90,0]) cylinder(d=3,h=10,$fn=20);
    }
    color("black") translate([0,21.5,21.5]) mirror([1,0]) rotate([0,90]) {
      cylinder(d=5,h=20,$fn=25);
      mirror([0,1,0]) mirrorx() translate([5,0,15-plate_thick/2]) cube([1,rod_y,6]);
    }
  }
}
module ymotor_topplate() {
  difference() {
    translate([0.8,0]) square([43,ymotor_plate_dist+plate_thick]);
    mirrory(-1*(ymotor_plate_dist+plate_thick)) for(x=[0:12*2:43])
      translate([x-plate_thick,-.01]) square([12+kerf*2,plate_thick+kerf]);
    for(y=[10.9,21.25])
      translate([36.1,y]) circle(d=3,$fn=20);
  }
}
module ymotor_plate(y) {
  difference() {
    union(){
      translate([0.5,0]) square([43.5+plate_thick,42.9]);
      translate([-5,0]) square([5.5,15]);
      translate([-5,30]) square([5.5,10]);
    }
    translate([-.01,12-kerf-1]) square([plate_thick+kerf,5+kerf+2]);
    for(z=[12:24:43])
      translate([-.01,z-kerf-.01]) square([plate_thick+kerf,12+kerf*2]);
    for(x=[0:12*2:50+plate_thick],y=[0,43-bottom_thick])
      if(x>0||y>0)
      translate([x-(y==0?12:0)+kerf-.01,y-.01]) square([12+.02,bottom_thick+kerf+.02]);
    if(y==0)
    translate([plate_thick+21.5+3.55,22]) {
      circle(d=26,h=plate_thick+.02,$fn=50);
      for(x=[-15.5,15.5],y=[-15.5,15.5]) {
        translate([x,y]) circle(d=3,h=10,$fn=20);
      }
    }
  }
}
module bottom_plate() {
  //mirrory(-339.5)
  %translate([0,339.5/2]) for(mx=[0,1],my=[0,1]) mirror([mx,0]) mirror([0,my]) translate([0,339.5/-2]) linear_extrude(bottom_thick,convexity=3) bottom_2d(mx&&my,mx&&!my,!my?ycut:0);
}
module bottom_2d(ymotor=1,ypulley=0,ycut=0) {
  difference() {
    translate([frame_width/-2-plate_thick-6,-10+ycut]) square([bottom_width,bottom_depth-ycut]);
    //mirrory(-339.5)
    {
      mirrorx() translate([frame_width/-2-6.25-kerf,-plate_thick-kerf]) square([7.5+kerf*2,plate_thick+kerf*2]);
      for(x=[frame_width/-2:bottom_fingers*2:123.8])
      translate([x,ycut-plate_thick-kerf]) square([bottom_fingers,plate_thick+kerf*2]);
    }
    for(y=[7.5+bottom_fingers:bottom_fingers*2:100])
        translate([frame_width/-2-plate_thick-kerf-1,y]) square([plate_thick+kerf*2,bottom_fingers]);
    translate([frame_width/-2-plate_thick-kerf-1,-.01]) square([plate_thick+kerf*2,8]);
    if(ypulley)
      translate([-ybelt_offset+8,-plate_thick]) mirrorx(10) for(y=[12-3:12*2:40]) translate([-kerf,y-kerf]) square([plate_thick+kerf*2,12+kerf*2]);
    if(ymotor)
      for(x=[0,ymotor_plate_dist],y=[12:12*2:bottom_depth])
        if(y>bottom_depth-40)
          translate([-ybelt_offset+12-kerf-x,bottom_depth-y+.71]) square([plate_thick+kerf*2+.1+(x>0?0:1),12+kerf*2]);
    //mirrorx()
    //translate([-136.01,169.75-30]) square([5+plate_thick+kerf,84]);
  }
}

module zmount(m=0)
{
  *#rotate([0,0,90]) rotate([180,0]) translate([-99.75,-143.6]) import("MP3DP_V2/files/Z_Mount_L.STL");
  *%translate([0,0,-10]) cylinder(d=24,h=10,$fn=40);
  translate([0,0,-plate_thick])
    color("red") linear_extrude(plate_thick,convexity=3) zmount_top2d(m);
  *color("teal") translate([-28.6+plate_thick,-26.1,-55.5]) rotate([90,0]) linear_extrude(plate_thick,convexity=3) zmount_support2d(m);
  %translate([-39.6-(m?44:0),-26.1-plate_thick,-55.5]) rotate([0,0,90]) rotate([90,0]) linear_extrude(plate_thick,convexity=3) zcap_2d();

}
module zcap_2d()
{
  tw=63+(fingers?plate_thick*2+.25:0);
  difference() {
    square([tw,366-zcut]);
    mirrorx(-tw) for(y=[5:fingers*2:360-zcut]) translate([-.01,y+kerf]) square([plate_thick+kerf,fingers]);
    for(x=[-4+plate_thick:xfingers*2:80],y=[366-plate_thick-zcut]) {
      xx=x==plate_thick-4?4:0;
      translate([x+xx,y]) square([xfingers+kerf*2-xx,plate_thick+.01]);
    }
    for(y=[-39.6+95-plate_thick],x=[-xfingers:xfingers*2:80]) translate([x-kerf,y-kerf]) square([xfingers+kerf*2,plate_thick+kerf*2]);
  }
}
module zmount_support2d(m=0)
{
  ex=(m?44:0);
  left=-11-plate_thick-ex;
  th=366-zcut;
  tw=44+ex;
  difference() {
    union() {
      translate([left,0]) square([tw,th]);
      translate([left,342-zcut]) square([75+ex,24]);
      translate([left,0]) square([61+ex,90]);
      square([66-plate_thick-kerf,55.4-plate_thick-kerf]);
      //*for(x=[0.2:xfingers*2:30]) translate([x+kerf,55.4-plate_thick]) square([xfingers,plate_thick]);
    }
    for(x=[-xfingers*5+16-plate_thick:xfingers*2:80],y=[366-zcut-plate_thick-kerf]) translate([x-kerf,y]) square([xfingers+kerf*2,plate_thick+abs(kerf*2)]);
    for(x=[-xfingers*5+10+kerf:xfingers*2:50],y=[55.4-plate_thick-kerf]) translate([x-kerf,y]) square([xfingers+kerf*2,plate_thick+kerf*2]);
    //circle(d=60,$fn=80);
    for(y=[-xfingers:xfingers*2:40]) translate([66-plate_thick*2-kerf,y+3+kerf]) square([plate_thick+abs(kerf),xfingers+kerf]);
    for(y=[-fingers+5:fingers*2:360-zcut]) translate([left,y]) square([plate_thick+kerf,fingers+kerf*2]);
  }
}
module zstab(m=0)
{
  translate([0,0,309.55-zcut-plate_thick+1]) linear_extrude(plate_thick,convexity=3) zstab_top2d(m);
}
module zstab_top2d(m=0)
{
  ex=(m?44:0);
  tw=60+ex+(fingers?plate_thick+.25:0)+10;
  th=63+(fingers?plate_thick*2:0);
  offx=-23.5-20.1+4-ex;
  offy=-26-(fingers?plate_thick:0);
  difference() {
    translate([offx,offy]) square([tw,th]);
    for(r=[-25:120:360]) rotate([0,0,r]) translate([16,0]) circle(d=3,$fn=20);
    *difference(){
      circle(d=22+kerf,$fn=80);
      circle(d=20,$fn=40);
    }
    if(fingers)
    {
      mirrory(-10.5) for(xi=[0:5]) {
        x=(-12.6-xfingers*8)+(xi*xfingers*2);
        xx=!m&&xi==3?4:0;
        translate([x-xx,offy+th-plate_thick-kerf]) square([xfingers+xx,plate_thick+1]);
      }
      for(y=[-30-xfingers+kerf:xfingers*2:40]) translate([-43.5-ex+3-kerf,y]) square([plate_thick+kerf*2+1,xfingers]);
    }
    circle(d=9,$fn=50);
    translate([-20.25,8.35]) circle(d=8.2,$fn=40);
  }
}
module zmount_top2d(m=0)
{
  ex=(m?44:0);
  offx=-23.5-16.1-ex;
  offy=-26-(fingers?plate_thick:0);
  tw=57+20.1+ex;
  th=62+(fingers?plate_thick*2+kerf+.25:0);
  difference() {
    translate([offx,offy]) difference() {
      square([tw,th]);
      for(y=[-13.1-plate_thick/2:xfingers*2:80]) translate([-.01,y-offy/2]) square([plate_thick+kerf,xfingers]);
      for(y=[12.01+plate_thick-xfingers*2:xfingers*2:80]) translate([tw-plate_thick-kerf,y]) square([plate_thick+abs(kerf*2),xfingers+kerf]);
    }
    if(fingers)
    {
      for(x=[-18.4+plate_thick+kerf-xfingers*(m?6:2):xfingers*2:30],y=[-26+kerf]) translate([x,y]) mirror([0,1]) square([xfingers,plate_thick+abs(kerf*2)]);
      for(x=[-13.4+kerf-xfingers*2-(m?xfingers*4:0):xfingers*2:40],y=[36.5-kerf]) translate([x,y+kerf]) square([xfingers,plate_thick+abs(kerf*2)]);
      if(!m) {
        translate([-13.4-xfingers,36.5]) mirror([1,0]) square([xfingers*2,plate_thick+1]);
        translate([offx+tw-3-kerf,36.5]) square([xfingers*2,plate_thick+1]);
      }
      *mirror([1,0]) for(y=[-26-fingers/2:fingers*2:40]) translate([35-kerf,y+kerf]) square([plate_thick+kerf*2,fingers]);
      *for(x=[30.5],y=[-26.01+fingers:fingers*2:40]) translate([x-kerf,y+kerf]) square([plate_thick+kerf*2+1,fingers]);
    }
    circle(d=24,$fn=50);
    translate([-20.25,8.35]) circle(d=8.2,$fn=40);
    mirrorx() mirrory() translate([15.5,15.5]) circle(d=3.2,$fn=20);
  }
}
module mainframe2d()
{
  left=frame_width/-2-61.7-20.1;
  echo(str("main left: ", left));
  *import("MP3DP_V2/files/XZ_Frame_mm.DXF");
  difference() {
    //*translate([-185.5-20.1,-186.5]) square([371+40.2,frame_height]);
    union() {
      translate([left,-186.5]) square([frame_width+123.4+84.2,frame_height]);
    }
    translate([-left-20.1+5,-186.5+95]) square([45,245-zcut]);
    translate([frame_width/-2-plate_thick-kerf-1,-186.51+main_bottom]) square([frame_width+plate_thick*2+kerf*2+2,312.284-zcut-main_bottom]);
    mirrorx() translate([left+9,-146]) {
      *circle(d=screwd,$fn=20);
      *translate([30,-25]) circle(d=screwd,$fn=20);
      translate([11,-9]) hull() {
        circle(d=6.4,$fn=24);
        translate([0,-18]) circle(d=6.4,$fn=24);
      }
    }
    *mirrorx() translate([-178.8,165.55]) {
      circle(d=screwd,$fn=20);
      translate([13.3,11.6]) circle(d=screwd,$fn=20);
    }
    if(!fingers)
      mirrorx() {
        translate([-143.5,119]) circle(d=screwd,$fn=20);
        translate([-136.7,112.184]) rsquare([10,13.6],2.5);
      }
    else {
      if(main_bottom)
      {
        for(x=[6:bottom_fingers*2:frame_width])
          translate([frame_width/-2-kerf+x,-186.51]) square([bottom_fingers+kerf*2,bottom_thick+kerf]);
        for(y=[13,24.01])
        translate([42,-186.51+y]) square([16,6]);
        mirrorx() translate([frame_width/-2-plate_thick-kerf-1,-186.51+main_bottom/2+3]) square([plate_thick+kerf*2,main_bottom]);
      }
      //for(y=[-186.5+5:fingers*2:180]) translate
      mirrorx(-44) for(y=[-186.5+5-fingers:fingers*2:180-zcut]) translate([left+4-kerf,y]) square([plate_thick+kerf*2,fingers+kerf*2]);
      for(m=[0,1], y=[0,310.5-zcut]) mirror([m,0]) translate([left+30+.01,-131-plate_thick+y]) for(x=[-xfingers*(m?5:1):xfingers*2:40]) translate([x,-kerf]) square([xfingers+kerf*2,plate_thick+kerf*2]);
    }
  }
  if(fingers)
    mirrorx() intersection() {
      for(y=[-183.5+(main_bottom?fingers*2:0):fingers*2:110-zcut])
        translate([frame_width/-2-plate_thick-kerf-1,y]) square([plate_thick+kerf,fingers]);
      translate([frame_width/-2-plate_thick-kerf-1,-186.5+main_bottom*2]) square([plate_thick+kerf,fingers*14+main_bottom]);
    }
}
module small_parts()
{
  translate([0,200]) front2d();
  translate([0,150]) back2d();
  translate([-110,80]) zstab_top2d();
  translate([-190,80]) zstab_top2d(1);
  translate([-114,0]) zmount_top2d();
  translate([-195,0]) zmount_top2d(1);
  mirrorx(10) ypulley_plate();
  for(m=[0,1]) mirror([m,0]) translate([10,50]) ymotor_plate(m);
  translate([-260,-40]) ymotor_plate(1);
}
module other_parts()
{
  translate([-70,106]) rotate([0,0,-90]) {
    for(w=[1,2]) translate(w==1?[-0,12]:[]) difference() {
      intordiff(w) {
        zmount_support2d();
        translate([-55,-10]) psquare([120,190],top=1,xoff=4,istart=0,istop=0);
      }
     translate([10,180]) rotate([0,0,90]) pconnectors(2,helper=0,width=100,height=20);
    }
  }
  translate([-70,-22]) rotate([0,0,-90]) {
    mirror([1,0]) for(w=[1,2]) translate(w==1?[0,12]:[]) difference() {
      intordiff(w) {
        zmount_support2d(1);
        translate([-80,-10]) psquare([150, 190],xoff=-5,top=1);
      }
      translate([0,180]) rotate([0,0,90]) pconnectors(10,width=120,helper=0);
    }
  }
  for(y=[-90,-170]) translate([-70,y]) rotate([0,0,-90]) {
    for(w=[1,2]) translate(w==1?[0,12]:[]) difference() {
      intordiff(w) {
        zcap_2d();
        translate([-5,-10]) psquare([80,170],top=1,xoff=4,istart=-.5,istop=.5);
      }
      translate([40,160]) rotate([0,0,90]) pconnectors(2,width=120,helper=0);
    }
  }
  for(x=[-100,-152,-204]) translate([x,-105]) rotate([0,0,90]) pconnector(120,bezel=10);
  translate([-160,-195]) pconnector(width=100,height=20,bezel=7.5);
}
module mainframe()
{
  conpos=[[-210+50+xcut/2,93,90,0,30,0],[165-xcut/2,-110,90,5,30,0],[83-xcut/2,154,0,0,30,0],[-40,-186+main_bottom/2,0,0,16,2]];
  translate([-24,-12]) intersection(){difference(){
      mainframe2d();
      for(pos=conpos)translate([pos[0],pos[1]]) rotate([0,0,pos[2]]) pconnectors(pos[3],height=pos[4],xoff=pos[5]);}
    mainframe_bl();}
  translate([24,24]) intersection(){difference(){mainframe2d();for(pos=conpos)translate([pos[0],pos[1]]) rotate([0,0,pos[2]]) pconnectors(pos[3],height=pos[4],xoff=pos[5]);}
    mainframe_tr();}
  difference() {
    mainframe2d();
    union() {
      mainframe_bl(10);
      mainframe_tr();
    }
    for(pos=conpos)
      translate([pos[0],pos[1]]) rotate([0,0,pos[2]]) pconnectors(pos[3],height=pos[4],xoff=pos[5]);
  }
  translate([10+xcut/2,0]) for(x=[15,-40,-92]) translate([x,65]) rotate([0,0,90]) pconnector();
    
}
module mainframe_tr(off)
{
  translate([84-xcut/2,40]) psquare([180,inches(9)],left=1,yoff=0,xoff=-14);
  translate([94,-110]) psquare([150,inches(8)],bottom=1,xoff=-30);
}
module mainframe_bl(off)
{
  translate([-210+xcut/2,-200]) {
    psquare([94,inches(11.5)],top=1,pnotch=w-1,xoff=5);
    psquare([inches(6),main_bottom+28],right=1);
  }
}
module yframe_part()
{
  for(w=[1,2])
  translate(w==1?[12,-12]:[]) difference() {
    intordiff(w) {
      yframe2d();
      union() {
        translate([-200,-30]) psquare([inches(4),60],right=1,pnotch=w-1);
        translate([25,80]) psquare([inches(5),inches(8)],bottom=1,pnotch=w-1);
      }
    }
    translate([-200+inches(4),0]) pconnectors();
    translate([90,80]) rotate([0,0,90]) pconnectors();
  }
  for(x=[15,-40]) translate([x,65]) rotate([0,0,90]) difference() {
    rsquare([90,50],center=true);
    pconnectors();
  }
}
module pconnector(width=70,height=30,bezel=10) {
  difference() {
    rsquare([width+bezel*2,height+bezel*2],center=true);
    pconnectors(width=width,height=height);
  }
}
module pconnectors(yoff=0,helper=0,width=70,height=30,xoff=0) {
  if(helper) {
    %translate([6,6]) pnotch(180);
    %translate([-6,-6]) pnotch(0);
    %translate([0,off])
    difference() {
      square([width-1,height-1],center=true);
      square([width-2,height-2],center=true);
    }
  }
  for(x=[width/-2,width/-6,width/6,width/2],y=[height/-2,height/2])
    translate([x+xoff,y+yoff]) circle(d=screwd,$fn=20);
}
module psquare(dims,pnotch=1,right=0,left=0,bottom=0,top=0,xoff=0,yoff=0,istart=-1,istop=1)
{
  hx=dims[0]/2+xoff;
  hy=dims[1]/2+yoff;
  difference() {
    union() {
      translate([0.01,0.01]) square([dims[0]-0.02,dims[1]-0.02]);
      pnotch_add(dims,pnotch,right,left,bottom,top,xoff,yoff,istart,istop);
    }
    pnotch_sub(dims,pnotch,right,left,bottom,top,xoff,yoff,istart,istop);
  }
}
module pnotch_add(dims,pnotch=1,right=0,left=0,bottom=0,top=0,xoff=0,yoff=0,istart=0,istop=0,scale=1)
{
  hx=dims[0]/2+xoff;
  hy=dims[1]/2+yoff;
  if(left)
    translate([-6,hy-6*scale]) pnotch(pnotch=pnotch,istart=istart,istop=istop);
  if(right)
    translate([dims[0]+6,hy+6*scale]) pnotch(180,pnotch=pnotch,istart=istart,istop=istop);
  if(bottom)
    translate([hx-6*scale,-6]) pnotch(90,pnotch=pnotch,istart=istart,istop=istop);
  if(top)
    translate([hx+6*scale,dims[1]+6]) pnotch(270,pnotch=pnotch,istart=istart,istop=istop);
}
module pnotch_sub(dims,pnotch=1,right=0,left=0,bottom=0,top=0,xoff=0,yoff=0,istart=0,istop=0,scale=1)
{
  hx=dims[0]/2+xoff;
  hy=dims[1]/2+yoff;
  if(left)
    translate([6,hy+6*scale]) pnotch(180,pnotch=1-pnotch,istart=istart,istop=istop);
  if(right)
    translate([dims[0]-6,hy-6*scale]) pnotch(0,pnotch=1-pnotch,istart=istart,istop=istop);
  if(bottom)
    translate([hx+6*scale,6]) pnotch(270,pnotch=1-pnotch,istart=istart,istop=istop);
  if(top)
    translate([hx-6*scale,dims[1]-6]) pnotch(90,pnotch=1-pnotch,istart=istart,istop=istop);
}
module pnotch(angle=0,kerf_dir=1,istart=-1,istop=1){
  rotate([0,0,angle])
    //for(i=[istart:istop]) translate([0,i*22,0])
    {
    circle(d=8
      //+(kerf_dir==1?-kerf:kerf)
      ,$fn=30);
    translate([3.5,0]) square([7,5
      //+(kerf_dir==1?-kerf:kerf)
      ],center=true);
  }
}
module intordiff(which=1)
{
  if(which==1)
    difference(){
      children(0);
      children(1);
    }
  else
    intersection(){
      children(0);
      children(1);
    }
}
module yframe2d()
{
  
  //#translate([0,0,1])
  union() {
    *#import("MP3DP_V2/files/Y_Frame_mm.DXF");
    difference() {
      union() {
        translate([-154.3+ycut,-26.2-3]) square([308.6-ycut,3]);
        translate([-154.3+ycut,-26.2]) square([308.6-ycut,53]);
        extra_main_height=129.2;
          translate([40.9,283-extra_main_height-zcut]) square([4,extra_main_height]);
        hull()
        {
          translate([44.25,-26.2]) square([20,309.1-zcut]);
          translate([75,309.1-26.2-2]) circle(r=2,$fn=16);
          translate([152,66]) circle(r=2,$fn=16);
          translate([44.25,10]) square([308.6/2-44.25,10]);
        }
        *translate([34.25-5,26.8]) difference() {
          square([15,15]);
          translate([0,15]) circle(r=15,$fn=40);
        }
        if(fingers)
          mirrorx(-ycut) translate([-170-plate_thick+ycut,-26.2-3])
          difference() {
            polygon([[-3,44],[-3,bottom_thick+kerf],[plate_thick,bottom_thick+kerf],[plate_thick,0],[30,0],[30,56],[15+plate_thick,56],[0,44]]);
            for(y=[8:xfingers*2:40])
              translate([-.01,49-y]) mirror([0,1]) square([plate_thick+kerf,xfingers]);
          }
        translate([-18.7-plate_thick-3,25.8]) square([80,4]);
      }
      if(bottom_fingers)
      {
        mirrorx(-ycut) intersection() {
          translate([-179.5,-29.21]) square([bottom_depth+kerf,bottom_thick+kerf]);
          for(x=[-162+ycut:bottom_fingers*2:0])
          translate([x-kerf,-29.21]) square([bottom_fingers+kerf*2,bottom_thick+kerf]);
        }
      }
      if(main_bottom)
      translate([44.1-kerf,-26.21-3]) square([plate_thick+kerf*2+.1,main_bottom/2+3+kerf+.01]);
      if(!fingers)
        mirrorx() mirrory(6.4) translate([-144.3,9.8]) circle(d=screwd,$fn=20);
      else {
        for(y=[-26.2+(main_bottom?fingers*2:0):fingers*2:270-zcut])
          translate([44.1-kerf,y-kerf]) square([plate_thick+kerf*2+.1,fingers+kerf*2]);
        for(y=[-26.2:xfingers*2:0])
          translate([-18.9-plate_thick-kerf,y]) square([plate_thick+kerf*2,xfingers+kerf*2]);
        for(x=[0:xfingers*2:50]) translate([-18.9+x,26.3-plate_thick-kerf]) square([xfingers+kerf*2,plate_thick+kerf*2]);
        //translate([-19-plate_thick,26.1-plate_thick]) square([fingers,plate_thick+1]);
      }
      translate([119.3,-26.2]) circle(d=15.9,$fn=40);
      translate([119.3,-11.3]) circle(d=screwd,$fn=20);
      *translate([-5.75,-13.75]) {
        circle(d=3.2,$fn=20);
        translate([30,25]) circle(d=3.2,$fn=20);
      }
      *translate([83.8,59.25]) circle(d=3.2,$fn=20);
      *hull() {
        translate([94.8,59.25]) circle(d=screwd,$fn=20);
        translate([96.5,59.25]) circle(d=3.2,$fn=20);
      }
      *translate([96.5,140.5]) {
        circle(d=3.2,$fn=20);
        translate([-12.75,13.75]) circle(d=3.2,$fn=20);
      }
      *translate([94.75,209.3]) circle(d=screwd,$fn=20);
      if(!fingers) translate([72.2,276.2]) circle(d=screwd,$fn=20);
      *translate([144.75,59.25]) circle(d=screwd,$fn=20);
    }
  }
}
module back2d(ymotorholes=1)
{
  *#mirror([1,0]) translate([-267.6,0]) import("MP3DP_V2/files/back_mm.DXF");
  difference() {
    union(){
      square([frame_width,43.5],center=true);
      if(fingers)
        mirrorx() translate([frame_width/2-plate_thick,-21.75]) difference() {
          square([1.25+2*plate_thick+kerf,43.5]);
          for(y=[-24:xfingers*2:43.5])
            translate([plate_thick+1.25-kerf,17-y-kerf]) square([plate_thick+kerf*2,xfingers+kerf*2]);
        }
      }
    if(ymotorholes)
      for(x=[0,ymotor_plate_dist]) translate([ybelt_offset-ymotor_plate_dist/2-plate_thick+.5+x-kerf,-21.75]) {
        for(z=[12:12*2:40])
          translate([0,43.5-z]) square([plate_thick+kerf*2,12]);
      }
    if(bottom_fingers)
    {
      mirrorx()
      intersection() {
        translate([-frame_width/2-6-plate_thick,-21.76]) square([bottom_width+kerf,20]);
        for(x=[frame_width/-2+bottom_fingers:bottom_fingers*2:frame_width/-2+bottom_width])
        {
          translate([x-kerf,-21.76]) square([bottom_fingers+kerf*2,bottom_thick+kerf+.02]);
        }
      }
      //ox=frame_width/-2+bottom_fingers*3-kerf;
      //echo(str("OX:",ox,", BF3:",bottom_fingers*3));
      //mirrorx() translate([ox,-21.76]) square([10+kerf*2,bottom_thick+kerf]);
    }
    if(!fingers)
    mirrorx() mirrory() translate([110,11.8]) circle(d=screwd,$fn=20);
    //mirrorx(2.1) translate([87.475,5.8]) {
    mirrorx() translate([78,5.8]) {
      circle(d=screwd,$fn=20);
      translate([-6.75,21.75-5.8-6.75]) square([13.5,7.1]);
      translate([0,-16]) circle(d=screwd,$fn=20);
    }
    if(!ymotorholes)
    {
      translate([62,13.75]) circle(d=screwd,$fn=20);
      translate([58,-13.75]) circle(d=screwd,$fn=20);
    }
  }
}
module front2d(ypulley=1)
{
  *import("MP3DP_V2/files/front_mm.DXF");
  difference() {
    union(){
      square([frame_width,43.5],center=true);
      if(fingers)
        mirrorx() translate([frame_width/2-plate_thick,-21.75]) difference() {
          square([1.25+2*plate_thick+kerf,43.5]);
          for(y=[-24:xfingers*2:43.5])
            translate([1.25+plate_thick-kerf,17-y-kerf]) square([plate_thick+kerf*2,xfingers+kerf*2]);
        }
    }
    if(ypulley)
      translate([ybelt_offset-3,-21.75]) mirrorx() for(y=[12:12*2:40]) translate([5-kerf,y-kerf]) square([plate_thick+kerf*2,12+kerf*2]);
    if(!fingers)
      mirrorx() mirrory() translate([110,11.8]) circle(d=screwd,$fn=20);
    if(bottom_fingers)
    {
      mirrorx()
      intersection() {
        translate([-frame_width/2-6-plate_thick,-21.76]) square([bottom_width+kerf,20]);
        for(x=[frame_width/-2+bottom_fingers:bottom_fingers*2:frame_width/-2+bottom_width])
        {
          translate([x-kerf,-21.76]) square([bottom_fingers+kerf*2,bottom_thick+kerf+.02]);
        }
      }
    }
    //mirrorx(2.1) translate([87.475,5.8]) {
    mirrorx() translate([78,5.8]) {
      circle(d=screwd,$fn=20);
      translate([-6.75,21.75-5.8-6.75]) square([13.5,7.1]);
      translate([0,-16]) circle(d=screwd,$fn=20);
    }
    if(!ypulley)
    {
      translate([70.375,-6.8]) circle(d=screwd,$fn=20);
      translate([37.6,6.3]) circle(d=screwd,$fn=20);
    }
  }
}
module CornerL() {
  translate([-120.5,12]) translate([-105,-88.75]) import("MP3DP_V2/files/CornerL.STL");
}
module YClip(extra=yclip_extra)
{
  rodd=8.2;
  *#translate([-6.6,-20.5]) import("MP3DP_V2/files/YClip.STL");
  wt=1.18*2;
  od=rodd+wt*2;
  difference() {
    union() {
      translate([0,0,15]) mirror([0,0,1]) translate([0,-6.6]) {
        linear_extrude(15+extra,convexity=3) hull() {
          mirrorx() translate([od/2-2,2]) circle(r=2,$fn=24);
          translate([0,6.5]) circle(d=od,h=15+extra,$fn=50);
        }
      }
      translate([0,0,-extra+4]) rcube([od+5+wt*2-.2,6+wt*3-.2,8],1,center=true);
      translate([0,0,-extra]) linear_extrude(5.5+extra,convexity=3) {
        difference() {
          union() {
            hull() {
              mirrorx() translate([6.5-3,-6.6+1]) circle(d=4,$fn=24);
              mirrorx() translate([-2.5,-18.5]) circle(d=4,$fn=24);
            }
            hull() {
              mirrorx() translate([2.5,-18.5]) circle(d=4,$fn=24);
              mirrorx() translate([-2.5,-18.5-(bottom_fingers?23-bottom_thick-kerf:23)]) circle(d=4,$fn=24);
            }
          }
          for(y=[-16,-16-16]) translate([0,y]) circle(d=screwd,$fn=20);
        }
      }
    }
    //#translate([0,0,15.01]) mirror([0,0,1]) cylinder(d=rodd,h=180,$fn=40);
    translate([0,0,15.01]) mirror([0,0,1]) {
      linear_extrude(3.2+extra,convexity=3) difference() {
        circle(d=rodd,$fn=40);
        translate([-4.1,-4.1]) square([8.2,8.2]);
      }
      *linear_extrude(50,convexity=3) difference() {
        translate([-1.5,0]) square([3,14]);
        mirrorx() translate([1.5,4.6]) circle(d=1.6,$fn=20);
      }
    }
    translate([od/2+2.5+wt,0,-extra+4]) rotate([0,-90,0]) {
      translate([0,0,-5]) cylinder(d=3,h=30,$fn=20);
      rotate([0,0,180]) mirrorz(od+5+wt*2) for(z=[wt]) translate([-5.01,-3.01,z]) cube([8.02,6.02,2.5]);
    }
  }
}

module mirrorx(off=0) {
  translate([off/-2,0]) for(m=[0,1]) mirror([m,0]) translate([off/2,0]) children();
}
module mirrory(off=0)
{
  translate([0,off/-2]) for(m=[0,1]) mirror([0,m]) translate([0,off/2]) children();
}
module mirrorz(off=0)
{
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/-2]) children();
}
module rsquare(dims,r=5,center=false,$fn=30)
{
  translate(center?[dims[0]/-2,dims[1]/-2]:[0,0])
  hull() for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=$fn);
}
module rcube(dims,r=5,$fn=30,center=false)
{
  translate(center?[dims[0]*-.5,dims[1]*-.5,dims[2]*-.5]:[])
  linear_extrude(dims[2],convexity=3) {
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=$fn);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
  }
}
module cube2(dims,r=5,$fn=30)
{
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r,$fn=$fn);
  }
}

function inches(in) = 25.4 * in;