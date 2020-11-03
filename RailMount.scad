part="ystop"; // [preview:Preview All,preview2:Preview 1 side,plates:2d Top Plates (X-axis),plates3:3d Top Plate,yplate:2d Y Plate,pplate:Pen Plate,rplate:2d Router Plate,rfunnel:Router Plate Funnel,ztop:Top Z Roller,zbot:Bottom Z Roller Combo,grip:Pipe Grip (connects conduit to Top Plates),xstop:X Stop cap,x2020:2020 rod cap,idler:Idler - 625zz bearing cover,xa:X-mount part A,xc:X-mount part B,x2d:X-mount 2D,yb:Y-bottom,yb2:Y-bottom cap,y2d:Y-bottom 2D,ystop:Y stop,slide_riser:X-axis slide block riser,vattach:Vacuum Attachment,zrod_stabilizer:Z-Rod Stabilizer,zrod_anchor:Z-Rod Anchor]
pipe_diameter = inches(1.163); //inches(1.163); //30; //inches(1);
//pipe_diameter = inches(.922); //.922
//pipe_diameter = inches(1);
plate_size=[inches(7),//inches(8)
  //,inches(6.5)-5.1];
  ,inches(8)-8];
slide_close=10;
rod_length=inches(15);
support_width=48;
wheel_dia=60;
wheel_thick=25;
wheel_dist=263; // 308.2
pipe_grip_height=10;
pipe_grip_trap=0;
motordist=-17.62; // vicious
motordist=-27.62;
pulleypos=[9.75,8.8]; // vicious
pulleypos=[12,3];
yplate_version=2;
zlift=inches(4)-12;
wall_thick=inches(1/2)+.2;
base_thick=inches(1.25);
plasmoff=66;
xs3m=3;
rod_dist=plate_size[1]-40-slide_close*2;
zpipe_dist=90.4-(-1*((wheel_dist/2)-154.1));
grip_znut_offset=-1*(zpipe_dist-rod_dist/2);
echo(str("Pipe: ",pipe_diameter," Rod Distance: ",rod_dist," Wheel Dist:",wheel_dist," ZNut Offset:",grip_znut_offset));
include <TorchMount.scad>;
if(part=="preview") {
  mirrory(rod_length-82) translate([0,-60,-30]) mirror([0,1,0]) yplate();
  *yplate();
  translate([plate_size[0]*-.5-5,plate_size[1]*.5-13.5,117+zlift]) rotate([0,0,90]) rotate([-90,0]) translate([0,0,-14.5]) union() {
    #xmount();
    translate([0,0,4]) rotate([90,0]) xmountc();
    xmountb();
    translate([0,7,22.8]) nema17();
  }
  translate([rod_dist*-.5,-30.2,86+zlift]) {
    translate([0,inches(0)]) {
    translate([-30,inches(1), 0]) {
      color("brown") linear_extrude(3,convexity=5) mirror([0,1]) rotate([0,0,-90]) router_plate_2d(2,1);
      translate([0,0,-3]) linear_extrude(2.9) mirror([0,1]) rotate([0,0,-90]) router_plate_2d(1,1);
      translate([0,0,-6]) linear_extrude(2.9) mirror([0,1]) rotate([0,0,-90]) router_plate_2d(1,1);
      translate([0,0,-9]) linear_extrude(2.9) mirror([0,1]) rotate([0,0,-90]) router_plate_2d(1,2);
      translate([0,0,-12]) linear_extrude(2.9) mirror([0,1]) rotate([0,0,-90]) router_plate_2d(1,2);
      translate([0,0,-15]) linear_extrude(2.9) mirror([0,1]) rotate([0,0,-90]) router_plate_2d(0,2);
      
    }
      
      for(x=[0,rod_dist],y=[0,plate_size[0]-40-slide_close*2]) translate([x,y]) 
        slider();
    }
    mirrory(rod_length-22) translate([0,0,-6]) support_plate();
    for(x=[0,rod_dist]) translate([x,0]) {
      if(x==0) mirrory(rod_length-22) translate([-16,-10,46]) {
        translate([0,4+xs3m,4]) xstop(1);
        xstop(2);
        translate([0,20]) mirror([0,1]) xstop(3);
        translate([-21,xs3m,21]) xstoptop();
      }
      mirrory(rod_length-22) {
        support();
      }
      translate([0,-11,24]) rotate([-90,0]) {
        translate([0,0,-40]) cylinder(d=20,h=rod_length+80,$fn=40);
      }
    }
  }
} else if(part=="zrod_stabilizer") {
  zrod_stabilizer();
} else if(part=="zrod_anchor") {
  zrod_anchor();
} else if(part=="vattach") {
  vac_attach();
} else if(part=="slide_riser") {
  %translate([-25,0,-21]) rotate([90,0]) import("SC20UU.stl");
  difference() {
    union(){
    for(x=[-20,20],y=[-20,20]) translate([x,y]) circle(d=16,$fn=40);
    square([50,50],center=true,r=4);
    }
    slide_holes(1);
  }
} else if(part=="660") {
  difference() {
    rsquare([inches(3.1),inches(3.1)],center=true);
    dw660_mount();
  }
} else if(part=="ystop2") {
  ystop2();
} else if(part=="ystop") {
  translate([-10,0,4]) rotate([0,0]) intersection(){
    translate([-30,-10,-4.59]) cube([50,50,30]);
    union() {    
      ystop(2,1);
      *ystop(3);
      *translate([0,0,10.5]) ystoptop();
    }
  }
  translate([-10,120,-5]) rotate([180,0]) difference() {
    ystop(2);
    translate([-35,-10,-4.61]) cube([60,80,20]);
    *translate([-18+19,-10,-30]) cube([20,80,40]);
  }
  //translate([0,-50]) splitz(dims=[40,44,pipe_diameter],zoff=-12)
  *translate([0,40]) mirror([0,0,1]) difference(){
    translate([10,-50,-21.5]) {
      translate([-2+13.5,39.5+14.5,10.3]) ystop(1);
    }
    translate([-.5,-.5]) cube([31,31,10]);
  }
  *translate([40,40]) intersection(){
    cube([30,30,10]);
    translate([10,-50,-21.5]) {
      translate([-2+13.5,39.5+14.5,10.3]) ystop(1);
    }
  }
  *translate([60,0,-4]) ystoptop();
} else if(part=="preview2") {
  translate([rod_dist/-2,-30,110]) support_plate();
  yplate();
} else if(part=="idler") {
  idler_bearing();
} else if(part=="idler2") {
  for(t=[1,2]) translate([20*(t-1),0]) linear_extrude(1.5) difference() { circle(d=9,$fn=50); circle(d=5,$fn=30); }
} else if(part=="xstop") {
  mirror([0,0,1]) {
    *translate([-40,0,-12]) xstop(1);
    //%translate([0,0,4.1]) xstop(1);
    translate([0,0,1]) xstop(2);
    *translate([0,60,-2]) mirror([0,1])  mirror([0,0,1]) rotate([0,0]) translate([0,-25,-4]) xstop(3);
    *translate([-100,-8,1]) xstoptop(thick=4);
    *translate([-130,-8,1]) xstoptop(thick=3,tracks=0);
  }
} else if(part=="motorplate") {
  motorplate();
} else if(part=="x2020") {
  xstop(2,1);
} else if(part=="yb2") {
  mirror([0,0,1]) ybottom2();
} else if(part=="yb") {
  ybottom();
} else if(part=="y2d") {
  ybottom_2d();
} else if(part=="x2d") {
  xmount_2d();
} else if(part=="xa") {
  xmount();
} else if(part=="xc") {
  xmountc();
} else if(part=="rfunnel") {
  router_funnel();
} else if(part=="pplate") {
  pen_plate();
} else if(part=="pnut") {
  pen_nut();
} else if(part=="pnut2") {
  pen_nut2();
} else if(part=="rplate2") {
  router_plate_2d(vac=0,which=3);
  //#translate([88.9,97.6,50]) torchmount();
} else if(part=="rplate3") {
  linear_extrude(4) router_plate_2d(vac=0,which=1);
  translate([0,0,4]) linear_extrude(10) router_plate_2d(vac=1,which=1);
} else if(part=="plasmate") {
  rotate([0,0,90]) {
    router_plate_2d(vac=0,which=1,makita=0,cutout=0,dw660=0,plasma=1,wing=1);
    *translate([89+plasmoff,97.6,20]) rotate([0,0,180]) mirror([0,0,1]) torchmount();
  }
} else if(part=="rplate") {
  *translate([-87,-75]) router_plate_2d(vac=0,which=4,dw660=1);
  *translate([81,0]) router_plate_2d(vac=0,which=3,dw660=1);
  *translate([0,0]) router_plate_2d(vac=0,which=3);
  //rotate([0,0,180]) translate([-88.9,-97.6])
    router_plate_2d(vac=2,which=1);
    translate([200,0]) router_plate_2d(vac=1,which=1);
    translate([0,160]) router_plate_2d(vac=1,which=2);
    translate([140,160]) router_plate_2d(vac=0,which=2);
  *rplate_wrench();
  *translate([-47,0]) translate(plate_size/2) rotate([0,0,90]) rotate([-90,0]) translate([-102.5,-102.5,-6.5]) {
      import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/VacShoeBack.STL");
      import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/VacShoeFront.STL");
  }
} else if(part=="plates") {
  //router_plate_2d();
  //for(y=[support_width*-.5-2,support_width*-1.5-4]) translate([y,32]) mirror([0,1]) rotate([0,0,-90]) support_plates_2d(y<-30?2:1);
  rotate([0,0,90]) {
  translate([0,-3*support_width-3]) support_plates_2d(1);
  translate([0,-2*support_width-2]) support_plates_2d(2);
  translate([0,-support_width-1]) support_plates_2d(3);
  support_plates_2d(4);
  translate([0,support_width+1]) support_plates_2d(5);
  }
} else if(part=="plates3") {
  support_plate();
} else if(part=="zbot") {
  rotate([90,0]) z_roller(-1*((wheel_dist/2)-154.1));
} else if(part=="ztop") {
  yz_roller();
} else if(part=="yplate")
{
  yplate_2d();
} else if(part=="grip")
{
  pipe_grip();
}
module pen_nut2() {
  id=5.9;
  nutod=24;
  union() {
    for(x=[nutod-2:nutod-2:120]) translate([x,0]) rotate([0,0,30]) difference() {
      circle(d=nutod,$fn=6);
      circle(d=id,$fn=40);
      for(r=[0:60:360]) rotate([0,0,r]) translate([nutod/2-3,0]) circle(d=2.8,$fn=20);
    }
    translate([0,0]) rotate([0,0,30]) difference() {
      circle(d=nutod,$fn=6);
      for(r=[0:60:360]) rotate([0,0,r]) translate([nutod/2-3,0]) circle(d=2.8,$fn=20);
      for(r=[0:60:360]) rotate([0,0,r]) translate([-1.5,nutod/2-5]) square([3,id]);
      circle(d=id,$fn=40);
    }
  }
}
module pen_nut(h=20) {
  id=5.9;
  nutod=32;
  rotate([0,0,30])  difference() {
    linear_extrude(h,convexity=3) difference() {
      circle(d=nutod,$fn=6);
      circle(d=id,$fn=40);
    }
    translate([0,0,h-3]) cylinder(d=11,h=10,$fn=50);
    for(r=[0:60:360]) rotate([0,0,r+30]) translate([nutod/2-4,0,h-6]) rotate([0,90]) {
      translate([0,0,-2]) cylinder(d=3,h=4,$fn=20);
      cylinder(d1=3,d2=4,h=2,$fn=20);
    }
  }
}
module pen_plate() {
  vtrim=8;
  %translate([0,0,vtrim]) pen_nut();
  difference() {
    union() {
      difference() {
        translate([0,0,vtrim]) cylinder(d=60,h=18-vtrim,$fn=100);
        translate([0,0,-.01]) cylinder(d=35,h=20.02,$fn=80);
      }
      for(r=[0:60:360]) rotate([0,0,r]) translate([14,0,vtrim+5]) rotate([0,90,0]) {
        translate([-5,-5,3]) cube([10,10,13]);
      }
    }
    for(r=[0:60:360]) rotate([0,0,r]) translate([10,0,vtrim+5]) rotate([0,90,0]) {
      cylinder(d=3,h=20,$fn=20);
      translate([-3,-3,4]) cube([9,6,3]);
      translate([-3,-3,15]) cube([9,6,3]);
    }
    translate([0,0,-.01]) rotate_extrude($fn=100) difference() {
      translate([13+6.6,0]) {
        square([2.5+.8,15]);
        *square([7.5+.8,5]);
        translate([1.25+.4,15]) circle(r=1.25+.4,$fn=20);
      }
    }
  }
  id=9;
  od=id+1.61*2;
  *translate([0,0,vtrim]) difference() {
    union(){
      cylinder(d=38,h=2,$fn=40);
      cylinder(d1=od+6,d2=od,h=8,$fn=50);
    }
    translate([0,0,-.01]) cylinder(d=id,h=8.02,$fn=40);
  }
}
module ystop2() {
  difference() {
    union() {
      cylinder(r=pipe_diameter,h=inches(3/4)+2,$fn=100);
      translate([0,-5]) cube([50,5,inches(3/4)+2]);
      linear_extrude(2) {
        hull() {
          square([50,inches(1)]);
          circle(r=pipe_diameter+2,$fn=100);
          translate([45,-5]) circle(r=5,$fn=30);
        } 
      }
    }
    translate([43,18,-.01]) cylinder(d=4,h=2.02,$fn=30);
    translate([34,.01,12]) rotate([90,0]) cylinder(d=4,h=5.02,$fn=30);
    *translate([0,-5,2.01]) mirror([0,1,0]) cube(30);
    translate([0,0,2]) cube(inches(2));
    translate([4,4,-.01]) cube(inches(1)+6);
  }
}
module rplate_wrench()
{
  difference() {
    union() {
      translate([0,-10]) {
        rsquare([50,20]);
        *square([10,25.8]);
      }
      circle(d=25.5,$fn=80);
    }
    translate([30,0]) circle(d=3,$fn=20);
    translate([-15,-13]) square([8,26]);
    translate([-8,-5.3]) polygon([[0,-1],[0,11.6],[7,10.6],[7,0]]);
    circle(d=12.6,$fn=6);
    *for(y=[-8,0,8]) translate([0,y]) hull() {
      translate([12,0]) circle(d=3,$fn=20);
      translate([32,0]) circle(d=3,$fn=20);
    }
  }
}
module splitz(dims,zoff=0)
{
  intersection() {
    translate([-dims[0],-10,zoff]) cube(dims[0]+20,dims[1]+20,dims[2]);
    children();
  }
  translate([-dims[0],dims[1]-10,zoff/2-dims[2]/2]) rotate([180,0]) difference() {
    children();
    translate([-dims[0],-10,zoff]) cube(dims[0]+20,dims[1]+20,dims[2]);
  }
  
}
module ystoptop()
{
  difference() {
    translate([-21,-4,4]) cube([26,29,2]);
    for(x=[-16,0],y=[0,21])
      translate([x,y,-29.5]) {
        cylinder(d=3,h=pipe_diameter+30,$fn=20);
        *translate([0,0,pipe_diameter+5]) cylinder(d1=3,d2=7,h=2.1,$fn=20);
      }
    }
}
module ystop(which=3,guides=0)
{
  w3off=18;
  //color("purple")
  rotate([0,0,0]) difference() {
    union() {
      if(which!=2)
        translate([-21,-4,4]) cube([26,29,10]);
      if(which!=1)
        translate([-19-3.5,-7,3]) mirror([0,0,1]) rcube([19+10,48+w3off,30]);
      if(guides)
        translate([-19-3.5,40,-5]) mirror([0,1]) {
          cube2([29,4,17],1.5);
          translate([-3,0]) rcube([35,30,3],1.5);
          mirrorx(19+10) translate([-3,0]) cube2([9,4,25],1.5);
          mirrorx(19+10) translate([19+9,0]) cube2([4,30,25],1.5);
          mirrorx(19+10) translate([-3,1.5,24.51]) rotate([-90,0])
         minkowski() {
           linear_extrude(27.01) { polygon([[1.5,1],[5,1],[3,3],[1.5,3]]); }
           sphere(r=1.5,$fn=20);
         }
        }
    }
    if(guides)
    translate([-19-4,40,-5]) mirror([0,1]) 
      translate([(19)/2-2.5,-.01,17]) cube([16,30,8.1]);
    translate([-8,40.1,8]) rotate([90,0]) {
      cylinder(d=3.4,h=50,$fn=24);
      if(!guides)
        translate([-1.7,0]) mirror([0,1]) cube([3.4,5,50]);
      if(which!=2) translate([0,0,28]) mirror([0,1]) {
        translate([-2.8,-2.81]) cube([5.6,8,2.8]);
        *cylinder(d=8,h=30,$fn=6);
      }
    }
    if(which==2)
    {  
      *for(x=[-18,-2]) translate([x,-4.01,1]) cube([4,40,5]);
    } else {
      for(x=[-16,0],y=[0,21])
        translate([x,y,-pipe_diameter]) {
          cylinder(d=3,h=pipe_diameter+30,$fn=20);
        }
      translate([0,10.5]) for(my=[0,1]) mirror([0,my]) translate([0,-10.5]) mirrorx(-16) translate([-3.1,my==0?-4.1:-2.9,which!=2?3.99:-4.6]) cube([5.8,my==0?7.1:5.8,5.6]);
      translate([-13.4,-4.1,15]) mirror([0,0,1]) gt2_track();
    }
    if(which!=1)
    {
      translate([-8-base_thick/2-.5,-8.01,-pipe_diameter+1.99]) cube([base_thick+1.02,70.02,10]);
      for(y=[-2,29]) translate([-8,y,-pipe_diameter+11.98]) {
        hull() {
          for(x=[-10,10]) translate([x,0,17]) {
            cylinder(d=5.5,h=5,$fn=30);
            //translate([-3,-3]) cube([6,6,5]);
          }
        }
        if(!guides) {
          for(x=[0]) translate([x,0]) {
            cylinder(d=3.2,h=pipe_diameter-7.96,$fn=20);
            translate([-2.95,-2.95]) cube([5.9,5.9,10]);
          }
        } else {
          hull() {
            for(x=[-10,10]) translate([x,0]) cylinder(d=3.2,h=pipe_diameter-7.96,$fn=20);
          }
        }
      }
      for(y=[12,46]) translate([-8,y,-pipe_diameter+11.98-8.6]) {
        cylinder(d=inches(5/16)+1,h=pipe_diameter-7.96,$fn=20);
        
        *translate([0,0,pipe_diameter-13.96]) cylinder(d1=3.5,d2=10,h=2.02,$fn=40);
        translate([0,0,pipe_diameter-17.97]) cylinder(d=20,h=10,$fn=40);
      }
    }
  }
  //*translate([-102.5,-102.5,-13.98]) import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/Belt_Stop.STL");
}
module pipe_grip(height=pipe_grip_height) {
  
  difference() {
    union() {
      //hull()
      {
        linear_extrude(5,convexity=3) {
          hull() {
            circle(d=pipe_diameter+8,$fn=80);
            translate([22.5+grip_znut_offset,0]) circle(d=16,$fn=50);
            translate([-22.5+grip_znut_offset,0]) circle(d=16,$fn=50);
          }
        }
        //linear_extrude(6) rsquare([42,42],center=true);
        linear_extrude(2,convexity=3) difference() { union() {
          mirrorx() mirrory() hull() {
            translate([16,16]) circle(d=10,$fn=40);
            circle(d=pipe_diameter+4,$fn=80);
          }
          if(pipe_grip_trap)
            square([pipe_diameter+8,pipe_diameter+10],center=true);
          else
            rsquare([pipe_diameter+10,pipe_diameter+11],center=true);
        }
          
          mirrorx() mirrory() translate([16,16]) circle(d=3,$fn=20);
          *for(r=[0:90:359]) rotate([0,0,r]) translate([15,0]) circle(d=1,$fn=10);
          circle(d=pipe_diameter,$fn=100);
        }
        translate([0,0,2]) rotate_extrude($fn=80) {
          translate([pipe_diameter/2+3.2,0]) difference(){
            square([2,2]);
            translate([2,2]) circle(r=2,$fn=40);
          }
        }
        cylinder(d=pipe_diameter+10.4,h=height,$fn=80);
        *cylinder(d=inches(1),h=10,$fn=80);
      }
      //translate([0,0,10]) cylinder(d1=inches(1.2),d2=inches(1.1),h=20,$fn=80);
    }
    for(r=[60,120,240,300]) rotate([0,0,r]) translate([24.01,0,((height-2)/2)+2]) rotate([0,-90]) {
      if(pipe_grip_trap)
      {
        translate([0,0,pipe_diameter/4+.1]) cube([6,6,2.8],center=true);
      } else {
        cylinder(d=6,h=pipe_diameter/4-3,$fn=30);
        //translate([0,-4]) cube([8,8,pipe_diameter/4-1]);
      }
      cylinder(d=3,h=20,$fn=20);
    }
    translate([0,0,-.1]) cylinder(d=pipe_diameter+.2,h=40,$fn=80);
    mirrorx() mirrory() { translate([16,16,-.1]) {
        cylinder(d=3,h=40,$fn=20);
        *translate([0,0,3]) cylinder(d1=3,d2=6,h=height-3.8,$fn=40);
        *translate([0,0,height-.8]) cylinder(d=6,h=2,$fn=40);
      }
    }
            translate([22.5+grip_znut_offset,0,-.1]) {
              translate([0,0,5]) rotate([0,0,0]) {
                cylinder(d=14,h=6,$fn=60); //cylinder(d=14.6,h=6,$fn=6);
                translate([-6,-14]) cube([20,28,6]);
              }
              cylinder(d=8.2,h=10,$fn=40);
            }
            translate([-22.5+grip_znut_offset,0,-.1]) {
              translate([0,0,5]) rotate([0,0,0]) {
                cylinder(d=14,h=6,$fn=60); //cylinder(d=14.6,h=6,$fn=6);
                mirror([1,0]) translate([-6,-14]) cube([20,28,6]);
              }
              cylinder(d=8.2,h=10,$fn=40);
            }
  }
}
module yplate_2d(wheel_space=wheel_dist)
{
  smallholes=1;
  startx=wheel_space/-2; //-154.1
  offdia=(inches(1)-pipe_diameter)/2;
      maxy=250;
      maxx=110;
  *import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/Y_plate.DXF");
  difference() {
    mirrorx() {
      if(yplate_version==2)
        translate([0,80]) offset(10) polygon([[0,0],[maxx+10,0],[maxx,10],[maxx,maxy-20],[maxx,maxy],[50,maxy],[40,maxy-10],[0,maxy-10]]);//square([200,160]);
      hull() {
        translate([startx+offdia, 83]) circle(d=22,h=4,$fn=40);
        translate([startx+87.4,-61.95]) {
          circle(d=1,$fn=8);
          translate([0,90]) circle(d=8,$fn=8);
        }
        translate([startx+39.9,58]) mirror([1,0]) square([53,14]);
      }
      hull() {
        translate([startx+offdia, 83]) {
          circle(d=22,h=4,$fn=40);

        }
        translate([startx+39.9,58]) mirror([1,0]) square([53,14]);
      }
      translate([startx+14.1,51]) rsquare([34,30],r=3);
      translate([startx+44.1,20]) square([60,51]);
      translate([startx+88.1,51]) rsquare([84,30],r=3);
      translate([startx+78.4,-73.93]) rsquare([78,130],r=3);
    }
    mirrorx() {
      translate([startx+48.1,58]) rsquare([44,26],r=4);
      translate([startx+offdia, 83]) circle(d=7.9,h=4,$fn=40);
      translate([startx+87.4-offdia,-61.95]) circle(d=7.9,$fn=40);
      translate([startx+40+offdia,70]) circle(d=7.9,$fn=40);
      for(y=[24.15,40.67])
        translate([-28,y]) circle(d=3.2,$fn=20);
      if(yplate_version==2)
      {
        if(smallholes) {
        for(x=[0,20]) translate([x,maxy+70]) circle(d=5,$fn=30);
        for(y=[100:50:maxy+50]) translate([-110,y]) circle(d=5,$fn=30);
        for(x=[60,80,110]) translate([x,maxy+80]) circle(d=5,$fn=20);
        }
        hull() {
          translate([70,120]) circle(d=30,$fn=60);
          translate([70,maxy+50]) circle(d=30,$fn=60);
        }
        for(z=[60,maxy+45])
          translate([-28,z+9]) circle(d=8,$fn=40);
        *for(y=[4,inches(3/4)-4],y2=[60,220])
          translate([-28,y+y2]) circle(d=3.2,$fn=20);
      }
        
    }
    translate([-24,-31.8]) rsquare([48,82.95],r=3.4);
    if(yplate_version==2)
    {
      translate([-10,112]) rsquare([20,maxy-90],r=3.4);
      translate([-40,maxy+40]) rsquare([80,20],r=10);
    }
  }
}
module gt2_track()
{
  cube([10.8,29.2,2]);
  for(y=[0:2:30]) translate([0,y,1.99]) cube([10.8,1.2,1]);
}
module xstoptop(depth=25,thick=4,tracks=1)
{
  difference() {
    cube([26,depth,thick]);
    translate([5,4,-.1]) mirrorx(16) mirrory(depth-8) cylinder(d=3,h=5,$fn=20);
    if(tracks)
    translate([7.6,-.1,-1])
      gt2_track();
  }
}
module xstop(which=1,mod=0)
{
  z2m=29.6;
  nutz=[7];
  nutd=4;
  difference() {
   union() {
      if(which==3)
      {
        translate([-24,5-xs3m,4]) cube([32,20,25.5]);
        translate([-21-3,-4-9,4]) rcube([57+6,29-3,2]);
        translate([8,-13,4]) rcube([31,45,4]);
      }
      else if(which==1)
        translate([-21,-4,2]) cube([26,25,15]);
      else if(which==2)
      {
        translate([(mod?-5:-21)-3,-4-8,-8-z2m
          ]) rcube([57-(mod?16:0)+6,29+16,12+(mod?2:0)+z2m
      ]);
        if(!z2m) translate([-.5,-5.5,-8-29.6]) for(x=[0,32],y=[0,32]) translate([x,y]) cylinder(d=8,h=29.6,$fn=40);
      }
      
    }
    if(which==3)
    {
      for(z=nutz) translate([-8,26,4+z]) rotate([90,0]) cylinder(d=nutd+.4,h=16,$fn=20);
      translate([0,-xs3m]) {
      translate([-21.5,4.9-20,6]) cube([27,18+20,20.5]);
      translate([-15,0,20]) cube([14,26,15]);
      translate([-20,0,25]) cube([24,21,10]);
      }
      translate([15.5,9.5]) {
        mirrory() translate([16,-16]) cylinder(d=4,h=40,$fn=30);
         translate([-16,-16]) cylinder(d=4,h=40,$fn=30);
      }
    }
    if(!mod) for(x=[-16,0],y=[0,17])
      translate([x,y+(which==2?3:0),-8.1]) {
        cylinder(d=2.9,h=30,$fn=20);
      }
    if(which==1)
    {
     for(z=nutz) translate([-8,3.5,z]) rotate([-90,0]) {
        translate([0,0,-20]) cylinder(d=nutd+.4,h=50,$fn=20);
        translate([-1.5,0,6]) cube([3,12.75,50]);
        *translate([0,0,4]) {
          cylinder(d=10.4,h=1.4,$fn=60);
          translate([-5.2,0]) cube([10.4,10.5,1.4]);
        }
        translate([0,0,0]) rotate([0,0,30]) cylinder(d=8,h=25,$fn=6);
        translate([-3.45,0,0]) {
          cube([6.9,15.5,25]);
        }
      }
      mirrorx(-16) mirrory(17) translate([-2.75,-4.1,12.75]) mirror([0,0,1]) cube([5.5,7.1,20]);
      mirrorx(-16) translate([-2.75,-4.1,10]) mirror([0,0,1]) cube([5.5,30,10]);
    }
    if(which!=1)
      for(x=mod?[16]:[12,26],y=[5,16]) translate([x,y+(which==3?-1:0),-8.1]) {
        cylinder(d=3,h=20,$fn=20);
        if(mod)
          translate([0,0,8]) cylinder(d=7,h=5,$fn=40);
        else
          translate([-2.8,-2.8,8.5]) cube([5.6,5.6,2.8]);
      }
    if(which==2||which==3) {
      translate([0,which==3?-.75:0.25,1]) mirror([0,0,1]) {
        cube([31,20.5,60]);
        if(z2m>0) {
          for(x=[-8,39]) translate([x,10.25,-10]) {
            cylinder(d=10,h=60,$fn=80);
            translate([0,0,38]) cylinder(d=16,h=12,$fn=80);
          }
          translate([40,10.25,6]) rotate([0,-90,0]) cylinder(d=10,h=70,$fn=80);
        }
        translate([-12,0,40]) cube([31+24,20.5,40]);
        translate([15.5,10.25,-10]) mirrorx() mirrory() translate([16,16]) cylinder(d=4,h=100,$fn=30);
        translate([15.5,-30,20]) rotate([-90,0]) {
          cylinder(d=21,h=70,$fn=80);
          rotate([0,0,180]) translate([-10.5,0]) cube([21,21,70]);
        }
        mirrorx(31) translate([30.99,10.5,6.26]) rotate([0,0,90]) rotate([90,0]) {
          cylinder(d=3,h=16,$fn=20);
          translate([-2.8,-2.8]) cube([5.6,5.6,2.75]);
        }
        mirrory(20.5) for(x=[8,26]) translate([x-(mod?1.5:0),.1,6.26]) mirror([0,1]) rotate([-90,0]) {
          cylinder(d=3,h=16,$fn=20);
          translate([-2.8,-2.8]) cube([5.6,5.6,2.75]);
        }
      }
    }
  }
  *for(z=nutz) translate([-8,3.5,z]) rotate([-90,0])
        translate([0,0,4]) {
          difference() {
            translate([0,0,-.8]) {
              cylinder(d=12,h=3,$fn=80);
              translate([-6,0]) cube([12,2.75,3]);
            }
            cylinder(d=10.4,h=1.4,$fn=60);
            translate([-5.2,0]) cube([10.4,10.5,1.4]);
            translate([0,0,-.81]) cylinder(d=6,h=25,$fn=40);
            translate([-3,0,-.81]) cube([6,15,25]);
            translate([-6,2.75,-.81]) cube([12,10,10]);
          }
        }
}
module motorplate() {
  difference() {
    intersection() {
      rsquare([43,43],center=true,r=10,$fn=30);
      square([40,40],center=true);
    }
    circle(d=24,$fn=60);
    mirrorx() mirrory() translate([15.5,15.5]) circle(d=3.2,$fn=30);
  }
}
module xmountb()
{
  translate([0,0,22]) mirror([0,0,1]) difference() {
      union() {        
        linear_extrude(3) hull() {
          mirrorx() {
            translate([12,-22]) circle(d=20,$fn=50);
            translate([28,23.4]) square([2,4]);
          }
        }
        mirrorx() {
          translate([12,-22,3]) cylinder(d1=10,d2=8,h=1,$fn=40);
        }
      }
      mirrorx() translate([12,-22,-.1]) cylinder(d=6,h=40,$fn=30);
      translate([0,6.65,-.01]) {
        cylinder(d=33,h=30,$fn=40);
        mirrorx() mirrory() translate([15.5,15.5]) cylinder(d=3,h=30,$fn=20);
      }
    }
}
module xmountc(d=15)
{
  rotate([-90,0]) difference() {
      union() {
        translate([0,0,3]) linear_extrude(d,convexity=4) {
          mirrorx() hull() {
              *translate([15.5,-15.5+6.65]) circle(d=6,$fn=20);
              translate([15.5,15.5+6.65]) circle(d=6,$fn=20);
              translate([14,18]) square([16,9.4]);
            }
        }
        translate([-20,18,3]) cube([40,9.4,d]);
        
      }
      mirrorx() translate([25,0,3+d/2]) rotate([-90,0]) rotate([0,0,30]) {
        cylinder(d=3.2,h=40,$fn=40);
        *cylinder(d=8,h=20,$fn=30);
      }
      mirrorx() translate([12,-22,-.1]) cylinder(d=6,h=40,$fn=30);
      translate([0,6.65,-.01]) {
        cylinder(d=36,h=30,$fn=40);
        mirrorx() mirrory() translate([15.5,15.5]) cylinder(d=3,h=30,$fn=20);
      }
    }
  
}
module xmount_2d(bottom=0) {
  kerf=-.1;
  difference() {
      hull() {
        translate([0,-70]) circle(d=30,$fn=60);
        mirrorx() {
          translate([18,-32]) circle(d=24,$fn=50);
        }
        translate([-30,23.4]) square([60,4+(bottom?3:0)]);
      }
      mirrorx() for(y=[-14:24:30]) translate([27.01,y]) square([3,12]);
      for(x=[-20:28:24],y=[6.65-29-3,27.41]) translate([x,y]) square([12,3]);
      translate([0,-70]) circle(d=16,$fn=50);
      mirrorx() translate([18,-32]) circle(d=5,h=40,$fn=30);
      translate([0,6.65]) {
        circle(d=36,h=30,$fn=40);
        mirrorx() mirrory() translate([15.5,15.5]) circle(d=3,h=30,$fn=20);
      }
    }
  mirrorx() translate([38,6.65-29]) union() {
    square([50,50]);
    for(x=[-20:28:24],y=bottom?[-3,50]:[-3]) translate([x+25+kerf,y]) square([12-kerf*2,3]);
    mirrorx(50) for(y=[-14:24:30]) translate([50,y+22.35+kerf]) square([3,12-kerf*2]);
  }
  translate(!bottom?[30,-120]:[]) for(x1=bottom?[-62,2]:[2]) translate([x1,33+3]) difference() {
    union() {
      square([60,50]);
      for(y=bottom?[50,-3]:[-3]) for(x=[-20:28:24]) translate([x+30+kerf,y]) square([12-kerf*2,3]);
    }
    if(x1>0) translate([30,6]) circle(d=10,$fn=40);
    mirrorx(60) for(y=[-14:28:30]) translate([-.01,y+19]) square([3,12]);
  }
  translate(bottom?[-30,93]:[-34,-87]) rotate([0,0,90]) difference() {
    square([60,56]);  
    mirrorx(60) for(y=[-14:24:30]) translate([-.01,y+22.35]) square([3,12]);
    mirrory(56) for(x=[-20:28:24]) translate([x+30,-.01]) square([12,3]);
  }
}
module idler_bearing(support=0) {
  tbih=12;
    translate([30,0]) difference() { union() {
      cylinder(d=28,h=1.5,$fn=80);
      translate([0,0,1.5]) cylinder(d1=16.2,d2=15.8,h=1.5,$fn=50);
    }
    translate([0,0,-.01]) {
      cylinder(d=13,h=5,$fn=50);
//      translate([0,0,1.5]) cylinder(d=
    }
  }
  if(!support) difference() {
    union(){
      *cylinder(d1=20,d2=18,h=1,$fn=80);
      cylinder(d=28,h=1.5,$fn=80);
      *translate([0,0,1.5+tbih]) cylinder(d=28,h=1.5,$fn=80);
      translate([0,0,1.5]) cylinder(d=20,h=tbih,$fn=80);
      *translate([0,0,11]) cylinder(d1=20,d2=20,h=1,$fn=80);
    }
    translate([0,0,-.1]) cylinder(d=13,h=20,$fn=50);
    translate([0,0,1]) cylinder(d=16.4,h=20,$fn=50);
  }
  if(support) translate([0,0,1.7]) difference() {
      cylinder(d1=26,d2=28,h=tbih-.4,$fn=80);
      translate([0,0,-.01]) cylinder(d1=23,d2=22,h=tbih-.38,$fn=80); 
      translate([-20,-1,-.01]) cube([40,2,10]);
   }
}
module xmounta_2d() {
  difference() {
    hull() {
      mirrorx() {
        translate([12,-22]) circle(d=20,$fn=50);
        translate([28,23.4]) square([2,4]);
      }
    }
    mirrorx() translate([12,-22]) circle(d=6,h=40,$fn=30);
    translate([0,6.65]) {
      circle(d=16,h=30,$fn=40);
      mirrorx() mirrory() translate([15.5,15.5]) circle(d=3,h=30,$fn=20);
     }
  }
}
module xmount()
{
  union() {
    *#translate([-102.5,-102.5,0]) import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/X2_plate.STL");
    translate([0,0,4]) difference() {
      union() {
        %mirrorx() translate([12,-22,4]) {
          
          translate([0,0,-1]) idler_bearing();
        }

        
        linear_extrude(3) xmounta_2d();
        mirrorx() {
          translate([12,-22,3]) cylinder(d1=10,d2=8,h=1,$fn=40);
        }
      }
      mirrorx() translate([25,0,9]) rotate([-90,0]) rotate([0,0,30]) {
        cylinder(d=4,h=40,$fn=40);
        cylinder(d=7.8,h=20,$fn=6);
      }
      mirrorx() translate([12,-22,-.1]) cylinder(d=6,h=40,$fn=30);
      translate([0,6.65,-.01]) {
        cylinder(d=36,h=30,$fn=40);
        mirrorx() mirrory() translate([15.5,15.5]) cylinder(d=3,h=30,$fn=20);
      }
    }
  }
  
}
module ybottom_2d(znut=0)
{
  difference() {
    union() {
      mirrorx() translate([-37,5.38]) {
        square([17,6]);
        translate([0,-wall_thick-4.5]) square([17,4]);
      }
      hull() {
        if(znut)
          translate([0,26.6]) circle(d=24,$fn=60);
        translate([-23,6]) square([46,2]);
        translate([-23,-21+motordist]) square([46,60]);
      }
    }
    translate([0,motordist]) {
      circle(d=32.85,$fn=60);
      mirrorx() mirrory() translate([15.5,15.5]) circle(d=3,$fn=20);
    }
    mirrorx() translate(pulleypos) circle(d=5.3,$fn=30);
    translate([-10,-40+motordist]) square([20,40]);
    translate([0,26.6]) {
      circle(d=10.75,$fn=50);
      mirrorx() translate([8,0]) circle(d=3,$fn=20);
    }
  }
}
module ybottom2()
{
  difference() {
    union() {
      for(y=[8.5,-wall_thick+2]) mirrorx() translate([-37,y,16.5]) cube([17,3,10]);
        for(y=[8.5,-wall_thick+2]) mirrorx() hull() {
          translate([16,y,21]) cube([4,3,5.5]);
          translate([0,0,21]) translate(pulleypos) cylinder(d=20,h=5.5,$fn=40);
        }
      *translate([-19,2.5,21]) cube([38,10,5.5]);
      hull() mirrorx() translate([0,0,21]) translate(pulleypos) cylinder(d=21.4,h=5.5,$fn=60);
    }
    mirrorx() translate(pulleypos) cylinder(d=5.2,h=30,$fn=34);
    mirrorx() translate([0,0,8.5]) translate(pulleypos) cylinder(d=22,h=12.5,$fn=60);
    mirrorx() for(z=[5,21.5]) translate([-28,-15,z]) rotate([-90,0]) cylinder(d=3.5,h=30,$fn=20);
  }
  mirrorx() translate([0,0,20]) translate(pulleypos) mirror([0,0,1]) bearing_lip(5.2,1.5);
}
module ybottom()
{
  *translate([-37,-38.62]) import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/Y_Bottom.STL");
  %ybottom2();
  color("blue") difference() {
    union() {
      *translate([0,26.6]) cylinder(d=8,$fn=40,h=80);
      mirrorx() translate([-37,5.38]) {
        cube([17,2.9,26.5]);
        cube([17,6,16.3]);
        translate([0,-wall_thick-6.5]) cube([17,6,26.5]);
        translate([14,.1]) rotate([0,0,-90]) {
          cube([wall_thick+4.5,3,16.5]);
          translate([wall_thick+4.5,3]) rotate([90,0]) linear_extrude(3) polygon([[0,0],[0,26.5],[10,26.5],[-motordist+26.5-wall_thick-4.5,8]]);
          //square([-motordist+26.5-wall_thick-4.5,26.5]);

        }
      }
      linear_extrude(8,convexity=4) ybottom_2d();
    }
    mirrorx() translate([-37.1,5.38]) {
      translate([0,-wall_thick-3.6,16.4]) cube([17.2,3.4,11]);
      
    }

    translate([0,26.6,8.01]) mirror([0,0,1]) znut_hole();
    mirrorx() translate([0,0,8.5]) translate(pulleypos) idler_bearing();
    mirrorx() translate([0,0,8]) translate(pulleypos) cylinder(d=22,h=24,$fn=60);
    translate([0,motordist,5.7]) mirrorx() mirrory() translate([15.5,15.5]) cylinder(d=7.21,h=60,$fn=40);
    mirrorx() for(z=[5,21.5]) translate([-28,-15,z]) rotate([-90,0]) cylinder(d=3.5,h=30,$fn=20);
  }
      mirrorx() translate([0,0,8]) translate(pulleypos) bearing_lip(5.2,2.5);
}
module znut_hole()
{
  cylinder(d=22,h=4,$fn=80);
  cylinder(d=11,h=10,$fn=40);
  mirrorx() translate([8,0]) cylinder(d=3,h=10,$fn=20);
}
module znut_hole_2d(hex=0)
{
  circle(d=11,$fn=40);
  mirrorx() translate([8,0]) rotate([0,0,30]) circle(d=hex?6.1:3,$fn=hex?6:20);
}
module zrod() {
  %color("gold") translate([0,0,230]) mirror([0,0,1]) cylinder(d=8,h=300,$fn=40);
  
}
module zrod_stabilizer(milled=0)
{
  height=inches(3/4);//(milled?inches(3/4):18);
  difference() {
    union() {
      linear_extrude(height,convexity=3) {
        if(milled)
          translate([-40,0]) square([80,42]);
        else {
          translate([0,21]) circle(d=40,$fn=80);
          translate([-20,0]) square([40,21]);
        }
      }
      if(!milled)
      translate([-34,-1]) cube([68,16,height]);
    }
    translate([0,21,-.01]) cylinder(d=10,h=20.02,$fn=40);
    translate([0,21,3]) {
      translate([0,0,-1]) cylinder(d=18,h=2,$fn=50);
      cylinder(d=22.1,h=8.02,$fn=60);
      translate([0,0,8]) cylinder(d=32,h=10,$fn=80);
    }
    for(x=[-28,28])
      translate([x,-20,9]) rotate([-90,0]) {
        cylinder(d=8,h=65,$fn=40);
        *if(!milled)
        translate([0,0,inches(3/4)+14]) rotate([0,0,30]) cylinder(d=7.6/cos(60),h=10,$fn=6);
      }
    *for(x=[-28,28],z=[4,inches(3/4)-4])
      translate([x,-20,z]) rotate([-90,0]) cylinder(d=3.2,h=65,$fn=20);
  }
  *translate([0,80]) difference() {
    cylinder(d=31.4,h=12,$fn=80);
    translate([0,0,-.01]) cylinder(d=9,h=15.02,$fn=40);
    translate([0,0,2]) cylinder(d=23.1,h=20,$fn=60);
    translate([0,0,5]) cylinder(d=24,h=20,$fn=60);
  }
}
module zrod_anchor(cap=1,cnut=1)
{
  h=8;
  od=21;
  difference() {
    union() {
      cylinder(d=od,h=h,$fn=80);
      if(cap)
        translate([0,0,h]) cylinder(d1=od,d2=20,h=1,$fn=80);
    }
    translate([0,0,-.01]) cylinder(d=8,h=h+2.02,$fn=40);
    for(r=[0:120:360]) rotate([0,0,r]) translate([0,0,h/2]) rotate([-90,0]) {
      cylinder(d=3,h=20,$fn=20);
      if(cnut)
      translate([-3,-3,5.4]) cube([6,8.1,3]);
    }
  }
}
module yplate()
{
  offdia=(inches(1)-pipe_diameter)/2;
  xo=-1*((wheel_dist/2)-154.1);
  if(yplate_version==2)
    for(z=[60,220])
    translate([0,-inches(1/4)+.33,z]) mirror([0,1]) {
      zrod_stabilizer();
      translate([0,21,19]) zrod_anchor();
    }
  /**/
    mirrorx() translate([-154.1+xo,-49-wheel_thick,83]) {
        translate([-40,5,-50]) rotate([0,90,0]) extrusion(200);
        rotate([-90,0]) difference() {
        cylinder(d=wheel_dia,h=wheel_thick,$fn=80);
        translate([0,0,-.01]) {
          cylinder(d=8,h=30,$fn=40);
          cylinder(d=22,h=7,$fn=60);
          translate([0,0,wheel_thick-7]) cylinder(d=22,h=7.02,$fn=60);
        }
      }
    }
  translate([0,-.6,19]) mirror([0,1]) union() {
    ybottom();
    translate([0,26.6]) {
      zrod();
      *color("black") cylinder(d=50,h=20,$fn=20);
    }
    *translate([0,26.5,-50]) mirror([0,0,1]) nema17();
  }
  rotate([90,0]) {
  translate([0,0,-7]) linear_extrude(inches(1/2)) yplate_2d(wheel_dist); //import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/Y_plate.DXF");
  mirrorx() translate([-121.4+xo+offdia,59,30]) rotate([0,-90,-90])
      yz_roller();
  //!rotate([90,0]) 
  z_roller(xo);
  mirrorx() translate([90.4-xo,-90,30.2]) rotate([-90,0]) translate([0,0,200+zlift]) mirror([0,0,1]) {
      translate([0,0,6]) color("black") pipe_grip();
      color("purple") linear_extrude(200+zlift) difference() { circle(d=pipe_diameter,$fn=60); circle(d=6.4,$fn=30); }
    }
  /**/
  *translate([0,112,30]) mirror([0,1,0]) translate([-102.5,-102.5,-24]) import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/XZ_Main.STL");
  }
}
module z_roller(xo=0)
{
  offdia=(inches(1)-pipe_diameter)/2;
  translate([0,0,-.25]) {
  mirrorx() translate([74.9-xo+offdia,-77.2,30.2]) rotate([0,-90,-90]) {
    translate([.05,-15.5,4.2]) yz_roller(0);
    }
  translate([-50,-74,6.25]) difference() {
    translate([22,0]) cube([54,13,41.6]);
    translate([50,-10.1,21]) rotate([-90,0]) {
      cylinder(d=10,h=23,$fn=40);
      translate([0,0,12]) cylinder(d=22,h=8,$fn=80);
      translate([0,0,19]) cylinder(d=27,h=10,$fn=80);
      translate([0,0,3]) cylinder(d=21,h=20,$fn=80);
      mirrorx() mirrory() translate([15.5,15.5,-.1]) cylinder(d=3,h=30,$fn=20);
    }
  }
  }
}
module yz_roller(includey=1)
{
  *translate([-102.5,-102.5]) {
    if(!includey)
      translate([0,15.5,-4.2]) import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/Lower_Za.STL");
    else
      import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/YZ_Roller_M.STL");
  }
  //translate([0,(inches(1)-pipe_diameter)/(includey?3:8)])
  union() {
  difference() {
    color("blue") {
      mirrorx() translate([0,15+pipe_diameter/2,includey?0:-1]) rotate([0,0,30]) mirror([0,1,0]) translate([0,1.66]) cube([36.4,16,22+(includey?0:1)]);
      translate([-24,-5,0-(includey?0:1)]) cube([41.6,10+pipe_diameter,22+(includey?0:1)]);
      translate([-24,-43.72,0-(includey?0:1)]) mirror([0,0,1]) rotate([0,90,0]) linear_extrude(41.6) {
        if(includey)
          hull() {
            square([21,40]);
            translate([24,11]) circle(d=22,$fn=60);
          }
        else translate([0,30]) square([23,10]);
      }
      translate([33,0,-(includey?0:1)]) rotate([0,0,90]) cube([30,16,22+(includey?0:1)]);
    }
    translate([20,0]) for(pos=[[0,7.305,10.975],[0,-32.711,24]]) translate(pos) rotate([0,-90]) cylinder(d=8.15,h=50,$fn=36);
  
    translate([40,0,-1.01]) scale([.9,1.2]) cylinder(d=50,h=25.02,$fn=60);
    mirrorx() translate([40,29+pipe_diameter/2,-2]) rotate([0,0,80]) cube([10,30,30]);
    mirrorx() translate([35,-10+pipe_diameter,-2.01]) rotate([0,0,-10]) cube([10,22,25.02]);
    mirrorx() translate([pipe_diameter/2,pipe_diameter-2,-2.01]) rotate([0,0,-20]) mirror([1,0]) cube([7,22,25.02]);
    translate([0,18.2+pipe_diameter/2,-2.01]) cylinder(d=pipe_diameter+6,h=25,$fn=60);
    translate([-4,-5,-2.01]) cube([9,30,25]);
    translate([.2,7.3+11+(pipe_diameter/2),10.98]) {
      for(r=[30,150]) rotate([0,0,r]) translate([11+pipe_diameter/2,0]) rotate([90,0]) mirror([0,0,r==30?0:1]) translate([0,0,17.6]) cylinder(d1=22,d2=24,h=10,$fn=40);
      rotate([0,0,-90]) rotate([-90,0]) translate([11+pipe_diameter/2,0,0]) translate([0,0,17.4]) cylinder(d=22,h=40,$fn=40);
      for(r=[-90:120:160]) rotate([0,0,r]) translate([11+(pipe_diameter/2),r==30?0:-.8]) rotate([90,0]) translate([0,0,-24]) {
      cylinder(d=8,h=50,$fn=40);
      }
    }
  }
  if(includey) translate([17.6,-32.711,24]) rotate([0,90,0]) bearing_lip();
   translate([.2,7.3+11+(pipe_diameter/2),10.98]) for(r=[-90:120:160]) rotate([0,0,r]) translate([11+(pipe_diameter/2),r==30?0:-.6]) rotate([90,0]) translate([0,0,-4]) {
    for(m=r==-90?[0,1]:(r==30?[1]:[0])) translate([0,0,r!=-90?3.5:3.10]) mirror([0,0,m]) translate([0,0,-1.5-(r!=-90?3.5:3.1)]) bearing_lip();
  }
  %translate([.2,7.3+11+(pipe_diameter/2),10.98]) {
    translate([0,0,-20]) cylinder(d=pipe_diameter,h=57,$fn=80);
  for(r=[-90:120:160]) rotate([0,0,r]) translate([11+(pipe_diameter/2),r==-90?-.2:0]) rotate([90,0]) translate([0,0,-4]) {
        *bearing_skin();
        linear_extrude(7) difference() { circle(d=22,$fn=50); circle(d=8,$fn=30); }
  }
      }
    }
}
module bearing_lip(id=8,h=2)
{
  difference() {
      union(){
        translate([0,0,-1]) cylinder(d=id+4,h=h-1,$fn=60);
        translate([0,0,h-2]) cylinder(d1=id+4,d2=id+3,h=1,$fn=60);
      }
      translate([0,0,-1.1]) cylinder(d=id,h=h+1.2,$fn=40);
      translate([0,0,h-2-.01]) cylinder(d1=id,d2=id+.5,h=1.42,$fn=50);
    }
}
module bearing_skin()
{
  difference() {
    rotate_extrude($fn=100) difference() {
      square([13,8]);
      translate([0,.5]) square([11,8]);
      translate([12+25.4/2,4]) circle(d=25.4,$fn=100);
    }
    translate([0,0,-.01]) cylinder(d=18,h=1.02,$fn=60);
  }
}
module slider()
{
  translate([0,inches(1)+20+slide_close,24]) rotate([0,0,90]) translate([-25,0]) rotate([-90,0]) import("SC20UU.stl");
}
module support_plate(v=2)
{
  if(v==1) {
  translate([0,0,-6]) linear_extrude(5.9) support_plates_2d(2);
  linear_extrude(6) support_plates_2d();
  *translate([rod_dist/2,-2.6,6]) nema17();
  } else if(v==2) {
  translate([0,0,-6]) linear_extrude(10) support_plates_2d(1);
  translate([0,0,4]) linear_extrude(10) support_plates_2d(3);
  }
}
module nema17()
{
    mirror([0,0,1]) {
      cylinder(d=5,h=20,$fn=30);
      cylinder(d=22,h=2,$fn=40);
    }
    color("black") difference() {
      translate([-21.65,-21.65]) cube([42.3,42.3,45]);
      mirrorx() mirrory() translate([15.5,15.5,-.01]) cylinder(d=3.4,h=10,$fn=20);
    }
}
module support_plates_2d(which=1,motor=0,znut=1)
{
  echo("which:",which);
  offdia=(inches(1)-pipe_diameter)/2;
  xo=-1*((wheel_dist/2)-154.1);
  p2w=plate_size[1]+6;
  echo(str("xo:",xo," offdia:",offdia));
  translate([plate_size[1]/2-20-slide_close,0]) mirror([0,0]) difference() {
    translate([p2w*-.5,support_width*-.5])
      rsquare([p2w,support_width],4);
    mirrorx() translate([-1*(plate_size[1]/2-30),0]) {
      translate([0,0]) 
      {
        mirrorx() mirrory() translate([16,16]) circle(d=3,$fn=20);
        if(which<=2)
          circle(d=pipe_diameter);
        else if(which<5)
          translate([-30,-10.25]) square([60,20.5]);
        else if(which==5)
          translate([-15.25,-10.25]) square([30.5,20.5]);
      }
    //mirrorx(rod_dist)
    mirrorx() translate([22.5,0]) {
      circle(d=8,$fn=30);
    }
    }
    translate([0,-2.6]) {
      if(which==2&&znut)
        znut_hole_2d();
      else if(which==3&&znut)
        znut_hole_2d();
      else if(which==4&&znut)
        znut_hole_2d(1);
      else if(which==1&&znut)
        circle(d=22,$fn=40);
      else if(znut)
        circle(d=9,$fn=40);
      else
        circle(d=(which==2?20:22),$fn=40);
      if(motor)
      mirrorx() mirrory() translate([15.5,15.5]) circle(d=which==3?6:3,$fn=20);
    }
  }
}
module support()
{
  linear_extrude(6) support_plate_2d();
  difference() {
    translate([-16,-10,5.99]) cube([32,20,40]);
    translate([0,-10.1,24]) rotate([-90,0]) cylinder(d=20.4,h=20.2,$fn=40);
    translate([-1,-10.1,26]) cube([2,20.2,20]);
    translate([-16.1,0,39]) rotate([0,90]) {
      cylinder(d=6,h=32.2,$fn=30);
      cylinder(d=10,h=6,$fn=30);
    }
  }
}
module support_plate_2d()
{
  difference() {
    translate([-30,-10]) square([60,20]);
    for(m=[0,1]) mirror([m,0]) translate([22.5,0]) circle(d=25.4/4,$fn=30);
  }
}

module slide_holes(single=0)
{
  if(single)
  {
    for(x=[-20,20],y=[-20,20]) translate([x,y]) circle(d=6,$fn=40);
  } else {
  mirrorx(plate_size[0]) mirrory(plate_size[1]) for(x=[0,40],y=[0,40]) translate([x+slide_close,y+slide_close]) circle(d=6,$fn=40);
  }
}
module router_funnel()
{
  linear_extrude(2,convexity=3) translate(plate_size/-2) router_plate_2d(which=4,cutout=1);
  translate([0,0,1.99]) difference() {
    rotate_extrude($fn=100) difference() {
      translate([13+7,0]) {
        square([2.5,15]);
        square([7.5,5]);
        translate([1.25,15]) circle(r=1.25,$fn=20);
      }
      translate([20.5+7,5]) circle(r=5,$fn=40);
    }
  }
}
module router_plate_2d(vac=0,which=1,cutout=1,dw660=0,makita=1,plasma=1,wing=0)
{
  difference() {
    union(){
      //#translate([88.9,97.6]) import("LowRider2_CNC_-_Full_Sheet_Capable_CNC_Router-_25.4mm/files/611_plate_2.DXF");
      intersection() {
        if(which==2)
          translate([0,plate_size[1]/2-40]) rsquare([128,80],4);
        else if(which==3||which==5)
          translate([49,plate_size[1]/2-40]) rsquare([80+(which==3?6:0),80]);
        else if(which==4||which==5)
          translate([55,plate_size[1]/2-34]) rsquare([68,68]);
        union() {
          //rsquare(plate_size,slide_close);
          rsquare(plate_size,2.5);
          for(m=[0,1]) translate([0,plate_size[1]/2]) mirror([0,m]) translate([0,-plate_size[1]/2])
            translate([plate_size[0]/2-35,-10-(wing==3||wing==m+1?50:0)]) rsquare([70,25+(wing==3||wing==m+1?50:0)]);
        }
      }
      if(which==3)
        translate(plate_size/2) 
          mirrorx() mirrory() translate([35,35]) circle(d=10,$fn=30);
      *translate([-20,plate_size[1]/2-50]) rsquare([30,100]);
    }
    translate(plate_size/2)
    *for(x=[-20,-32],y=[-8,0,8]) translate([x,y]) circle(d=dw660?5:(which==3?6.2:3),$fn=which==3&&!dw660?6:20);
    slide_holes();
      
    *translate([18,5]) for(x=[0,15,55,155],y=[0,50]) translate([x,y]) {
      circle(d=cutout?3:6,$fn=20);
    }
    translate(plate_size/2) {
      if(plasma) // plasma
      translate([plasmoff,0]) {
        circle(d=33,$fn=80);
        mirror([1,0]) for(y=[-25,25],x=[-15,30,140]) translate([x,y]) circle(d=4,$fn=20);
        }
      if(vac) {
        translate([-60,0]) circle(d=40,$fn=60);
        if(vac==1)//&&which==3)
        {
          *hull() {
            circle(d=26,$fn=80);
            translate([-12.5,0]) circle(d=26,$fn=80);
          }
          translate([-60,-10.1]) square([60,20.2]);
        }
        *mirrory() translate([-46.9,35]) circle(d=4,$fn=20);
      }
        if(cutout) translate([-60,0]) {
          mirrorx() mirrory() translate([20,22]) circle(d=((vac==0&&which>=2)?8:4)+(which==3?1:0),$fn=20);
          if(which==3)
          {
            circle(d=46,$fn=80);
            mirrorx() mirrory() hull() {
              translate([20,22]) circle(d=10,$fn=20);
              circle(d=32,$fn=60);
            }
          }
        }
      if(vac==1) {
        hull() {
          //translate([-81,0]) circle(d=10,$fn=30);
          translate([-60,0]) circle(d=40,$fn=60);
          //mirrory() translate([-64,18]) circle(d=12,$fn=30);
          //translate([-40,-19]) square([1,38]);
        }
        *translate([-40,-19]) square([30,38]);
      }
      if(makita) for(r=[0,180]) rotate([0,0,r]) {
        makita_mount();
        if(which!=3) circle(d=40,$fn=80);
      }
      else if(dw660) rotate([0,0,90]) dw660_mount();
      else if(!plasma) {
      circle(d=18,$fn=80);
      *circle(d=50,$fn=80);
      mirrorx() mirrory() translate([30,30]) rotate([0,0,15]) circle(d=4.1,$fn=30);
      }
      //if(which>=3)
      if(!plasma) mirrorx() mirrory() translate([35,35]) circle(d=4,$fn=30);
    }
    mirrory(plate_size[1]) translate([plate_size[0]/2,0]) mirrorx() translate([25,5]) circle(d=4,$fn=20);
    if(which==3&&!dw660&&!makita)
      translate(plate_size/2) mirrorx() mirrory() translate([23.5,23.5]) circle(d=which==3?8:4,$fn=30);
  }
  *translate(plate_size/2) dw660_mount();
}
module vac_attach(vac_id=28)
{
  difference() {
    union() {
      cylinder(d=44,h=2,$fn=80);
      cylinder(d=vac_id+2,h=8,$fn=80);
      translate([0,0,8]) cylinder(d1=vac_id+2,d2=vac_id,h=10,$fn=80);
      translate([0,0,18]) cylinder(d=vac_id,h=20,$fn=80);
      cylinder(d=vac_id+8,h=4,$fn=80);
      linear_extrude(4) mirrorx() mirrory() hull() {
        translate([20,22]) circle(d=8,$fn=20);
        circle(d=30,$fn=60);
      }
    }
    translate([-18,-29.01,4.01]) {
      cube([36,8,30]);
      translate([0,8,30]) mirror([0,1,0]) rotate([-40,0]) cube([36,8,10]);
      intersection(){
        translate([0,12,32]) rotate([40,0]) cube([38,10,30]);
        translate([18,29.01,-4.01]) cylinder(d=40,h=100,$fn=60);
      }
    }
    translate([0,0,40]) cylinder(d=vac_id-4,h=100,$fn=60);
    translate([0,0,-.01]) linear_extrude(100,convexity=3) {
      mirrorx() mirrory() translate([20,22]) circle(d=4,$fn=20);
      difference(){
      circle(d=vac_id-4,$fn=60);
        translate([-20,-20]) square([40,2]);
      }
    }
  }
}
module makita_mount()
{
  rotate([0,0,180])
  translate([0,0]) {
  *circle(r=44.5,h=5.48,$fn=100);
  *circle(r=15.25,h=5.5,$fn=60);
    circle(d=26,$fn=60);
   translate([-28,-26]) circle(d=4.2,$fn=30);
   translate([28,-26]) circle(d=4.2,$fn=30);
   translate([-27,19]) circle(d=4.2,$fn=30);
   translate([27,19]) circle(d=4.2,$fn=30);
  }
}
module dw660_mount()
{
  circle(d=35,$fn=50);
  translate([-16,-25]) square([32,23]);
  translate([24,0]) circle(d=6,$fn=30);
  translate([-24,0]) circle(d=4,$fn=25);
  mirrorx() mirrory() translate([23.5,23.5]) circle(d=4.2,$fn=30);
  *mirrorx() mirrory() translate([30,30]) circle(d=4,$fn=20);
  mirrorx() mirrory() hull() { circle(d=5,$fn=30); translate([27.5,13.25]) circle(d=5,$fn=30); }
  intersection() {
    circle(d=52,$fn=60);
    polygon([[0,0],[-27,13],[-27,30],[27,30],[27,13]]);
  }
}
module mirrorx(off=0)
{
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off=0)
{
  translate([0,off/2,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,off/-2,0]) children();
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
module rcube(dims,r=5,$fn=30)
{
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
module extrusion(length,size=40) {
  linear_extrude(length) extrusion_profile(size);
}
module extrusion_profile(size=40) {
  difference() {
    translate([-size/2,-size/2]) rsquare([size,size],3);
    for(r=[0:3]) rotate([0,0,r*90]) translate([-size/2,-size/2])
    polygon([[15,-.01],[15,5.5],[10,5.5],[10,7.5],[15,12.5],[25,12.5],[30,7.5],[30,5.5],[25,5.5],[25,-.01]]);
  }
}

function inches(in) = 25.4 * in;