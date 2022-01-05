part="latch"; // [front,back,center,latch, pulley,big_gear,small_gear,latch,big_gear_bolton,all]
gear_type="belt"; // [straight,herringbone,belt]
teeth_type="DD"; // [MK7:MK7,MK8:MK8,M8_Bolt:8mm Bolt,HI_Bolt:Half Inch Bolt,DD:Dual Drive 5mm bore]
motor_size="17";
fild=2; // 3 = 6.35 = 6.5, 1.75 = 4 = 4.15
//fild=6.5;
cnc=0;
standard_gear = false;
gdist=58; //42.5;
gangle=70;
slider=8;//gear_type=="belt";//motor_size=="23";
goffy=sin(gangle)*gdist; // -30
goffx=-sqrt(pow(gdist,2)-pow(abs(goffy),2));
geardist=sqrt(pow(abs(goffx),2)+pow(abs(goffy),2));
gear_pitch=gear_type=="belt"?2:4.30;
gear_theight=3;
gear_twfactor=.26;
gear_height=10;
middle_height=15;
smallgear_teeth=gear_type=="belt"?20:13;
biggear_teeth=gear_type=="belt"?60:71;
boltd=5;
secure_nut_slot=1;
//filx=teeth_type=="MK7"?-35.7:(teeth_type=="MK8"?-33.7:-35.2);
//filx=-35+(fild<6?0.625:0);
round_teeth=gear_type=="herringbone";
screwd=motor_size=="23"?4.5:3.5;
small_set_type=1;
filcl=0;
use_gt2=gear_type=="belt";
  thick=8;
mirror=0;
motoroff=(motor_size=="23")?23.5:15.55;
mainbolt_pos=[[-20,-30-12],[-20,-30+12]];
mainblock_size=[25,40];
holed=teeth_type=="DD"?11:(teeth_type=="MK7"||teeth_type=="MK8"?13:(teeth_type=="M8_Bolt"?8.8:(teeth_type=="HI_Bolt"?25.4/2+.8:11)));
bod=teeth_type=="MK7"||teeth_type=="DD"?16:(teeth_type=="HI_Bolt"?28.6:22.2);
filx=goffx-holed/2+(teeth_type=="DD"?.8:1);
tubed=fild<3?4:fild;
mhd=24;
gearrot=3;
cpx=8;
cpy=0;
bearpos=[-3,-15.5];
sx=1;//abs(goffx)/30;
sy=1;//abs(goffy)/30;


echo(str("Gear Distance: ", geardist," (",goffx,",",goffy,") Hole D: ",holed," Filament X: ", filx, " Bearing OD: ", bod));

use <MCAD/involute_gears.scad>;
include <GT2Pulley.scad>;
    
biggear_tdeg=360/biggear_teeth;
smallgear_tdeg=360/smallgear_teeth;
biggeard=(biggear_teeth*gear_pitch)/PI;
smallgeard=(smallgear_teeth*gear_pitch)/PI;
belt_teeth=(biggear_teeth/2)+(smallgear_teeth/2);
echo(str("Belt Teeth: ", (geardist * 2) + (belt_teeth * gear_pitch)));
echo(str("Gear Ratio: ", biggeard/smallgeard, " (",biggeard,"/",smallgeard));

  include <HorizontalConverterGear.scad>;

//  %translate([-3,23.5]) import("BBGearedExtruder/files/geared_extruder_byBB_V095b_latch.stl");
//latch(false);
//translate([-6.2,0]) mirror([1,0]) latch(nut=true);
/*
%center2();
center();
/*/
if(part=="front") rotate([mirror*180,0]) mirror([0,0,mirror]) front();
else if(part=="front4") rotate([0,90,0]) mirror([mirror,0]) {
  intersection(){
    front4();
    translate([26.01,-100]) cube([40,200,30]);
  }
}
else if(part=="front2") intersection(){
  front();
  union(){
  translate([-21,-21]) cube([80,100,20]);
    translate([32,-35]) cube([18,20,20]);
  }
}
else if(part=="front3") difference(){
  intersection(){
    union(){
    front();
      translate([-10,-27]) cube([30,10,8]);
    }
    translate([-40,-80]) cube([70,72.5,30]);
  }
  translate([0,-15,-.01]) cube([30,20,30]);
  translate([16,-20,-.01]) cube([10,10,30]);
  translate([16.5,-20,-.01]) rotate([0,0,45]) cube([10,10,30]);
}
else if(part=="center3") {
  intersection(){
    cube([50,80,6.35]);
    translate([51,53,9.5]) center(12.7);
  }
}
else if(part=="center4") {
  mirror([0,0,1]) intersection(){
    translate([0,0,6.35]) cube([50,80,6.35]);
    translate([51,53,10]) center(12.7);
  }
}
else if(part=="back2") mirror([1,0,0]) mirror([0,0,1]) back();
else if(part=="back3") {
  intersection(){
    cube([40,80,6.35]);
    translate([40,53,-10]) mirror([mirror,0]) rotate([0,180]) back();
  }
}
else if(part=="main") {
  back();
  center();
  front();
}
else if(part=="back") mirror([mirror,0]) rotate([0,180])back();
else if(part=="center") mirror([mirror,0]) center();
else if(part=="pulley") mirror([mirror,0]) pulley2();
else if(part=="big_gear") mirror([mirror,0]) big_gear(true);
else if(part=="small_gear") mirror([mirror,0]) rotate([180,0]) small_gear();
else if(part=="big_gear_bolton") mirror([0,0,1])  big_gear_bolton();
else if(part=="bolt") bolt(hob=25);
 else if(part=="gears") {
  color("green") translate([goffx,goffy,12]) rotate([0,0,45+($t)*biggear_tdeg-(biggear_tdeg/2)]) {
      big_gear(true,standard_gear);
      *#translate([0,0,45]) big_gear_bolton(true);
  }
  
  //translate([-15,-15]) belt2(126);
  translate([0,0,12]) rotate([0,0,235+smallgear_tdeg-($t*smallgear_tdeg)-(smallgear_tdeg*.3)]) small_gear(true,standard_gear);
 }
else if(part=="latch") {
  //translate([14.4,0]) rotate([0,-90])
  translate([goffx,goffy,-4]) rotate([0,0,270]) mirror([1,1,0]) latch(false);
  translate([goffx,goffy,10]) translate([-14.4-(teeth_type=="DD"?8:0),0]) //rotate([0,90])
    mirror([1,0]) mirror([0,0,1]) latch(true);
}
 else if(part=="latch2") {
   translate([14.4,0]) rotate([0,-90])
    latch(false);
  translate([-24.4,0]) rotate([0,90])
    mirror([1,0]) latch(true);
 }
else if(part=="all")
{
  mirror([mirror,0]) {
    lax=goffx-10.3;
    lay=goffy-23.4;
  translate([lax,lay,-20]) rotate([0,0,270]) mirror([1,1,0]) latch(prot=5);
  translate([lax,lay,10]) mirror([1,0,0]) mirror([0,0,1]) latch(nut=true,prot=5);
  *%translate([goffx-17.7,goffy+.4,-9]) linear_extrude(8) difference() { circle(d=22,h=7,$fn=40); circle(d=3,$fn=20); } //bearing608();
  front();
  center();
  back();
  translate([goffx,goffy,12]) rotate([0,0,$t*7.65957]) {
    translate([0,0,1]) color("grey",0.5) big_gear(true,standard_gear);
    if(teeth_type=="MK7"||teeth_type=="DD")
    {
      %translate([0,0,15]) mirror([0,0,1]) bolt(d=5,h=50,hob=0);
      *%translate([0,0,-6]) mirror([0,0,1]) pulley2();
    }else if(teeth_type=="MK8")
    {
    } else if(teeth_type=="HI_Bolt")
    {
      *translate([0,0,10]) big_gear_bolton(true);
    } else //M8_Bolt
    {
      *translate([0,0,10]) big_gear_bolton(true);
      %translate([0,0,15]) mirror([0,0,1]) bolt(hob=25.4);
    }
  }
  color("pink") translate([0,0,12]) rotate([0,0,28-($t*40)]) small_gear(true,standard_gear);
  *translate([0,16,30]) rotate([90,0]) {
    rotate([0,0,($t-5)*15.2]) {
      horiz_converter_gear(teeth=smallgear_teeth*2,bigd=smallgeard*2,theight=2.5,pitch=5);
      %translate([0,0,6]) mirror([0,0,1]) bolt();
    }
    %translate([0,0,-30]) ring(15,8,24); 
  }
}
}
module pulley2(id=5,od=12,h=13,hob=9.5,teeth=40)
{
  if(teeth_type=="MK7") {
    difference(){
      union(){
        cylinder(d=od,h=hob,$fn=40);
        translate([0,0,hob]) {
              cylinder(d1=od,d2=od-1.4,h=1,$fn=30);
              translate([0,0,1]) cylinder(d=od-1.4,h=1,$fn=30);
              translate([0,0,2]) cylinder(d1=od-1.4,d2=od,h=1,$fn
  =30);
        }
        translate([0,0,hob+3]) cylinder(d=od,h=h-hob-3);
      }
      translate([0,0,-.01]) cylinder(d=id,h=h+.02,$fn=30);
      translate([0,0,hob]) {

        for(r=[0:360/teeth:360])
          rotate([0,0,r]) translate([0,od/2+.5,1.5]) rotate([0,90,0]) {
            cylinder(d=3,h=.2,$fn=10);
          }
      }
    }
  } else if(teeth_type=="DD") {
    ddth=15;
    ddod=8.2;
    translate([0,0,-ddth+h]) difference(){
      union(){
        cylinder(d=ddod,h=ddth,$fn=40);
        *translate([0,0,ddth-4]) {
              cylinder(d1=od,d2=od-1.4,h=1,$fn=30);
              translate([0,0,1]) cylinder(d=od-1.4,h=1,$fn=30);
              translate([0,0,2]) cylinder(d1=od-1.4,d2=od,h=1,$fn
  =30);
              translate([0,0,3]) cylinder(d=od,h=1,$fn=30);
        }
        cylinder(d1=8.2,d2=9.8,h=.5,$fn=40);
        translate([0,0,.5]) cylinder(d=9.8,h=4,$fn=40);
        translate([0,0,4.5]) cylinder(d1=9.8,d2=8.2,h=.5,$fn=40);
      }
      rotate_extrude(convexity=3,$fn=50) translate([ddod/2+1,ddth-2.5]) circle(d=3,$fn=30);
      for(r=[0:20:359]) rotate([0,0,r]) linear_extrude(6,convexity=3) polygon([[3.8,0],[4,.1],[4.3,.2],[5,.9],[5,-.9],[4.3,-.2],[4,-.1]]);
      translate([0,0,7.25]) rotate([90,0]) cylinder(d=2.5,h=10,$fn=20);
      translate([0,0,-.01]) cylinder(d=id,h=ddth+.02,$fn=30);
      translate([0,0,ddth-4]) {

        for(r=[0:360/teeth:360])
          rotate([0,0,r]) translate([0,ddod/2+.5,1.5]) rotate([0,90,0]) {
            cylinder(d=3,h=.2,$fn=10);
          }
      }
    }    
  }
}
module bolt(d=8,h=60,hob=0)
{
  ht=22;
  hh=5;
  cylinder(d=d+7,h=hh,$fn=6);
  translate([0,0,hh])
  {
    if(hob>0)
    {
      cylinder(d=d,h=hob,$fn=30);
      translate([0,0,hob+3]) cylinder(d=d,h=h-ht-hh-hob-3,$fn=30);
      translate([0,0,hob]) {
        difference(){
          union(){
            cylinder(d1=d,d2=d-1,h=1,$fn=30);
            translate([0,0,1]) cylinder(d=d-1,h=1,$fn=30);
            translate([0,0,2]) cylinder(d1=d-1,d2=d,h=1,$fn=30);
          }
          for(r=[0:20:360])
              rotate([0,0,r]) translate([0,d/2+.5,1.5]) rotate([0,90,0]) { cylinder(d=3,h=.2,$fn=10);
                //cylinder(d=2.5,h=1,$fn=10);
              }
        }
      }
    } else
      cylinder(d=d,h=h-ht-hh,$fn=30);
    translate([0,0,h-ht-hh]) {
      cylinder(d=d-2,h=ht,$fn=25);
      for(tz=[0:ht])
      {
        translate([0,0,tz]) cylinder(d=d,h=.4,$fn=30);
      }
    }
  }
}
//*/
module center(ch=10){
 *translate([-30-filcl,-30,6]) mirror([0,0,1]) %pulley2(od=(teeth_type=="M8_Bolt"?8:12));
  translate([0,0,-ch-.1])
  difference() {
    union(){
  translate([-cpx,-cpy])
    scale([sx,sy])
    translate([cpx,cpy]) difference(){
    union(){
      %translate([goffx,goffy,-5.9]) mirror([0,0,0]) pulley2();
      if(teeth_type=="DD") {
        %translate([goffx-8.5,goffy,-5.9]) pulley2();
      }
      *translate([-13,-34]) rotate([0,0,45]) cube([20,30,ch]);
      translate([goffx+30,goffy+30]) {
      *translate([-40,-53]) cube([-goffx,-goffy+14.7,ch]);
      for(x=[0,17]) translate([x-45.6,-12.75]) cylinder(d=10.7,h=ch,$fn=40);
      translate([-45.6,-21]) cube([17,13.7,ch]);
      }
      translate([goffx-10,goffy-23,10-ch]) linear_extrude(ch) rsquare(mainblock_size,3);
    }
    translate([goffx-15.6,goffy+30-12.75,-.01]) scale([1/sx,1/sy]) cylinder(d=screwd,h=ch+1,$fn=40);
    *#translate([goffx,goffy,-1.01]) cylinder(d=holed+1,h=ch+2,$fn=30);
    *translate([-45,-30,-.01]) cylinder(d=23.6,h=ch+1,$fn=50);
    *translate([-46,-30,-.01]) cylinder(d=24,h=ch+1,$fn=50);
    *translate([-47,-30,-.01]) cylinder(d=24.2,h=ch+1,$fn=50);
    translate([goffx+30,goffy+30]) {
    translate([-46.7,-13.25,-.01]) rotate([0,0,-5]) translate([-bearpos[0],bearpos[1]]) {
      cylinder(d=24,h=ch+1,$fn=50);
      *%translate([0,0,ch/2-3.5]) difference() {
        cylinder(d=22,h=7,$fn=30);
        translate([0,0,-.1]) cylinder(d=3,h=8,$fn=20);
      }
    }
  }
    *translate([-25,-40,ch/2]) rotate([90,0]) cylinder(d=screwd,h=20,$fn=20);
    *translate([-24,goffy-24,-.01]) rotate([0,0,-50]) cube([20,20,ch+1]);
    translate([goffx+30,goffy+30,-.01]) for(pos=mainbolt_pos) translate(pos) cylinder(d=screwd,h=ch+1,$fn=20);
  }
      translate([filx,goffy-22.2,ch/2]) sphere(d=8.8,$fn=30);
      translate([filx,goffy+30-.01,ch/2]) 
        *translate([-16,-12,ch*-.5]) cube([16,6.2,ch]);
      *translate([filx,goffy+32-.01,ch/2]) intersection(){
        rotate([90,0]) translate([0,0,2.8]) cylinder(d=11,h=12,$fn=60);
        translate([-20,-9,ch*-.5]) cube([30,6.5,ch+1]);
      }

}

      translate([filx,goffy+30,ch/2]) rotate([90,0]) {
      cylinder(d=fild,h=80,$fn=20);
      translate([0,0,2]) cylinder(d1=10,d2=9,h=10.8,$fn=36);
      *translate([-11,0,6]) rotate([90,0]) {
      rotate([0,90,0]) rotate([0,0,30]) cylinder(d=6.5,h=3,$fn=6);
      translate([0,0,-2.75]) mirror([0,1]) cube([3,20,5.5]);
      }
      translate([-2,-5.01,2]) cube([4,10.02,10.8]);
      translate([0,0,5]) rotate([0,-90]) cylinder(d=2,h=20,$fn=20);
      translate([0,0,4.99]) cylinder(d=tubed,h=12,$fn=30);
      translate([0,0,16.98]) cylinder(d1=tubed,d2=fild,h=8,$fn=30);
      //cylinder(d=screwd,h=30,$fn=30);
      *translate([0,0,20]) cylinder(d1=2.4,d2=6,h=10,$fn=30);
      *translate([0,0,30]) cylinder(d1=3.5,d2=2.4,h=10,$fn=30);
      *translate([0,0,46]) cylinder(d1=2.4,d2=3.9,h=10,$fn=30);
      //*/
      translate([0,0,55]) cylinder(d=10,h=4,$fn=10);
    }
    translate([-21.6,-21.6,-.01]) cube([40,40,ch+1]);
    translate([goffx,goffy,-1.01]) {
      rotate_extrude($fn=60) difference() {
        square([holed/2,ch+2]);
        translate([holed/2,ch/2+1]) scale([.5,1.5]) circle(d=fild,$fn=24);
      }
      *cylinder(d=holed,h=ch+2,$fn=30);
      if(teeth_type!="MK7") translate([-holed,-holed/2]) cube([holed,holed,ch+2]);
    }
  *translate([0,0,-9.5]) translate([filx,0,ch/2]) rotate([90,0]) {
      translate([0,0,8]) cylinder(d1=5,d2=6,h=4,$fn=36);
  }
  }
  *translate([-19,-21.6,-9.5]) rotate([0,0,45+90]) cube([5,5,ch]);
}
module front(){
  mountw=9.99;
  mountoff=motor_size=="23"?22:2;
  //holed=teeth_type=="MK7"?14:9;
  thick=7.35;
  countersink=0;
  idler=1;
  notch=gear_type!="belt";
difference(){
  union(){
    mirror([0,gangle>0?1:0]) translate([14+mountoff,-75]) {
      cube([mountw,13,19]);
      cube([mountw,53,thick]);
    }
    translate([goffx-10,goffy-23,0]) linear_extrude(thick) rsquare(mainblock_size,3);
    translate([-21,-22]) linear_extrude(thick) union() {
      translate([5,-slider]) square([30+mountoff+mountw,42.5+mountoff+slider]);
      translate([0,5-slider]) square([5,32.5+mountoff+slider]);
      translate([5,5-slider]) circle(r=5,$fn=30);
      translate([5,37.5+mountoff]) circle(r=5,$fn=30);
    }
    linear_extrude(thick) hull() {
      circle(d=30,$fn=50);
      translate([goffx-5,goffy-5]) square([20,20]);
      *translate([goffx+15,goffy+15]) circle(d=30,$fn=50);
    }
    *translate([goffx+30,goffy+30]) {
    translate([-40,-53]) cube([27.6,45.5,thick]);
    }
    translate([0,0]){
    translate([14+mountoff,-35-slider]) cube([mountw,13,19]);
    mirror([0,1]) translate([14+mountoff,20+slider,thick]) rotate([-45,0]) cube([mountw,4,4]);
    translate([0,slider&&gangle>0?-slider:0]) mirror([0,gangle>0?1:0]) 
    translate([14+mountoff,-37,thick]) rotate([-45,0]) cube([mountw,4,4]);
    }
    translate([0,0]) {
    translate([14+mountoff,20.5+mountoff]) cube([mountw,13,19]);
    translate([14+mountoff,18+mountoff,thick]) rotate([-45,0]) cube([mountw,4,4]);
    }
    translate([8+mountoff,-20-slider]) rotate([0,0,-45]) cube([10,4,thick]);
    translate([14+mountoff,17.6+mountoff]) rotate([0,0,45]) cube([4,4,thick]);
    mirror([0,gangle>0?1:0])
    translate([14+mountoff,-65,thick]) rotate([-45,0]) cube([mountw,4,4]);
    linear_extrude(thick) hull() {
      mirror([0,gangle>0?1:0]) translate([-9,-65-6]) circle(d=6,$fn=40);
      translate([goffx,goffy]) circle(d=6,$fn=40);
    }
    *translate([-33,-52]) rotate([0,0,-45]) cube([34,6,thick]);
    mirror([0,gangle>0?1:0]) 
    translate([-9,-74]) cube([28+mountoff,6,thick]);
  }
  *translate([filx,-14,-5]) rotate([-90,0]) cylinder(d=9,h=20);
  if(teeth_type=="DD") {
    translate([goffx-8.5,goffy,-5.9]) cylinder(d=14,h=20,$fn=40);
  }
  translate([0,0,-0.01]) {
    translate([motoroff-15.55,motoroff-15.55-slider])
    {
      cylinder(d=mhd,h=10.02,$fn=40);
      if(!slider){
      translate([0,0,2]) cylinder(d1=mhd,d2=mhd+6,h=2.01,$fn=40);
      translate([0,0,4]) cylinder(d=mhd,h=10,$fn=40);
      }
      if(slider) {
      translate([0,slider])
        cylinder(d=mhd,h=10.02,$fn=40);
      translate([-mhd/2,0]) cube([mhd,slider,10.02]);
      }
    }
    translate([-15.55,-15.55-slider,thick-9]) {
      for(x=[0,2],y=[0,2])
        translate([x*motoroff,y*motoroff,-2]) {
          if(slider)
          {
            translate([0,slider]) cylinder(d=screwd,h=12.02,$fn=16);
            *translate([0,6,7.5]) cylinder(d=7,h=5,$fn=24);
            translate([screwd*-.5,0]) cube([screwd,slider,12.02]);
            *translate([-3.5,0,7.5]) cube([7,6,5]);
          }
          cylinder(d=screwd,h=12.02,$fn=16);
          if(countersink)
          translate([0,0,7.5]) cylinder(d=7,h=5,$fn=24);
        }
    }
    translate([goffx+30,goffy+30,-2]) for(pos=mainbolt_pos) translate(pos) {
      cylinder(d=screwd,h=10.02,$fn=16);
      translate([0,0,5]) cylinder(d=7,h=10,$fn=24);
    }
    translate([goffx,goffy,0]) {
      translate([0,0,3]) cylinder(d=bod+.2,h=10,$fn=50);
      if(teeth_type!="MK7")
        translate([0,0,1.2]) cylinder(d=holed+4,h=2,$fn=50);
      if(holed+3<bod)
      translate([0,0,-3]) cylinder(d1=holed+3,d2=holed+4,h=2.01,$fn=50);
      translate([0,0,0]) cylinder(d=teeth_type=="MK7"?bod-2:holed+1,h=6,$fn=50);
      if(teeth_type=="MK7") translate([0,0,1.5]) rotate([0,-90]) {
        cylinder(d=5,h=20,$fn=30);
        translate([-2.5,-2.5,0]) cube([2.5,5,20]);
      }
    }
    translate([goffx-20,goffy-17.5,4]) rotate([0,90]) cylinder(d=3,h=50,$fn=20);
    if(secure_nut_slot)
    translate([goffx-5,goffy-20.5,4]) {
      *translate([2,-1,-1.7]) cube([4.7,8,10]);
      translate([0,0,-3]) cube([3,6,8]);
      *translate([0,3]) rotate([0,90]) cylinder(d=6.5,h=6.7,$fn=6);
      
    }
    *difference() { translate([-24,-54]) 
      rotate([0,0,-50]) cube([20,20,11]);
    translate([-33,-52]) rotate([0,0,-45]) cube([34,6,10]);
    }
    if(notch) translate([motoroff-15.55,0]) for(m=[0,1]) mirror([m,0]) 
    translate([-4,10,3]) {
      if(m==0) cube([8,40,10]);
      rotate([0,-45]) cube([8,40,10]);
    }
    translate([12-mountoff,0]) {
    mirror([0,gangle>0?1:0]) translate([0,-68.2,13]) rotate([0,90]) cylinder(d=4.5,h=60,$fn=20);
    translate([0,-28.2-slider,13]) rotate([0,90]) cylinder(d=4.5,h=60,$fn=20);
    translate([0,26.7+mountoff,13]) rotate([0,90]) cylinder(d=4.5,h=60,$fn=20);
    }
    translate([mountoff,0,0]) {
      mirror([0,gangle>0?1:0]) {
    translate([12,-79.5,14]) rotate([-45,0]) translate([0,-10,0]) cube(12);
    translate([12,-60,14]) rotate([45,0]) cube(12);
      }
    translate([12,-40-slider,14]) rotate([-45,0]) translate([0,-10,0]) cube(12);
    translate([12,-20-slider,14]) rotate([45,0]) cube(12);
    translate([0,0]) {
    translate([12,36.2+mountoff,14]) rotate([-45,0]) translate([0,-10,0]) cube(12);
    translate([12,18+mountoff,14]) rotate([45,0]) cube(12);
    }
    }
    translate([-15,-80]) cube([20,5,12]);
  }
}
}
module front4(){
  mountw=motor_size=="23"?9.99:29.99;
  mountoff=motor_size=="23"?22:2;
  //holed=teeth_type=="MK7"?14:9;
  //filx=teeth_type=="MK7"?-35:-33.7;
  //bod=teeth_type=="MK7"?22:22;
  slider=motor_size=="23";
difference(){
  union(){
    *translate([14+mountoff,-75]) {
      cube([mountw,13,19]);
      cube([mountw,53,thick]);
    }
    translate([0,0]){
    translate([14+mountoff,-35]) cube([mountw,13,19]);
    mirror([0,1]) translate([14+mountoff,20,thick]) rotate([-45,0]) cube([mountw,4,4]);
    translate([14+mountoff,-37,thick]) rotate([-45,0]) cube([mountw,4,4]);
    }
    translate([-21,-22]) linear_extrude(thick) {
      translate([5,0]) square([30+mountoff+mountw,42.5+mountoff]);
      translate([0,5]) square([5,32.5+mountoff]);
      translate([5,5]) circle(r=5,$fn=30);
      translate([5,37.5+mountoff]) circle(r=5,$fn=30);
    }
    translate([14+mountoff,20.5+mountoff]) cube([mountw,13,19]);
    translate([-40,-53]) cube([27.6,45.5,thick]);
    translate([-13,-34]) rotate([0,0,45]) cube([20,30,thick]);
    translate([8+mountoff,-20]) rotate([0,0,-45]) cube([10,4,thick]);
    translate([14+mountoff,17.6+mountoff]) rotate([0,0,45]) cube([4,4,thick]);
    translate([14+mountoff,18+mountoff,thick]) rotate([-45,0]) cube([mountw,4,4]);
    *translate([14+mountoff,-65,thick]) rotate([-45,0]) cube([mountw,4,4]);
    *translate([-33,-52]) rotate([0,0,-45]) cube([34,6,thick]);
    *translate([-9,-75]) cube([28+mountoff,6,thick]);
   translate([-13,-44.2]) cube([29+mountw,10,thick]);
  }
  *translate([filx,-14,-5]) rotate([-90,0]) cylinder(d=9,h=20);
  translate([0,0,-0.01]) {
    
    translate([motoroff-15.55,motoroff-15.55])
    {
      cylinder(d=30,h=10.02,$fn=40);
      if(slider) {
      translate([0,slider])
        cylinder(d=30,h=10.02,$fn=40);
      translate([-15,0]) cube([30,6,10.02]);
      }
    }
    translate([-15.55,-15.55,thick-9]) {
      for(x=[0,2],y=[0,2])
        translate([x*motoroff,y*motoroff,-2]) {
          if(slider)
          {
            translate([0,6]) cylinder(d=screwd,h=12.02,$fn=16);
            *translate([0,6,7.5]) cylinder(d=7,h=5,$fn=24);
            translate([screwd*-.5,0]) cube([screwd,6,12.02]);
            *translate([-3.5,0,7.5]) cube([7,6,5]);
          }
          cylinder(d=screwd,h=12.02,$fn=16);
          *translate([0,0,7.5]) cylinder(d=7,h=5,$fn=24);
        }
    }
    translate([goffx+30,goffy+30]) {
      translate([-27,-12,-2])  {
        cylinder(d=screwd,h=10.02,$fn=16);
        translate([0,0,7.5]) cylinder(d=7,h=5,$fn=24);
      }
      translate([-17,-41,-2]) {
        cylinder(d=screwd,h=10.02,$fn=16);
        translate([0,0,7.5]) cylinder(d=7,h=5,$fn=24);
      }
    }
    translate([goffx,goffy,4]) {
      translate([0,0,-2.4]) cylinder(d=bod+.2,h=10,$fn=50);
      translate([0,0,-3]) cylinder(d1=holed+3,d2=holed+4,h=2.01,$fn=30);
      translate([0,0,-4]) cylinder(d=holed+1,h=6,$fn=30);
    }
    translate([-50,-47.5,4]) rotate([0,90]) cylinder(d=3,h=50,$fn=20);
    *translate([-35,-50.5,4]) {
      translate([0,3]) rotate([0,0]) translate([0,-3]) {
      cube([2.7,6,10]);
      translate([0,3]) rotate([0,90]) cylinder(d=6.5,h=2.7,$fn=6);
      }
    }
    *difference() { translate([-24,-54]) 
      rotate([0,0,-50]) cube([20,15,11]);
    translate([-33,-52]) rotate([0,0,-45]) cube([34,6,10]);
    }
    *translate([motoroff-15.55,0]) for(m=[0,1]) mirror([m,0]) 
    translate([-4,10,3]) {
      if(m==0) cube([8,40,10]);
      rotate([0,-45]) cube([8,40,10]);
    }
    translate([12-mountoff,0]) {
    translate([0,-68.2,13]) rotate([0,90]) cylinder(d=4.5,h=60,$fn=20);
    translate([0,-28.2,13]) rotate([0,90]) cylinder(d=4.5,h=60,$fn=20);
    translate([0,26.7+mountoff,13]) rotate([0,90]) cylinder(d=4.5,h=60,$fn=20);
    }
    translate([mountoff,0,0]) {
      csz=[mountw+2.01,12,12];
    translate([12,-79.5,14]) rotate([-45,0]) translate([0,-10,0]) cube(csz);
    translate([12,-60,14]) rotate([45,0]) cube(csz);
    translate([12,-40,14]) rotate([-45,0]) translate([0,-10,0]) cube(csz);
    translate([12,-20,14]) rotate([45,0]) cube(csz);
    translate([12,36.2+mountoff,14]) rotate([-45,0]) translate([0,-10,0]) cube(csz);
    translate([12,18+mountoff,14]) rotate([45,0]) cube(csz);
    }
    translate([-15,-80]) cube([20,5,12]);
  }
}
}

module latch(nut=false,prot=0)
{
  top_hole=0;
  pivot_inset=0;
  bearing_clamp=0;
  beardeg=10;
  translate([5,40]) rotate([0,0,prot]) translate([-5,-40])
  intersection(){
    union() {
      translate([0,top_hole?-3:0,teeth_type=="DD"&&!nut?0:2]) cube([teeth_type=="DD"?10:20,50+(top_hole?3:0),15]);
      if(teeth_type=="DD") translate([-3,24,nut?8:0]) {
        cylinder(d=8,h=nut?4:1.8,$fn=50);
        translate([0,-4]) cube([4,8,nut?4:1.8]);
      }
    }
    difference(){
      union(){
        *if(teeth_type=="DD") translate([-3,24]) cylinder(d=13,h=14,$fn=50);
        translate([0,top_hole?-3:0]) cube([teeth_type=="DD"?10:6.37,11.3+(top_hole?3:0),14.5]);
        translate([5,23.5]) difference(){
          cylinder(d=27,h=14.5,$fn=30);
          *translate([0,0,10.55]) cylinder(d=24,h=14.6,$fn=30);
          if(teeth_type!="DD") {
            translate([0,40-23.5,10.55]) rotate([0,0,beardeg]) translate(bearpos) cylinder(d=24,h=8,$fn=20);
            translate([-5.01,7,10.55]) cube([5,10,5]);
          }
        }
        /*
        translate([5,23.5,-0.01]) cylinder(d=8,h=14.5,$fn=30);
        translate([5,23.5,10.55]) cylinder(d1=11,d2=10,h=.5,$fn=30);
        //*/
        if(teeth_type!="DD") translate([5,40,10.54]) rotate([0,0,beardeg]) translate(bearpos) {
          cylinder(d1=11,d2=10,h=.5,$fn=30);
          cylinder(d=8,h=3.95,$fn=30);
        }
        translate([5.36,40.75,0]) cylinder(d=10.7,h=9.726,$fn=30);
        translate([0,30,0]) cube([5,10,9.726]);
        difference(){
          translate([18.4,30]) rotate([0,0,32]) mirror([1,0]) translate([0,-2.5,0]) cube([5,18.5,14.5]);
          *translate([5,23.5,10.55]) cylinder(d=24,h=14.6,$fn=30);
          if(teeth_type!="DD") translate([5,40,10.55]) rotate([0,0,beardeg]) translate(bearpos) cylinder(d=24,h=8,$fn=20);
        }
        translate([18,20.5]) cube([1.75,7.38,14.5]);
        translate([16.6,18.3]) rotate([0,0,-28]) cube([1.75,3.4,14.5]);
        translate([14.5,15.5]) rotate([0,0,-47.5]) cube([1,4.1,14.5]);
      }
      if(teeth_type=="MK7") // allen hole
      translate([-10,24.5,6]) rotate([0,0,-5]) rotate([0,90]) cylinder(d=4,h=40,$fn=30); 
      if(teeth_type=="DD") {
        translate([-3,24]) {
          translate([0,0,nut?9:.6]) cylinder(d=3,h=20,$fn=20);
          translate([0,0,nut?12.01:1.81]) cylinder(d=11,h=15,$fn=30);
        }
      }
      *translate([5,23.5,-0.01]) cylinder(d=8,h=14.5,$fn=30);
      difference(){
        union(){
          translate([5.5,41,9.726]) cylinder(d=12.5,h=10,$fn=30);
          if(teeth_type!="DD") 
            translate([-.01,34,9.726]) cube(5);
        }
        if(teeth_type!="DD") translate([5,23.5,9.726]) cylinder(d=23.8,h=14.6,$fn=30);
      }
      if(bearing_clamp)
      translate([5,40,-.01]) rotate([0,0,beardeg]) translate(bearpos) {
        cylinder(d=screwd,h=14.52,$fn=20);
        rotate([0,0,nut?30:0]) cylinder(d=nut?7:6.5,h=3.85,$fn=nut?6:20);
      }
      if(teeth_type=="DD") {
        for(y=[15,30]) translate([4,y,-.01]) cylinder(d=screwd,h=20,$fn=20);
      } else
      translate([5,23.5,-0.01]) {
        cylinder(d=screwd,h=14.52,$fn=30);
        rotate([0,0,nut?30:0]) cylinder(d=nut?7:6.5,h=3.85,$fn=nut?6:30);
      }
      translate([5.36,40.75,-.01]) {
        cylinder(d=screwd,h=9.8,$fn=30);
        if(pivot_inset)
        rotate([0,0,nut?30:0]) cylinder(d=nut?7:6.5,h=3.85,$fn=nut?6:30);
      }
      if(top_hole)
      translate([3.2,0.5,-.01]) {
        cylinder(d=3,h=19.8,$fn=30);
      }
      translate([0,.5]) {
        for(i=[teeth_type=="MK7"?-5:0:2])
          translate([-.2,5+(i*.5),6]) rotate([5-(i*5),90]) cylinder(d=4,h=14,$fn=24);
        
      }
      *translate([-.2,-.01,4.25]) cube([10,5.75,3.5]);
      if(teeth_type!="MK7"&&teeth_type!="DD")
      {
      translate([-10.3,23.5,-.01]) cylinder(d=25,h=8.5,$fn=50);
      translate([4,-.4-(top_hole?3:0),-.01]) mirror([0,0,0]) rotate([0,0,-45]) cube([5,5,17]);
      }
      translate([13,10,-.01]) cube([20,40,30]);
    }
  }
}
module front2()
{
  translate([-8.5,-14.7,0]) import("GearedExtruderBBFront.stl");
}
module center2()
{
  %translate([goffx,goffy,-.5]) rotate([180,0,0]) import("BBGearedExtruder/files/geared_extruder_byBB_V095b_body-center_alu.stl");
}
module back()
{
  //translate([0,0,0]) back2();
  bh=teeth_type=="DD"?12:10;
  //holed=teeth_type=="MK7"?14:9;
  //bod=teeth_type=="MK7"?16:22;
  translate([0,0,-20.4])
  difference() {
  translate([-cpx,-cpy])
    scale([sx,sy])
    translate([cpx,cpy]) difference(){
    union(){
      translate([goffx-10,goffy-23,10-bh]) linear_extrude(bh) rsquare(mainblock_size,3);
      *translate([-13,-34,10-bh]) rotate([0,0,45]) cube([20,30,bh]);
    }
    if(teeth_type=="DD")
      translate([goffx-8.5,goffy,-5.9]) cylinder(d=14,h=20,$fn=40);
    //filx=teeth_type=="MK7"?-35:-33.7;
    *translate([filx,-14,14.5]) rotate([-90,0]) cylinder(d=10,h=20);
    translate([0,0,10-bh]) difference(){
      translate([-21.6,-21.6,-.01]) cube([24,24,bh+1]);
      *translate([-19,-21.6,0]) rotate([0,0,45+90]) cube([5,5,bh]);
    }
    *translate([goffx,goffy,-1])  cylinder(d=holed+1,h=bh+2,$fn=30);
    *translate([-24,-54,9.99-bh]) rotate([0,0,-50]) cube([20,20,bh+.02]);
    translate([goffx+30,goffy+30,10-bh-.01]) for(pos=mainbolt_pos) translate(pos) scale([1/sx,1/sy]) {
        cylinder(d=screwd,h=bh+1,$fn=20);
        rotate([0,0,30]) cylinder(d=6.5,h=3,$fn=6);
    }
    translate([goffx+30,goffy+30]) {
      translate([-41,-47.65,6]) rotate([0,90]) cylinder(d=3,h=50,$fn=20);
      if(secure_nut_slot) {
        translate([-35,-50.65,3-10]) cube([3,6,16]);
        *translate([-35,-47.6,5.8]) scale([1/sx,1/sy]) rotate([90,0]) {
          rotate([0,90,0]) rotate([0,0,30]) cylinder(d=6.5,h=7,$fn=6);
          translate([2,0,-2.75]) mirror([0,1]) cube([5,4,5.5]);
          *rotate([90,0]) translate([0,0,-3.25]) mirror([0,1]) cube([3,20,6.5]);
        }
      }
    }
    if(teeth_type=="MK7"||teeth_type=="DD")
    {
      translate([goffx+30,goffy+30,bh-11]) {
        translate([-40.01,-30,7]) mirror([0,0,1]) rotate([0,90]) {
          translate([0,-3]) cube([6,6,4]);
          cylinder(d=6,h=4,$fn=20);
        }
        translate([-30-filcl,-30,teeth_type=="MK7"?6-bh:(teeth_type=="DD"?2.01-bh:4-bh)]) cylinder(d=bod+.2,h=9,$fn=40);
        *translate([-30,-30,10-bh+4.8]) cylinder(d1=holed+2,d2=holed+1,h=2,$fn=34);
        translate([-30-filcl,-30,10-bh]) cylinder(d=holed+1,h=bh+10,$fn=30);
      }
    } else if(teeth_type!="HI_Bolt") {
      translate([goffx,goffy,-1]) cylinder(d=22.4,h=9,$fn=50);
      translate([goffx,goffy,10-bh+4.5]) {
        cylinder(d1=13,d2=12,h=2,$fn=40);
        cylinder(d=10,h=10,$fn=40);
      }
    }
  }
  
  if(teeth_type!="MK7"&&teeth_type!="DD")
  translate([goffx,goffy,-.01]) {
    cylinder(d=holed,h=10.02,$fn=50);
    cylinder(d=holed+5,h=7,$fn=50);
    cylinder(d=bod+.2,h=6,$fn=50);
  }
  }
}
module back2()
{
  %translate([-30,-30,-10]) rotate([180,0]) import("BBGearedExtruder/files/geared_extruder_byBB_V095b_body-back_alu.stl");

}
module nuthole(h,bottom=1,top=0)
{
  cylinder(d=3.5,h=h,$fn=20);
  if(bottom)
    rotate([0,0,30]) cylinder(d=6.5,h=3,$fn=6);
  if(top)
    translate([0,0,h-3]) rotate([0,0,30]) cylinder(d=6.5,h=3,$fn=6);
}
module big_gear_old(center=false,standard=false)
{
  translate(center?[]:[-30,-30,12]) rotate([0,0,5.2]) import("BBGearedExtruder/files/geared_extruder_byBB_V095_biggear.stl");
}
module big_gear(center=false,standard=false)
{
  if(use_gt2)
  {
    translate([0,0,17]) mirror([0,0,1]) difference(){
      pulley( "GT2 2mm" , tooth_spacing (2,0.254, teeth=biggear_teeth) , 0.764 , 1.494, profile = 12, teeth = biggear_teeth, idler=true, motor_shaft = 8.2 );
      translate([0,0,-.01]) cylinder(d=5,h=30,$fn=40);
    }
  } else {
  translate(center?[]:[goffx,goffy,12]) rotate([0,0,gearrot]) 
  difference(){
    mygear((biggear_teeth*gear_pitch)/PI,gear_height,gear_pitch,theight=gear_theight,rod=0,  bolt_head=0,holes=6,set_hole=boltd==5?2.5:5,gear_twfactor=gear_twfactor,$fn=30);
    *rotate([0,0,-30]) translate([9,0,-0.01]) nuthole(10.1,top=1);
    //rotate([0,0,30]) translate([9,0,-0.01]) nuthole(10.1,top=1);
    *rotate([0,0,90]) translate([9,0,-0.01]) nuthole(10.1,top=1);
    //rotate([0,0,150]) translate([9,0,-0.01]) nuthole(10.1,top=1);
    *rotate([0,0,210]) translate([9,0,-0.01]) nuthole(10.1,top=1);
    if(!cnc) {
    if(boltd==5)
    {
      translate([0,0,-.01]) cylinder(d=9.4,h=3.02,$fn=6);
      translate([0,0,3]) cylinder(d1=9.4,d2=boltd,h=3,$fn=6);
      } else if(boltd>=8) {
      translate([0,0,-.01]) cylinder(d=14.5,h=6.02,$fn=6);
      translate([0,0,6]) cylinder(d1=14.5,d2=boltd,h=(14.5-boltd)/2,$fn=6);
      }
    } else {
      for(r=[0:120:359]) rotate([0,0,r]) translate([boltd,0,-.01]) cylinder(d=3,h=20,$fn=20);
    }
  }
  //translate([0,0,2]) big_gear_bolton();
}
}
module big_gear_bolton(center=false)
{
  translate(center?[]:[goffx,goffy,22]) difference(){
    cylinder(d1=28,d2=28,h=6,$fn=50);
    rotate([0,0,0]) translate([0,0,-.01]) cylinder(d=14.4,h=6.1,$fn=6);
    rotate([0,0,0]) translate([0,0,-.01]) cylinder(d=15,h=6.1,$fn=6);
    rotate([0,0,-30]) translate([9,0,-3.01]) cylinder(d=screwd,h=10,$fn=20);
    rotate([0,0,90]) translate([9,0,-3.01]) cylinder(d=screwd,h=10,$fn=20);
    rotate([0,0,210]) translate([9,0,-3.01]) cylinder(d=screwd,h=10,$fn=20);

  }
}
module small_gear_old(center=false,standard=false)
{
  translate(center?[0,0,-8]:[0,0,4]) import("BBGearedExtruder/files/geared_extruder_byBB_V095_smallgear.stl");
}
module small_gear(center=false,standard=false)
{
  sgbod=18;
  sgh=12;
  translate(center?[]:[0,0,12]) rotate(center?[]:[0,0,21]) difference(){union(){
       mygear((smallgear_teeth*gear_pitch)/PI,sgh,gear_pitch,theight=gear_theight,rod=0,gear_twfactor=gear_twfactor);
       *cylinder(d=8,h=10);
    }
    *translate([0,0,-.01]) cylinder(d=5.7,h=10.02,$fn=60);
  }
  translate(center?[0,0,-12]:[]) difference(){
    union(){
      translate([0,0,4]) cylinder(d=sgbod,h=8,$fn=40);
      translate([0,0,12]) cylinder(d=10,h=sgh,$fn=30);
      *translate([0,0,12]) cylinder(d1=18,d2=12,h=4,$fn=50);
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
      difference() {
        cylinder(d=5.7,h=30,$fn=20);
        if(small_set_type==1)
          translate([-3,2.1,-.01]) cube([6,2,30]);
      }
      for(r=[0:2]) {
        rotate([0,0,r*120]) {
          translate([0,sgbod/2-1,8]) rotate([90,0]) {
            cylinder(d=3.2,h=8,$fn=20);
            translate([0,0,-1]) cylinder(d=5,d2=3.2,h=1.01,$fn=30);
            *translate([0,0,2.5]) rotate([0,0,30]) cylinder(d=7,h=3,$fn=6);
          }
          *translate([-3,4.5,3.99]) cube([6,3,4]);
          translate([-3,4,3.99]) cube([6,2.6,8]);
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
          linear_extrude(h) polygon([for(i=[30:5:150]) [tr*(.5+sin(i*-3)/2)*1.1,tt*2*cos(i)]]);
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
module mygear(d,h,pitch,theight=3,rod=1,bearing=0,set_hole=0,holes=0,bolt_head=0,type=gear_type,gear_twfactor=gear_twfactor)
{
  teeth=(PI*d)/pitch;
  cpitch=18*d;
  *linear_extrude(h,convexity=3) difference() {
    gear(number_of_teeth=teeth,circular_pitch=cpitch,flat=true);
    circle(d=8);
  }
  mygear2(d,h,pitch,theight,rod,bearing,set_hole,holes,bolt_head,type,gear_twfactor);
}
module mygear2(d,h,pitch,theight=3,rod=1,bearing=0,set_hole=0,holes=0,bolt_head=0,type=gear_type,gear_twfactor=gear_twfactor)
{
  teeth=(PI*d)/pitch;
  tdeg=360/teeth;
  echo(str("Teeth: ", teeth, " @ ", tdeg));
  //intersection()
  {
    //  translate([0,0,-20]) sphere(d=d+21,$fn=80);
  difference(){
    union(){
  difference(){
    union(){
    rotate([0,0,tdeg]) cylinder(d=d,h=h,$fn=teeth*4);
      if(!cnc&&d>50)
        cylinder(d=28,h=middle_height,$fn=teeth*4);
    }
    if(!cnc&&d>50)
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
      rotate([0,0,t*(360/teeth)]) translate([d/2-1,pitch*-.25,0])
      {
        intersection(){
          //involute_gear_tooth(pitch_radius=teeth);
          tooth(pitch,theight,gear_twfactor,type,d,h,clock);
          if(round_teeth)
            translate([theight/-2,(theight/-2)*(clock?-1:0),h/2-2]) sphere(d=h+6);
        }
      }
    }
  }
}
  if(!cnc)
  translate([0,0,middle_height-h-1]) if(set_hole>0) {
    set_holes=3;
    for(sh=[1:set_holes]) rotate([0,0,(360/set_holes)*sh]) {
      gearh=h;
      //#translate([0,0,-0.01]) cylinder(d=5,h=gearh+0.02);
    translate([0,0,h-3]) rotate([90,0,0]) {
      cylinder(d=screwd,h=d>50?d/3:d);
      translate([0,0,d>50?set_hole+7:set_hole+4]) cylinder(d=6.5,h=6);
      translate([0,0,set_hole+2]) {
        *rotate([0,0,30]) cylinder(d=6.5,h=2.4,$fn=6);
        *translate([-2.75,0,0]) cube([5.5,6.1,2.4]);
        translate([-3,-3,0]) cube([6,8,2.6]);
      }
    }
  }
  }
  if(holes>0)
  {
    deg=360/holes;
    for(hole=[1:holes])
    {
      rotate([0,0,deg*hole]) translate([d/4+5,0,-0.01]) cylinder(d=d/holes,h=h+0.02,$fn=d/2);
    }
  }
  }
}
}
module bearing625(){ring(16,5,5);}
module bearing608(){ring(22,8,7);}
module ring(od,id,h)
{
  difference(){
    cylinder(d=od,h=h);
    translate([0,0,-0.01]) cylinder(d=id,h=h+0.02);
  }
}
module belt2(dist,h=6,pitch=2,thick=1.4)
{
  teeth=(PI*dist/2)/pitch;
  belt(teeth,h,pitch,thick);
}
module belt(teeth,h=6,pitch=2,thick=1.4)
{
  radius=((teeth/2)*pitch)/PI;
  echo(str("T",pitch," Belt @ ",teeth," = ",radius));
  linear_extrude(h)
  for(m=[0,1]) mirror([m,0])
    arc(radius, 180, thick, pitch);
}
module arc(radius, angle, thick = 1, pitch=0, toff = 0){
  $fn=radius * 2;
	intersection(){
		union(){
			rights = floor(angle/90);
			remain = angle-rights*90;
			if(angle > 90){
				for(i = [0:rights-1]){
					rotate(i*90-(rights-1)*90/2){
						polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
					}
				}
				rotate(-(rights)*90/2)
					polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
				rotate((rights)*90/2)
					polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
			}else{
				polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
			}
		}
		difference(){
			circle(radius+thick,$fn=100);
			circle(radius,$fn=100);
		}
	}
  if(pitch>0)
  {
      $fn = 14;
      tcnt=(PI*radius) / pitch;
      tdeg=angle / tcnt;
      //echo(str("TDEG: ", tdeg, ", ", tcnt, ", ", angle, ", ", tcnt * tdeg));
      roff = radius - 0.2;
      ldeg = (toff + tdeg * tcnt) - tdeg;
      for(t=[toff:tdeg:angle])
      {
        translate([sin(t) * roff, cos(t) * roff])
        {
          circle(pitch / 4, $fn=16);
          translate([sin(t)*(pitch/4),cos(t)*(pitch/4)]) rotate(90-t)
          square([pitch/2,pitch*.5],center=true);
          *if(t>=ldeg)
            echo(str(radius,": ",180-t,":",ldeg));
        }
      }
  }
}

module btooth() {
translate([-0.05,0,0]) {
arc(.555, angle=130, thick=0.5);
translate([0.2,-1.25]) rotate([0,0,140]) arc(.15, angle=75, thick=.15);
mirror([0,1,0]) translate([0.2,-1.25]) rotate([0,0,140]) arc(.15, angle=75, thick=.15);
translate([-.35,-.3])
  rotate([0,0,60])
    arc(1,angle=30, thick=.5);
mirror([0,1,0]) 
translate([-.35,-.3])
  rotate([0,0,60])
    arc(1,angle=30, thick=.5);
circle(d=1.4);
}
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
function inches(in) = 25.4 * in;