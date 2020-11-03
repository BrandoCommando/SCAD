part="belt_clamp"; // [plate,bracket,top,big,small,tpsb,tpsb2,tpsb3,tpsb4,tpss,small_pulley,big_pulley,fan_mount,belt_clamp,zstop,zstop2,hbracket,all]
gear_type="straight";
teeth_type="MK7"; // [MK7,MK8,M8_Bolt]
extruder="robo";
standard_gear = false;
geardist=pow(1800,.5);
gear_pitch=4.50;
gear_theight=3;
gear_twfactor=.22;
gear_height=8;
middle_height=15;
biggear_teeth=40;
smallgear_teeth=10;
boltd=3;
round_teeth=gear_type=="herringbone";
screwd=3.5;
small_set_type=0;
set_screws=3;
allow_slopes=0;
skip_nuts=1;
hemera=extruder=="hemera";
cw=107.5;
ch=48.5+(hemera?30:0);
bod=23.5; // bearing bracket outer diameter
bid=15.8; // bearing bracket inner diameter
clh=8; // carriage leg hole height
screwd=3.5;
screwd2=5;
hw1=50; // hole 1 width
seatw=49;
seath=24;
plate_height=5;
  bscale=1.04;
  mnx=14;
  mny=35;
  mnh=6;
  mnod=8.5;
  cp_type=1;
  cp_screwd=cp_type==1?7.2:screwd;
  cp_screwh=3;
  cp_holeh=cp_type==0?26:22;
  plate_bridge=1.6;
  fan_holes=0;
  hemera_xoff=(hemera?-6:0);
  hemera_yoff=(hemera?4:6);
  bury=4;
  solid=1;
include <HexMount.scad>;
include <GT2Pulley.scad>;

if(part=="all") {
  translate([40,50,16]) rotate([0,0,270]) rotate([0,-90,0]) translate([50,0,-7]) import("ZProbe_Preview.stl");
  carriage_plate();
  fan_mount();
  belt_clamp();
  translate([0,0,-4.8]) {
    %servo();
    for(x=[0],y=[0,1])
      translate([40+x*28,6.5+y*35]) {
        translate([0,0,36]) mirror([0,0,1]) rotate([0,0,(y==0?(x>0?0:-4):(x>0?-4:0))]) {
          small_gear(true,false);
          *translate([0,0,-9]) small_pulley();
        }
        %translate([0,0,-2]) cylinder(d=3,h=50,$fn=8);
      }
    *translate([5,24,36]) rotate([0,0,6]) mirror([0,0,1])   big_gear();
    translate([5,24,44]) rotate([0,0,0]) mirror([0,0,1]) big_pulley();
    top_plate();
    for(x=[0,]) {
      translate([x,0])
        top_plate_support_big();
    }
    translate([cw/2,0]) top_plate_support_big4();
  }
  %for(x=[0,1])
    translate([40+x*28,24]) cylinder(d=3,h=50,$fn=20);
  %for(x=[0,1])
    translate([40+x*28,ch/2,5]) rotate([0,0,90]) hexagon_seat();
} else if(part=="gears") {
  translate([5,24,36]) rotate([0,0,6]) mirror([0,0,1])   big_gear();
    for(x=[0],y=[0,1])
      translate([40+x*28,6.5+y*35]) {
        translate([0,0,36]) mirror([0,0,1]) rotate([0,0,(y==0?(x>0?0:-4):(y>0?10:0))]) {
          small_gear(true,false);
          *translate([0,0,-9]) small_pulley();
        }
        %translate([0,0,-2]) cylinder(d=3,h=50,$fn=8);
      }
} else if(part=="bracket") {
  rotate([90,0]) carriage_bearing_bracket(24,2);
} else if(part=="pipelock") {
  pipelock();
} else if(part=="hbracket") {
  rotate([90,0]) translate([-38,0]) hemera_bracket();
} else if(part=="plate") {
  translate([-4,0]) rotate([0,180]) carriage_plate();
} else if(part=="big") {
  rotate([180,0]) big_gear();
} else if(part=="small") {
  rotate([180,0]) small_gear();
} else if(part=="top") {
  top_plate();
} else if(part=="tpsb") {
  rotate([0,90,0])
  top_plate_support_big();
} else if(part=="tpsb2") {
  rotate([0,90]) top_plate_support_big2();
} else if(part=="tpsb3") {
  rotate([0,90]) {
    top_plate_support_big();
    *translate([0,-10,14]) difference() {
      translate([-4,-8,-4]) cube([8,8,18]);
      rotate([90,0]) for(x=[0:5:10]) translate([0,x,0]) cylinder(d=3,h=8.02,$fn=30);
    }
  }
} else if(part=="tpsb4") {
  rotate([0,90,0])
  {
  top_plate_support_big4();
  }
} else if(part=="zstop") {
  rotate([-90,0]) zstop();
} else if(part=="zstop2") {
  zstop2();
} else if(part=="tpss") {
  top_plate_support_small();
} else if(part=="servo") {
    rotate([0,90]) servo();
} else if(part=="small_pulley") {
  small_pulley();
} else if(part=="big_pulley") {
  mirror([0,0,1]) big_pulley();
} else if(part=="fan_mount") {
  rotate([90,0])
  fan_mount();
} else if(part=="belt_clamp") {
  belt_clamp();
  *translate([0,10]) belt_clamp(1);
}
module belt_clamp(smooth=0) {
  bt=smooth?2:4;
  bch=ch-20;
  bcw=bod+8;
  translate([cw-bod-4,10,plate_height]) difference(){
    //translate([1,0,.01]) cube([bcw-2,bch,4]);
    translate([1.5,2.5,.01]) cube([bcw-3.5,7,bt]);
    for(y=[0,8,-8],x=[4,bcw-4.5])
    translate([x,14+y]) cylinder(d=3,h=5,$fn=40);
    for(x=[7.5,16.5]) translate([x,-.02,bt-.5]) cube([7.4,bcw+.02,2]);
    if(!smooth)
    for(x=[7.5,16.5],y=[.4-1:2:bch-.4])
      translate([x,y,bt-1.25]) cube([7.4,1.2,2]);
  }
}
module fan_mount() {
  fmw=cw-bod*2+10;
  union(){
  for(x=[bod-5,cw-bod-5])
    translate([x,0]) {
      translate([0,-1,plate_height-4]) difference(){
        translate([0,-2,-1]) cube([10,13,5]);
        translate([5,7,-2.01]) cylinder(d=3.4,h=15.02,$fn=24);
        *translate([5,5,2.01]) cylinder(d=nutd,h=3,$fn=6);
      }
    }
    translate([bod/2+20,-2.99,plate_height-48]) rotate([0,90]) linear_extrude(44) union() {
      //hull()
      {
      square([2,12]);
      translate([0,11]) rotate([0,0,10]) square([2,8]);
      }
      square([7,2]);
      translate([2,2]) intersection() {
        square([5,5]);
        difference() {
          square([5,5]);
          translate([5,5]) circle(r=5,$fn=24);
        }
      }
    }
    difference(){
      translate([bod-5,-2.99,plate_height-48]) cube([fmw,2.9,48]);
      for(x=[(bod-5)+(fmw/2-16),(bod-5)+(fmw/2+16)],z=[-3,-35])
        translate([x,2,z]) rotate([90,0]) cylinder(d=3,h=5,$fn=24);
      translate([bod-5+fmw/2,2,-19]) rotate([90,0]) cylinder(d=36,h=5,$fn=100);
      for(x=[bod/2,cw-bod/2]) translate([x,2,-20]) rotate([90,0]) cylinder(d=40,h=5,$fn=100);
      translate([bod/2,-3.01,-50]) cube([20,5,30]);
      translate([cw-bod/2-20,-3.01,-50]) cube([20,5,30]);
      translate([cw/2-25,-3.01,0]) cube([50,4,10]);
    }
  }
}
module big_pulley() {
  difference() {
    teeth=75;
   pulley ( "GT2 2mm" , tooth_spacing (2,0.254,75) , 1.969 , 3.952, 12 );
    translate([0,0,-.01]) cylinder(d=30,h=6.5,$fn=20);
    translate([0,0,6.4]) servo_blade();
  }
}
module small_pulley() {
  teeth=28;
  pulley ( "GT2 2mm" , tooth_spacing (2,0.5715,teeth) , 1.969 , 3.952, 12, idler = 1);
}
module top_plate_support_big(sw=8,nr=0,cb=1,servo=1){
  translate([sw*-.5-1,0]) difference(){
    translate([servo?-32:1,-10,8]) cube([(servo?32:0)+sw,ch+20,39]);
    if(servo)
    {
      translate([-1*(sw*-.5-1),0]) for(x=[0,cw-.5,bod,cw-bod],y=[0,8,-8])
       translate([x,24+y,-.01])
         screwhole(chamfer="top",h=16.02);
      translate([1,-10.01,9]) mirror([1,0]) rotate([0,45,0]) {
        cube([30, ch+20.02, 43.8]);
        rotate([0,45]) cube([10,ch+20.02,10]);
        rotate([0,45]) translate([-31,0,31]) cube([10,ch+20.02,10]);
      }
  translate([-29-(sw*-.5-1),14,38]) {
    translate([-.5,-.25,1]) {
      
      for(x=[-3.5,44.5],y=[5,14.5])
        translate([x,y,-5]) cylinder(d=3,h=15,$fn=30);
    }
  }

    }
    if(servo)
      translate([-8,8,10]) cube([20,32.4,6]);
    translate([-4,-.6,5])
        cube([cw+8,ch+1.2,5.1]);
    *translate([7,24,15]) cylinder(d=62,h=25,$fn=100);
    translate([-7-62/2,24.2-62/2,15]) cube([62+14,62,25]);
    translate([-34,-.1,45]) cube([60,ch+.2,2.02]);
    if(servo)
      servo(0);
    for(y=[4,ch-4],x=[1:-10:-30])
    {
      translate([x+sw/2,y,24.99]) cylinder(d=3.2,h=50,$fn=20);
      *if(sw>6.4) translate([x+sw/2,y,39.99]) rotate([0,0,nr-30]) cylinder(d=6.5,h=3,$fn=6);
    }
    for(y=[4,ch-4])
    {
      if(cb||y!=ch/2)
      translate([1+sw/2,y,4.99]) {
        cylinder(d=3.2,h=20,$fn=20);
        *if(sw>6.4) translate([0,0,7.02]) rotate([0,0,nr-30]) cylinder(d=6.5,h=3,$fn=6);
      }
    }
  }
}
module top_plate_support_big2() {
  #difference() {
      top_plate_support_big(6.4,cb=0,servo=0,nr=0);
      translate([0,ch/2,30]) cylinder(d=3.2,h=20,$fn=20);
      #translate([-4,8.25,8]) cube([10,32,10]);
      *for(x=[0,28])
      translate([x-2,-.3]) rotate([0,0,90]) linear_extrude(20) polygon([[0,7],[9,-1],[9,-2.5],[seatw-9,-2],[seatw,7],[seatw,seath-7],[seatw-9,seath+1],[seatw-9,seath+2.5],[9,seath+2],[0,seath-7]]);
  }
}
module top_plate_support_big4() {
  soltop=1;
  difference(){
    union(){
      top_plate_support_big2();
      if(soltop)
      {
        translate([-3.2,-13,0]) cube([6.4,9,23.5]);
      } else
      translate([-3.2,-10,0]) cube([6.4,4,10]);
    }
  if(soltop)
    #translate([-5,-8.5,19])
      rotate([0,0,-90]) rotate([-90,0]) for(y=[0,15]) translate([0,y]) cylinder(d=3,h=10,$fn=20);
  else
  translate([0,-10.01,19])
    rotate([-90,0]) for(y=[0,15]) translate([0,y]) cylinder(d=3,h=10,$fn=20);
  }
  if(soltop)
    translate([3.2,-15.1,0]) solenoid();
  else
    %translate([-6.55,-25.3,0]) cube([13.1,15.3,29.5]);
}
module zstop2() { // servo-based z-stop helper
  
}
module solenoid() {
  difference(){
    cube([15.3,13.1,29.5]);
    translate([7.65,6.55,-.01]) cylinder(d=4,h=30,$fn=30);
  }
  translate([7.65,6.55,-6.3]) cylinder(d=3,h=10,$fn=24);
  zstop();
}
module zstop() {
  h=19;
  translate([1.65,0.65,-50]) difference(){
    union(){
    translate([1,1,49-h]) cube([10,10,h]);
    translate([-4,5,49-h]) cube([20,6,10]);
    }
    translate([.99,10,57-h]) cube([10.02,1.02,5]);
    for(x=[-.5,12.5])
    translate([x,-1,54-h]) rotate([-90,0]) {
      cylinder(d=3,h=20,$fn=20);
      translate([0,0,-1]) rotate([0,0,30]) cylinder(d=7.1,h=10,$fn=6);
    }
    translate([6,6,40]) cylinder(d=3,h=10,$fn=20);
    translate([6,6,43]) rotate([0,0,90]) cylinder(d=7.1,h=3.2,$fn=6);
    translate([2.95,-.01,43]) cube([6.125,6,3.2]);
  }
}
module top_plate_support_small(){
    translate([cw/2,24,5]) rotate([0,0,0]) translate([-1.25,-2,0]) cube([3,4,42]);
  translate([cw/2-1.25,0,5]) cube([3,ch,5]);

}
module top_plate(nr=0) {
  xex=2;
  intersection(){
    translate([-36-xex,0,45]) linear_extrude(10) {
      translate([2,0]) square([cw-(18-xex),ch]);
      for(x=[2,cw-16+xex],y=[2,ch-2])
        translate([x,y]) circle(d=4,$fn=20);
      translate([0,2]) square([cw-(14-xex),ch-4]);
    }
  difference(){
    union(){
      translate([-38-xex,0,45]) cube([cw+64,ch,4]);
      for(x=[0,1],y=[0,1]) translate([40+x*28,6.5+y*35,46]) { 
      cylinder(d=13,h=6,$fn=30);
    }
    }
    sw=8;
    translate([sw*-.5-1,0]) for(y=[4,ch-4],x=[1:-10:-30])
    {
      translate([x+sw/2,y,24.99]) cylinder(d=3.2,h=50,$fn=20);
      if(sw>6.4) translate([x+sw/2,y,39.99]) rotate([0,0,nr-30]) cylinder(d=6.5,h=3,$fn=6);
    }
    translate([cw/2,ch/2,4.99]) cylinder(d=3.2,h=50,$fn=20);
    for(y=[4,ch-4]) {
      translate([cw/2,y,4.99]) cylinder(d=3.2,h=50,$fn=20);
    for(x=[0,11.5,23])
    {
        translate([x,y,4.99]) cylinder(d=3.2,h=50,$fn=20);
      translate([cw-x,y,4.99]) cylinder(d=3.2,h=50,$fn=20);
    }
    }
    translate([-1*xex,0]) servo();
    *translate([cw/2,0]) mirror([1,0]) translate([-1*(cw/2),0]) servo();
    for(x=[0,1],y=[0,1]) translate([40+x*28,6.5+y*35,46]) { 
      translate([0,0,-5]) cylinder(d=4,h=10,$fn=20); 
      translate([0,0,4]) cylinder(d=10.2,h=50,$fn=20);
    }
    for(x=[0,1]) translate([40+x*28,24,40]) cylinder(d=x==0?7:4,h=20,$fn=20);
    *for(y=[-5,ch+5])
    translate([7,y,45.01]) rotate([0,0,0]) { cylinder(d=6.7,h=2,$fn=6); translate([0,0,-2]) cylinder(d=screwd,h=5,$fn=20); }
    *translate([cw/2,24,44]) {
      cylinder(d=6.7,h=2,$fn=6);
      cylinder(d=screwd,h=5,$fn=20);
    }
  }
}
}
module servo(full=1) {
  translate([-25,14,38]) {
    translate([-.5,-.25,1]) {
      
      translate([(full?0:1)-.5,-.5]) cube([42,21,40]);
      translate([30,10,-4]) cylinder(d=6,h=4,$fn=20);
      translate([-7,0,9]) cube([55,20,3]);
      for(x=[-3.5,44.5],y=[5,14.5])
        translate([x,y,0]) cylinder(d=3,h=15,$fn=30);
    }
  }
}
module big_gear() {
  difference(){
   gear((biggear_teeth*gear_pitch)/PI,gear_height,gear_pitch,theight=gear_theight,rod=0,gear_twfactor=gear_twfactor);
    translate([0,0,-.01]) servo_blade();
  }
}
module small_gear(center=false,standard=false)
{
  translate(center?[]:[0,0,12]) rotate(center?[]:[0,0,21]) difference(){union(){
       gear((smallgear_teeth*gear_pitch)/PI,gear_height+2,gear_pitch,theight=gear_theight,rod=0,gear_twfactor=gear_twfactor);
       *cylinder(d=8,h=gear_height+2);
    }
    *translate([0,0,-.01]) cylinder(d=5.7,h=10.02,$fn=60);
  }
  translate(center?[0,0,-12]:[]) difference(){
    union(){
      translate([0,0,4]) cylinder(d=19,h=6,$fn=40);
      translate([0,0,10]) cylinder(d1=19,d2=15,h=4,$fn=40);
      translate([0,0,12]) cylinder(d=10,h=gear_height,$fn=30);
    }
    //translate([0,0,12]) cylinder(d=5.7,h=11);
    
    if(small_set_type==2)
    {
      difference(){
        cylinder(d=5.7,h=30,$fn=60);
        translate([2.2,-3,-.01]) cube([6,6,30.02]);
        rotate([0,0,90]) translate([2.2,-3,-.01]) cube([6,6,30.02]);
      }
      for(r=[0:-90:-90])
        rotate([0,0,r]) {
        translate([0,10,8]) rotate([90,0]) {
          cylinder(d=3.2,h=8,$fn=20);
          translate([0,0,2.5]) rotate([0,0,30]) cylinder(d=7,h=3,$fn=6);
        }
        translate([-3,4.5,3.99]) cube([6,3,4]);
      }
      //rotate(
    } else {
      cylinder(d=boltd+.2,h=30,$fn=20);
      for(r=[0:set_screws-1]) {
        rotate([0,0,r*(360/set_screws)]) {
          translate([0,10,8]) rotate([90,0]) {
            cylinder(d=3.2,h=9,$fn=20);
            translate([0,0,10/2-boltd/2]) rotate([0,0,30]) cylinder(d=7,h=3,$fn=6);
          }
          translate([-3,10/2-boltd/2,3.99]) cube([6,3,4]);
          //translate([-3,4.5,3.99]) cube([6,3,4]);
        }
      }
    }
  }
}
module tooth(pitch,theight,gear_twfactor,type,d,h,clock=true)
{
      hangle=clock?30:-30;
      tt=pitch*gear_twfactor;
      tr=theight;
      translate([.5,tt])
      {
        if(type=="straight")
          linear_extrude(h){
            //translate([tr-.5,0]) circle(1,$fn=20);
            //difference()
        {
            polygon([for(i=[30:5:150]) [tr*(.5+sin(i*-3)/2)*1.1,tt*1.5*cos(i)]]);
            }
          }
        else if(type=="herringbone")
        {
            intersection(){ cylinder(d=40,h=h/2);
            translate([0,0,h*.25]) rotate([hangle,0]) translate([0,0,h*-.5]) linear_extrude(h) polygon([for(i=[30:10:150]) [tr*(.5+sin(i*-3)/2)*1.1,tt*2*cos(i)]]);
            }
            intersection(){ translate([0,0,h/2])cylinder(d=40,h=h/2);
              translate([0,0,h*.75]) rotate([-1*hangle,0]) translate([0,0,h*-.4]) linear_extrude(h) polygon([for(i=[30:10:150]) [tr*(.5+sin(i*-3)/2)*1.1,tt*2*cos(i)]]);
            }
        } else if(type=="helical")
        {
          intersection(){ cylinder(d=40,h=h);
              translate([0,0,h*.25]) rotate([hangle,0]) translate([0,0,h*-.5]) linear_extrude(h*2) polygon([for(i=[30:10:150]) [tr*(.5+sin(i*-3)/2)*1.1,tt*2*cos(i)]]);
              }
        }
        /*linear_extrude(h) polygon([
        [0,tt*2],[tr*.2,tt*1.3],[tr*.4,tt],
        [tr*.6,tt],[tr*.75,tt*.75],[tr*.95,tt*.3],
        [tr,0],
        [tr*.95,tt*-.3],[tr*.75,tt*-.75],[tr*.6,tt*-1],
        [tr*.4,tt*-1],[tr*.2,tt*-1.5],[0,tt*-2]]);
        */
        //if(t==0) translate([tr-.5,0,h]) sphere(.5,$fn=10);
      }
}
module gear(d,h,pitch,theight=3,rod=1,bearing=0,set_hole=0,holes=0,bolt_head=0,type=gear_type,gear_twfactor=gear_twfactor)
{
  teeth=(PI*d)/pitch;
  tdeg=360/teeth;
  echo(str("Teeth: ", teeth, " @ ", tdeg));
  //intersection()
  union()
  {
    //  translate([0,0,-20]) sphere(d=d+21,$fn=80);
  difference(){
    union(){
  difference(){
    union(){
    rotate([0,0,tdeg]) cylinder(d=d+1,h=h,$fn=teeth*4);
      *if(d>50)
        cylinder(d=28,h=middle_height,$fn=teeth*4);
    }
    if(d>50)
    {
      translate([0,0,4]) ring(od=d-6,id=28,h=h,$fn=80);
//      translate([0,0,7]) cylinder(,h=h,$fn=60);
    }
    translate([0,0,-0.01]) cylinder(d=bearing?22.2:boltd+.2,h=middle_height+0.02,$fn=60);
    if(bolt_head==1) {
      translate([0,0,-0.01]) cylinder(d=12.2,h=3,$fn=6);
      translate([0,0,2.98]) cylinder(d1=12.2,d2=8,h=4.2,$fn=6);
    }
  }
  if(rod!=0)
    translate([0,0,rod<0?rod*30+h:0])
      cylinder(d=8,h=30,$fn=teeth);
  
  clock = d>20;
  for(t=[0:teeth]) {
    {
      rotate([0,0,t*(360/teeth)]) translate([d/2-.1,pitch*-.25,0])
      {
        intersection(){
          rotate([0,0,3.5]) tooth(pitch,theight,gear_twfactor,type,d,h,clock);
//          if(round_teeth)
            translate([theight/-2,(theight/-2)*(clock?-1:0),h/2]) sphere(d=h+8);
        }
      }
    }
  }
}
  translate([0,0,middle_height-h-1]) if(set_hole>0) {
    set_holes=3;
    for(sh=[1:set_holes]) rotate([0,0,(360/set_holes)*sh]) {
      gearh=h;
      //#translate([0,0,-0.01]) cylinder(d=5,h=gearh+0.02);
    translate([0,0,h-3]) rotate([90,0,0]) {
      cylinder(d=screwd,h=d>50?d/3:d);
      translate([0,0,d>50?set_hole+7:set_hole+4]) cylinder(d=6.5,h=6);
      translate([0,0,set_hole+2]) {
        rotate([0,0,30]) cylinder(d=6.5,h=2.4,$fn=6);
        translate([-2.75,0,0]) cube([5.5,6.1,2.4]);
      }
    }
  }
  }
  if(holes>0)
  {
    deg=360/holes;
    for(hole=[1:holes])
    {
      rotate([0,0,deg*hole]) translate([d/4+5,0,-0.01]) cylinder(d=d/holes,h=h+0.02,$fn=d/4);
    }
  }
  }
}
}
module hemera_model(flip=0) {
  translate([24.38,41.51]) rotate([0,0,flip?180:0]) translate([-24.38,-41.51])
  color("yellow") %import("HEMERA-MODEL-1.1.stl");
}
module lm8uu(notch_trim=.1) {
  translate([0,0,3.25+notch_trim]) cylinder(d=14.5,h=24-3.25*2-notch_trim*2,$fn=40);
  mirrorz(24) translate([0,0,-.01]) cylinder(d=15,h=3.25+notch_trim+.02,$fn=40);
  translate([0,0,4.35-notch_trim]) cylinder(d=15,h=15.3+notch_trim*2,$fn=40);
}
module carriage_bearing_bracket(l=48.5,notop=0) {
  //import("CarriageBearingBracket2D.stl");
  footz=17;
  //#translate([23.5/2,0,5]) mirror([0,1]) rotate([90,0]) lm8uu();
  difference() {
    if(notop==2) translate([-3,0,bid-7]) mirror([0,0]) rcube([23.5+6,l,6],2);
    union() {
      if(notop==2) mirrorx(23.5) translate([-3.01,-.01]) cube([7.6,l+.02,bid-4]);
    mirror([0,1,0]) rotate([90,0]) linear_extrude(l,convexity=3) {
      difference() { union() {
        translate([-4,0]) square([23.5+8,notop?5:17]);
        if(!notop) intersection() {
          square([23.5,30]);
          translate([11.75,5]) circle(d=23.5,$fn=50);
        }
      }
      translate([11.75-15.4/2,0]) {
        square([15.4,5]);
        translate([15.4/2,5]) circle(d=14,$fn=40);
      }
    }
    
    }
    *for(x=[0,23.5],y=[4,l-4]) translate([x,y]) cylinder(d=8,h=footz,$fn=30);
  }
  translate([23.5/2,0,5]) mirror([0,1]) rotate([90,0]) scale([bscale,bscale,1]) lm8uu();
  for(x=[0,23.5],y=[4,l-4]) translate([x,y,-.01]) {
    cylinder(d=3,h=footz+.02,$fn=30);
    translate([0,0,footz-.6]) cylinder(d1=3,d2=4,h=.82,$fn=30);
    translate([0,0,footz+.02]) cylinder(d=6,h=20,$fn=30);
  }
}
}
module hemera_bracket(full=1) {
  difference() {
    translate([26,0,-1]) {
      cube2([12,10.56,49],2);
      translate([7.5,0]) cube2([4.5,30,49],2);
    }
    for(z=[4,38]) translate([10,5.8,z+.3]) rotate([0,90]) {
      cylinder(d=3,h=40,$fn=20);
      translate([0,0,10]) cylinder(d=6,h=11,$fn=36);
    }
  }
  *translate([0,0]) difference() {
      translate([0,0]) mirror([0,1]) rotate([90,0]) linear_extrude(10+(full?.56:0)) {
        if(full)
          translate([28,0]) offset(1) square([9,44]);
        else
          offset(1) polygon([[37,1],[37,42+(full?1:0)],[full?5:24.2,42]]);
      }
      translate([19,-.01,38]) rotate([-90,0]) cylinder(d=10,h=12,$fn=50);
      if(!full) translate([-.01,2.5,-.01]) cube([36,8,41+(full?3:0)]);
      for(z=[4,38]) translate([10,5.8,z+.3]) rotate([0,90]) {
        cylinder(d=3,h=40,$fn=20);
        translate([0,0,10]) cylinder(d=6,h=11,$fn=36);
      }
      if(!full) for(x=[27,8]) translate([x,5.8,40]) cylinder(d=3,h=20,$fn=20);
    }
}
module carriage_plate() {
  //carriage_belt_seat(false);
  //translate([50,76,-65])
  //if(part=="preview")
  side_yoff=-7;
  %color("blue") translate([0,hemera_yoff,bury-5]) mirrorx(cw) for(y=[side_yoff+1,ch-24-16]) translate([0,y,0]) mirror([0,0,1]) carriage_bearing_bracket(24,solid?2:1);
  if(hemera) translate([0,-8+hemera_yoff])
  {
    //translate([cw/2+hemera_xoff+.2,24.25+3,-13-50 ])   rotate([0,0,0])
    
    translate([cw/2+hemera_xoff+.2,ch/2-12,-13-50])   rotate([0,0,0])
    translate([-19,52]) rotate([90,0]) hemera_model(1);
    mirrorx(cw) translate([-7,36,-43]) hemera_bracket(solid);
    mirrorx(cw) translate([38-7,36+33]) mirror([0,1,0]) translate([-38,-12,-43]) hemera_bracket(solid);
    %translate([-1,ch/2+side_yoff+4,-6]) rotate([0,0,-11]) {
      cylinder(d=25.4/4,h=12,$fn=30);
      translate([25.4/4,0,12]) rotate([0,0,180]) rotate([90,0]) rotate_extrude(angle=90) {
        translate([25.4/4,0]) circle(d=25.4/4,$fn=30);
      }
      translate([25.4/4,0,12+25.4/4]) rotate([0,90]) cylinder(d=25.4/4,h=25.4*1.5,$fn=30);
    }
  }
  
  difference(){
    union(){
      if(hemera)
      {
        translate([cw/2-22,-4]) rcube([44,ch+8,plate_height],4);
        translate([-4,side_yoff+4]) rcube([cw+8,ch-15-side_yoff,plate_height],2);
        translate([18,10]) rcube([cw-36,ch-10,plate_height],2);
        mirrorx(cw) translate([-1,ch/2+side_yoff,-6]) {
          od=9.5;
          cylinder(d=od,h=6,$fn=50);
          translate([-3,od/-2-6,0]) cube([1.61,od+12,6]);
          translate([-3,od/-2]) cube([4,od,6]);
        }
      } else
      translate([-4,0])
        rcube([cw+8,ch,plate_height],2);
      if(cp_type==0)
      translate([cw/2-mnx, ch/2-mny/2, plate_height])
        for(x=[0:2])
          for(y=[0:1])
            translate([mnx*x,mny*y]) {
              cylinder(d=mnod,h=mnh);
            }
    if(solid)
    translate([0,hemera_yoff]) mirrorx(cw) for(y=[side_yoff+1,ch-24-16]) translate([-3,y,0]) mirror([0,0,1]) difference() {
      rcube([bod+6,23.99,bid+1-bury],2);
      translate([bod/2-bid/2+3.5,-.01,bid/2+2.5-bury]) cube([bid-1,24.02,bid]);
    }
    }
    
    if(hemera)
    {
      mirrorx(cw) translate([-1,ch/2+side_yoff,-6.01]) {
        linear_extrude(plate_height+6.02) hull() {
          circle(d=7,h=plate_height+6.02,$fn=40);
          translate([-10,0]) circle(d=7,$fn=40);
        }
        translate([-10,-10]) cube([6.99,20,10]);
        for(y=[-7.5,7.5]) translate([-.01,y,3]) rotate([0,-90,0]) {
          cylinder(d=3,h=10,$fn=20);
          translate([-3,-3,-1.6]) cube([6,6,3]);
        }
        
      }
      *for(x=[17,-17],y=[ch-4,ch-37]) translate([cw/2+x+7+hemera_xoff,y,-.01]) cylinder(d=3,h=10,$fn=20);
    }
    if(fan_holes)
      for(x=[cw/2-20.5,cw/2+19.5],m=[0,1])
        translate([0,ch*.5]) mirror([0,m,0]) translate([x,ch/-2-.01,plate_height/2]) rotate([-90,0]) cylinder(d=2.5,h=10,$fn=30);

    if(!hemera)
    translate([cw/2-mnx, ch/2-mny/2, 5])
    for(x=cp_type==0?[0:2]:[0,2])
      for(y=[0:1])
        translate([mnx*x,mny*y]) {
          *translate([0,0,cp_type==1?mnh*-1:0]) cylinder(d=nutd,h=mnh+0.01,$fn=6);
          translate([0,0,(plate_height-5)+(cp_type==1?mnh*-1:0)]) cylinder(d=4,h=mnh+0.01,$fn=20);
          if(cp_type==1&&x==0&&!skip_nuts)
          translate([0,0,-5.01]) {
            if(cp_screwd<=6||cp_screwd>=8)
              screwhole(d=cp_screwd,h=cp_screwh);
            else
              cylinder(d=cp_screwd,h=cp_screwh,$fn=6);
          }
          else if(cp_type==0||x==2) {
            translate([0,(2*y-1)*7.5,-5.01]) cylinder(d=screwd2, h=plate_height+.02, $fn=30);
            if(!skip_nuts)
            translate([0,0,-5.01]) cylinder(d=7.2,h=3,$fn=6);
          }
        }

  if(!hemera)
    for(x=[0,cw-.5,bod,cw-bod],y=[0,8,-8])
     translate([x,24+y,-.01])
       screwhole(chamfer="top",h=plate_height+.02);

  translate([cw/2-hw1/2+.5, 0, -0.01]) rotate([0,0,0])
  {
      translate([0,ch/2-cp_holeh/2])
      {
        if(hemera)
        {
          translate([4,0]) linear_extrude(plate_height+.02,convexity=3) offset(4) scale(0.8) {
            translate([0,-20+hemera_yoff]) {
              square([hw1,16]);
              //translate([4,-2]) cube([hw1-23,30,plate_height+.02]);
            }
            translate([5,-4+hemera_yoff]) square([hw1-10,14]);
            translate([13.5+2,12.98+hemera_yoff]) square([hw1-28,10]);
          }
        } else {
        translate([-3.5,0]) cube([hw1+6,cp_holeh,plate_height+.02]);
        translate([cp_holeh*.5-.5,cp_holeh*.5]) cylinder(d=cp_holeh+2,h=plate_height+.02,$fn=60);
        translate([cp_holeh*.5+27.5,cp_holeh*.5]) cylinder(d=cp_holeh+2,h=plate_height+.02,$fn=60);
        translate([cp_holeh,cp_holeh*.5-5]) cube([5,10,plate_height+.02]);
        }
      }
  }
  
//  translate([cw/2-hw1/2,ch/2-hh1/2,-0.01]) cube([hw1,hh1,20]);
//  translate([cw/2-hw2/2,ch/2-hh2/2,-10]) cube([hw2,hh2,30]);
//  translate([cw/2-15,ch/2-20,-10]) cube([30,40,20]);
//  translate([cw/2-15,ch/2,-10]) rotate([0,0,90]) cylinder(d=40,h=40);
//  translate([cw/2+15,ch/2,-10]) rotate([0,0,90]) cylinder(d=40,h=40);
  bx1=bod/2;
  bx2=bx1+84;
  if(hemera)
  {
    if(!solid) mirrorx(107) for(y=[34,34+33.5]) translate([bod-3.5,hemera_yoff+y-.25,-10]){
      translate([0,0,10+plate_height-2.99]) {
        translate([0,0,1]) cylinder(d=nutd,h=3,$fn=6);
        translate([0,0,-1]) cylinder(d1=3,d2=nutd,h=2,$fn=6);
      }
      cylinder(d=3,h=30,$fn=20);
    }
    for(x=[bx1,bx2],y=[side_yoff+1,ch-40]) translate([x,hemera_yoff+y-.01,-10+bury]) rotate([-90,0]) scale([bscale,bscale,1]) lm8uu(); //cylinder(d=bid,h=24,$fn=40);
    for(x=[bx1,bx2]) translate([x,-.01,-10+bury]) rotate([-90,0]) cylinder(d=9,h=ch+4,$fn=40);
      
    translate([0,hemera_yoff]) mirrorx(cw) for(x=[0,bod],y=[side_yoff+5,side_yoff+21,ch-20,ch-20-16]) translate([x,y,-bid/2-4-.01])
    {
      //echo(str("BN:",x,",",y));
      #translate([0,0,-4]) cylinder(d=3,h=20,$fn=20);
      translate([0,0,13]) rotate([0,0,30]) {
        cylinder(d1=3,d2=nutd,h=2,$fn=6);
        translate([0,0,1.99]) cylinder(d=nutd,h=4,$fn=6);
      }
      screwhole();
      if(allow_slopes)
      if(slope)
      {
        translate([0,0,3]) cylinder(d=nutd,h=3,$fn=6);
        translate([0,0,1.01]) cylinder(d2=nutd,d1=screwd,h=2,$fn=6);
      } else
        translate([0,0,2]) cylinder(d=nutd,h=4,$fn=6);
    }
    mirrory(ch) for(x=[-18,0,18]) translate([cw/2+x,ch,-.01]) {
      cylinder(d=6,h=3,$fn=40);
      cylinder(d=3.2,h=plate_height+.02,$fn=20);
    }
  } else {
  translate([0,0]) bracket_nuts(cp_type==0?0:1); // close nuts
  translate([cw-bod,0]) bracket_nuts(cp_type==0?0:1); // far nuts
  for(x=[bx1,bx2],y=[0,ch-24]) translate([x,y-.01,-5]) rotate([-90,0]) cylinder(d=bid,h=24,$fn=40);
  echo(str("Bearing X: ", bx1, ", ", bx2));
  translate([cw/2,4,-.01]) cylinder(d=3.2,h=plate_height+.02,$fn=20);
  translate([cw/2,ch-4,-.01]) cylinder(d=3.2,h=plate_height+.02,$fn=20);
  }
  *translate([bod,ch/2,-.01]) screwhole();
  *translate([cw-bod,ch/2,-.01]) screwhole();
}
  if(plate_bridge&&!hemera)
  translate([cw/2-3, ch/2-cp_holeh/2])
  {
    difference(){
      union(){
        translate([plate_bridge==1?1.5:3-plate_bridge/2,0]) cube([plate_bridge==1?3:plate_bridge,cp_holeh,plate_height]);
        if(plate_bridge==1)
        translate([3,cp_holeh/2]) cylinder(d=6,h=plate_height,$fn=40);
      }
      if(plate_bridge==1)
      translate([3,cp_holeh/2,-.01]) {
        cylinder(d=3.2,h=plate_height+.02,$fn=20);
        //cylinder(d=5.1,h=3,$fn=30);
      }
    }
  }
}
module test_bbracket()
{
  translate([-30.5,4]) difference() {
      rcube([bod+6,23.99,bid-2],2);
      translate([bod/2-bid/2+3.5,-.01,bid/2+2.5]) cube([bid-1,24.02,bid]);
    translate([bod/2+3,-.01,bid/2+2]) rotate([-90,0]) scale([bscale,bscale,1]) lm8uu();
  for(x=[3,bod+3],y=[4,20]) translate([x,y,-.01]) cylinder(d=3,h=20,$fn=20);
    }
}
module pipelock() {
  difference() {
    translate([-12,-4]) rcube([24,8,3],3);
    for(x=[-7.5,7.5]) translate([x,0,-.01]) cylinder(d=3,h=10,$fn=20);
   }
 }
module bracket_nuts(slope=0)
{
    for(x=[0,bod],y=hemera?[4,20,ch-20,ch-20-16,ch-4]:[4,ch-4])
    translate([x,y,-.01])
    {
      //echo(str("BN:",x,",",y));
      screwhole();
      if(allow_slopes)
      if(slope)
      {
        translate([0,0,3]) cylinder(d=nutd,h=3,$fn=6);
        translate([0,0,1.01]) cylinder(d2=nutd,d1=screwd,h=2,$fn=6);
      } else
        translate([0,0,2]) cylinder(d=nutd,h=4,$fn=6);
    }
}
//translate([24,1.5,0]) mount_placeholders("hexagon","v6");
//  translate([29,1.5,0]) cold_plate(false);
module screwhole(d=screwd,h=10,chamfer="bottom",bolthead=0)
{
  chamh=.8;
  chamw=1;
  cylinder(d=d,h=h,$fn=20);
  if(chamfer=="top") {
    if(allow_slopes)
    translate([0,0,h-chamh*2]) cylinder(d1=d,d2=d+chamw,h=chamh, $fn=20);
  } else if(chamfer=="bottom") {
    if(allow_slopes) translate([0,0,bolthead?(min(6,max(3,h-4)))-.01:0]) cylinder(d1=d+chamw,d2=d,h=chamh,$fn=20);
  }
  if(bolthead) {
    cylinder(d=bolthead,h=min(6,max(3,h-4)),$fn=20);
  }
}
module ring(d,id,h)
{
  difference(){
    cylinder(d=d,h=h);
    translate([0,0,-0.01]) cylinder(d=id,h=h+0.02);
  }
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
  *union() {
    translate([0,0,r]) rcube([dims[0],dims[1],dims[2]-r*2],r,$fn);
    mirrorz(dims[2]) translate([0,0,r])
    {
      for(x=[r,dims[0]-r],y=[r,dims[1]-r])
        translate([x,y]) sphere(r=r,$fn=$fn);
      *mirrory(dims[1]) translate([r,r]) rotate([0,90]) cylinder(h=dims[1]-r*2,r=r,$fn=$fn);
    }
  }
}
module servo_blade(sub=0) {
 linear_extrude(2.01) {
       for(r=[0,90]) rotate([0,0,r]) {
         
    circle(d=13,$fn=40);
    translate([17,0]) circle(d=6,$fn=20);
    translate([-17,0]) circle(d=6,$fn=20);
    polygon([[-17,-3],[0,-5.5],[17,-3],[17,3],[0,5.5],[-17,3]]);
    }
  }
  if(sub!=0) {
    for(x=[7.5:3:16.5],r=[0:90:360]) rotate([0,0,r])
    translate([x,0,-10]) cylinder(d=2,h=20,$fn=20);
  }
}
module mirrorx(off=0)
{
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([-off/2,0]) children();
}
module mirrory(yoff=0)
{
  translate([0,yoff/2]) for(m=[0,1]) mirror([0,m]) translate([0,-yoff/2]) children();
}

module mirrorz(off=0)
{
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,-off/2]) children();
}
