which="hex";
hexd1=which=="hex"?12.6:11.8; // [hex=12.6,v6=11.8]
hexd2=which=="hex"?16:17; // [hex=16,v6=17]
hexd3=15;
hexh1=which=="hex"?4.4:5.6; // grip amount: [hex=4,v6=6]
hexh2=which=="hex"?6.6:-.8; // drop amount: [hex=6.4,v6=-1]
hexh3=which=="hex"?5:6; // top height; [hex=5,v6=4]
hexh4=which=="hex"?hexh2-5:0;
mainh=6;
v6h1=6;
v6h2=4.5;
v6d1=12;
v6d2=17;
screwd=2.6;
nutd=6.5;
shapetype=2;
rest_type="2";
addguide=0;//4.98;
filw=3.4;
$fn=40;
blockmode=3;
block3_chop=1.2;
top_screws=1;
bottom_screws=1;
square_nut=0;
trim_front=2;
trim_back=0;
ramp2d1=0; //blockmode?0:1;
ramp2guide=0;
od1=20;
od2=21;
odo1=-1;
odo2=2;
greg=false;
  seatw=greg?60:47;
  seath=(greg?28:24);
  seatz1=8;
  seatz2=6;
  chamy=13;
  chamx=13;
  xoff = (49-seatw)/2;
  yoff = 12 - seath/2;
  zoff = hexh1+hexh2-6;
  boltswitch=false;

//!tube_holder();
//hexagon_half();
//translate([49,30,0]) mirror([1,0,0]) mirror([0,1,0]) hexagon_half();
//translate([0,0,-8]) hexagon_seat_half();
//hexagon();
if(!part)
{
  //*
  rotate([0,0]) intersection(){
    //translate([0,-50,-10.4]) cube([50,50,16.2]);
    /*/
    hexagon_seat(greg=false);
    /*/
    union(){
      translate([0,0,14]) rotate([180,0])
      hexagon_seat_half(greg=false);
      translate([50,-20,14]) rotate([-90,0]) translate([0,-18.5,-40]) translate(blockmode==3?[0,18.5,62]:[]) rotate(blockmode==3?[-90,0]:[])
       hexagon_seat_half(saddle=true,greg=false);
    }
    /**/
  }
  /*/
  mirror([0,0,1]) {
  v6_seat_half(greg=true);
  translate([0,38]) translate([0,-24]) v6_seat_half(greg=true,saddle=true);
  }
  //*/
  /*
  difference(){
    v6_seat(2);
    translate([-17,14]) cylinder(d=10,h=3);
    translate([-17,-14]) cylinder(d=10,h=3);
    translate([17,14]) cylinder(d=10,h=3);
    translate([17,-14]) cylinder(d=10,h=3);
  }
  //*/
}
module v6_seat_half(center=true,greg=false,saddle=false)
{
  if(saddle)
    intersection(){
      v6_seat(false,greg);
      v6_saddle(greg);
     }
  else
    difference(){
      v6_seat(false,greg);
      v6_saddle(greg);
    }
}
module v6_saddle(greg=false) {
    translate([12,12,-0.01]) cube([25,15,10]);
    translate([5,12,3]) rotate([0,45,10]) cube([15,15,10]);
    translate([5,12,3]) rotate([0,45,0]) cube([15,15,10]);
    translate([44,12,3]) mirror([1,0,0]) rotate([0,45,0]) cube(15);
    translate([44,12,3]) mirror([1,0,0]) rotate([0,45,10]) cube(15);
}
module hex_saddle(greg=false,offset=0) {
  ty=greg?12:hexd1+.6-(blockmode==3?block3_chop:0);
  tz=11+((blockmode>0&&blockmode<4)?-1:0);
  tx=(greg?44:38);
  sang=10;
  if(blockmode>0&&blockmode<3)
  {
    translate([14-offset/2,ty-offset/2,-10.01]) cube([21+offset,15,40]);
    translate([10-offset/2,ty-offset/2+4,-10.01]) cube([29+offset,15,40]);
    translate([45-tx-offset/2,ty-offset/2+4,tz+2]) cube([35+offset,15,2+offset/2]);
    translate([45-tx-offset/2,ty-offset/2+4,tz-2.01]) cube([35+offset,15,2+offset/2]);
    *translate([45-tx-offset/2,ty-offset/2+4,tz]) cube([15,15,2]);
  } else if(blockmode<1||blockmode>3) {
    intersection() {
    union() {
      translate([12-offset/2,ty-offset/2,-10.01]) cube([25+offset,15,40]);
      translate([49-tx-offset/2,ty-offset/2,tz]) rotate([0,45,sang]) cube([15,15,10]);
      translate([tx+offset/2,ty-offset/2,tz]) mirror([1,0,0]) rotate([0,45,0]) cube(15);
      translate([49-tx-offset/2,ty-offset/2,tz]) rotate([0,45,0]) cube([15,15,10]);
      translate([tx+offset/2,ty-offset/2,tz]) mirror([1,0,0]) rotate([0,45,sang]) cube(15);
      }
      if(blockmode>3)
        translate([10-offset/2,ty-offset/2+hexd1/2+.4,0]) cube([29+offset,10,40]);
    }
  }
  if(blockmode>=3)
    translate([25-offset/2-hexd1/2,ty-offset/2,-10.01]) cube([hexd1+offset-1,15,40]);
  if(blockmode==3)
    translate([8-offset/2,ty-offset/2+hexd1/2,-10.01]) cube([33+offset,20,30]);
}
module hexagon_seat_half(center=true,greg=false,saddle=false)
{
  if(!saddle) {
    difference(){
      hexagon_seat(false,greg,false);
      hex_saddle(greg,1);
    }
  } else {
    intersection(){
      hexagon_seat(false,greg,true);
      hex_saddle(greg);
    }
  }
}
module hexagon_seat_half_old(center=true,greg=false)
{
  translate(center?[0,0,6]:[0,0,0]) mirror(center?[0,0,1]:[0,0,0]) translate(center?[-24.5,-12,0]:[])
translate([0,0,14]) mirror([0,0,1]) intersection()
{
  hexagon_seat(false,greg);
  union()
  {
  difference()
    {
    translate(greg?[-5.5,-2]:[]) cube([greg?60:49,greg?14:12,14]);
    translate([-0.01,8,15.501]) rotate([-45,0,0]) cube([30,8,5]);
  }
  translate([20,7.5,15.5]) intersection() {
    rotate([-45,0,0]) cube([30,6,15]);
    translate([0,0,-5]) cube([30,8,3.5]);
  }
}
}
}

module v6_seat_old(side=1)
{
  translate([0,0,3]) rotate([90,0])
  {
    if(side==1||side==0)
      import("v6seat.stl");
    if(side==2||side==0)
      import("v6seat2.stl");
  }
difference(){
//  cube([49,24,6]);
//  translate([24.5,12,-0.01]) cylinder(d=hexd1,h=6.02,$fn=50);
}
}

module v6_seat(center=true,greg=false)
{
    translate(center?[-24.5,-12,-8]:[0,0,-8]) {
  seatw=greg?60:49;
  seath=greg?28:24;
  yoff = 12 - seath/2;
  difference(){
    translate([greg?-5.5:0,yoff,8]) cube([seatw,seath,mainh]);
    //translate([24.5,12,12.99]) cylinder(d=v6d2,h=3.02,$fn=50);
    translate([24.5,12,7.99]) cylinder(d=v6d1,h=6.02,$fn=50);
    translate([7,12,7.99]) cylinder(d=4,h=6.02,$fn=30);
    translate([7,12,7.99]) cylinder(d=10,h=3.01,$fn=40);
    translate([42,12,7.99]) cylinder(d=4,h=6.02,$fn=30);
    translate([42,12,7.99]) cylinder(d=10,h=3.01,$fn=40);
    translate([42,0,7.99]) cylinder(d1=10,d2=10,h=3.01,$fn=40);
    translate([7,0,7.99]) cylinder(d1=10,d2=10,h=3.01,$fn=40);
    translate([42,24,7.99]) cylinder(d=10,h=3.01,$fn=40);
    translate([7,24,7.99]) cylinder(d=10,h=3.01,$fn=40);
    translate([14,(greg?-2:0)-0.01,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=3+(greg?2:0),$fn=30);
      cylinder(d=screwd,h=24.02,$fn=30);
    }
    translate([35,(greg?-2:0)-0.01,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=3+(greg?2:0),$fn=6);
      cylinder(d=screwd,h=24.02,$fn=30);
    }
    translate([14,(greg?-2:0)+seath-2.99,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=3+(greg?2:0),$fn=6);
    }
    translate([35,(greg?-2:0)+seath-2.99,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=3+(greg?2:0),$fn=30);
    }
    if(greg) {
      translate([-.5,seath/2+yoff,5]) cylinder(d=screwd+1,h=10);
      translate([49.5,seath/2+yoff,5]) cylinder(d=screwd+1,h=10);
    }
  }
}
}
module tube_holder(greg=false,nutside=false)
{
  difference() {
    union() {
      main_shape(greg,center=true);
      cylinder(d=12,h=mainh+5.99,$fn=50);
      translate([-5,-9,mainh]) cube([10,6,6]);
    }
    translate([-25,-12.5,-8]) rest_holes();
    translate([0,0,-.01]) cylinder(d=6.5,h=20,$fn=30);
    translate([-3,-7.4,mainh]) cube([6,3,6]);
    translate([0,-10,mainh+3]) rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
  }
}
module main_shape(greg=false,nutside=false,center=false)
{
  translate(center?[-25,-12.5]:[xoff+(greg?-5.5:0),yoff-(nutside?1.6:0),8]) {
      if(shapetype==0)
        cube([seatw,seath,mainh]);
      else if(shapetype==1)
          linear_extrude(mainh) polygon([[0,chamy],[chamx,0],[seatw-chamx,0],[seatw,chamy],[seatw,seath-chamy],[seatw-chamx,seath],[chamx,seath],[0,seath-chamy]]);
      else if(shapetype==2)
          linear_extrude(mainh) polygon([[0,chamy/2],[chamx,0],[seatw-chamx,0],[seatw,chamy/2],[seatw,seath-chamy/2],[seatw-chamx,seath],[chamx,seath],[0,seath-chamy/2]]);
    }
}
module rest_holes()
{
  if(rest_type=="nut") {
    translate([7,12,7.99]) cylinder(d=6.7,h=3.01,$fn=6);
    translate([42,12,7.99]) cylinder(d=6.7,h=3.01,$fn=6);
    translate([7,12,7.99]) cylinder(d=4.5,h=6.02,$fn=30);
    translate([42,12,7.99]) cylinder(d=4.5,h=6.02,$fn=30);
    } else {
      if(rest_type!="2") {
    translate([7,12,7.99]) cylinder(d=10,h=3.01,$fn=40);
    translate([42,12,7.99]) cylinder(d=10,h=3.01,$fn=40);
    translate([7,12,7.99]) cylinder(d=4,h=6.02,$fn=30);
    translate([42,12,7.99]) cylinder(d=4,h=6.02,$fn=30);
      } else {
    translate([7,12,7.99]) cylinder(d=3.4,h=6.02,$fn=30);
    translate([42,12,7.99]) cylinder(d=3.4,h=6.02,$fn=30);
      }
    }
    if(rest_type!="nut"&&rest_type!="1"&&rest_type!="2")  {
      translate([42,0,7.99]) {
        cylinder(d1=11,d2=10,h=3.01,$fn=40);
        cylinder(d=4,h=6.02,$fn=30);
      }
      translate([7,0,7.99]) {
        cylinder(d1=11,d2=10,h=3.01,$fn=40);
        cylinder(d=4,h=6.02,$fn=30);
      }
      translate([42,24,7.99]) {
        cylinder(d=10,h=3.01,$fn=40);
        cylinder(d=4,h=6.02,$fn=30);
      }
      translate([7,24,7.99]) {
        cylinder(d=10,h=3.01,$fn=40);
        cylinder(d=4,h=6.02,$fn=30);
      }
    }
}
module hexagon_seat(center=true,greg=false,nutside=false)
{
  difference(){union(){
  translate(center?[-24.5,-12,-8]:[0,0,0]) union() {
  difference(){
    union() {
      main_shape(greg,nutside);
      translate([24.5,12,8-hexh4]) cylinder(d=20,h=4+hexh4+2,$fn=50);
    }
    translate([24.5,12,7.99-hexh2]) {
      cylinder(d=hexd2,h=hexh3,$fn=50);
      if(blockmode>=3&&!nutside)
        translate([hexd2*-.5,0]) cube([hexd2,hexd2/2,hexh3]);
      if(blockmode>=3&&nutside)
        translate([hexd1*-.5,0,-2]) cube([hexd1,hexd1/2,3]);
    }
    translate([24.5,12,0]) {
      cylinder(d=hexd3,h=15.01);
      if(!nutside) translate([hexd3*-.5,0]) cube([hexd3,hexd3,15.01]);
    }
    if(addguide)
      translate([24.5,12,-12.6]) cylinder(d=hexd2,h=20,$fn=50);

    if(!ramp2d1)
      translate([24.5,12,8-(hexd2-hexd1)/2-hexh2]) cylinder(d=hexd1,h=(hexd2-hexd1)/2)
    translate([24.5,12,10.99]) cylinder(d=hexd1,h=3.02,$fn=50);
    rest_holes();
    if(top_screws)
    translate([14,(greg?-2:0)-0.01,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=5.5+(greg?2:0),$fn=nutside?6:30);
      cylinder(d=screwd,h=24.02+(greg?4:0),$fn=30);
    }
    if(top_screws)
    translate([35,(greg?-2:0)-0.01,10.99]) rotate([-90,0,0]) {
      if(!nutside)
      cylinder(d=nutd,h=5.5+(greg?2:0),$fn=nutside?6:30);
      cylinder(d=screwd,h=24.02+(greg?4:0),$fn=30);
    }
    
    if(trim_front)
      translate([7,-5+trim_front,7.99]) {
        cube([36,5.01,mainh+.1]);
        //translate([21,0]) cube([11,4.01,6.1]);
    }
    if(trim_back)
    translate([8,(greg?-2:1)+seath-trim_back,7.99]) {
        cube([34,5.01,6.1]);
        //translate([21,0]) cube([11,4.01,6.1]);
    }
    if(top_screws)
    for(x=[14,35])
    translate([x,(greg?-2:0)+seath-2.99-(nutside?1.6-(blockmode==3?1:0):0),10.99]) rotate([-90,0,0]) {
      cylinder(d=(nutside&&square_nut?6.5:nutd),h=(nutside?4.5:3.5)+(greg?2:0),$fn=nutside?(square_nut?4:6):30);
    }
    if(greg) {
      translate([-.5,seath/2+yoff,5]) cylinder(d=screwd+1,h=10);
      translate([49.5,seath/2+yoff,5]) cylinder(d=screwd+1,h=10);
    }
  }
  translate([24.5,12,8.01-(hexh2+hexh1)]) {
    difference(){
      union(){
        cylinder(d1=od1+odo1,d2=od2+odo2,h=hexh2+hexh1);
        cylinder(d=od2+odo2,h=hexh2+hexh1,$fn=50);
        translate([od2*-.5,od2*-.5+(nutside?(trim_back?0:1):(trim_front?trim_front+0.5:1)),0]) cube([od2,od2-1.1,hexh1+hexh2]);
        //translate([9,-10,3]) rotate([-90,0,0]) 
         // cylinder(d=6,h=10,$fn=30);
        
      }
      if(nutside&&blockmode==3)
         translate([hexd1*-.5,0,-.01]) cube([hexd1,hexd1/2,mainh+.02]);
      if(bottom_screws) for(m=[1,-1])
      translate([m*(hexd1/2+2),10,2]) rotate([90,0]) {
        if(!nutside)
          translate([0,0,18-trim_front]) {
            cylinder(d=5.5,h=5,$fn=30);
            mirror([m==1?0:1,0]) translate([-1.5,-3.4]) cube([5.5,6.5,5]);
          }
        translate([0,0,-1]) cylinder(d=screwd,h=20,$fn=20);
        
      }
      translate([0,0,1]) cylinder(d2=hexd1,d1=hexd1,h=6.01);
      translate([0,0,hexh1]) hull() {
        cylinder(d2=hexd2,d1=hexd2,h=hexh2+.01);
        if(!nutside)
        translate([0,20,0]) cylinder(d2=hexd2,d1=hexd2,h=hexh2+.01);
      }
      translate([0,0,-.01]) cylinder(d=hexd1,h=27);
    }
  }
  if(addguide){
    translate([24.5,12,8-(hexh1+hexh2)+6.6]) difference(){
      cylinder(d=od2-2,h=hexh1+hexh2-.6,$fn=50);
      cylinder(d=filw,h=10.21,$fn=30);
      if(ramp2d1)
        translate([0,0,(9-filw)/2-.79]) cylinder(d1=filw,d2=9,h=(9-filw)/2,$fn=30);
      translate([0,0,-.01])
        cylinder(d=hexd2,h=10.2-addguide,$fn=50);
      if(ramp2guide)
        translate([0,0,5.2])
          cylinder(d1=hexd2,d2=9,h=3.02,$fn=50);
      else translate([0,0,5.2])
          cylinder(d=9,h=3.02,$fn=50);
      translate([0,0,8.2])
        cylinder(d=9,h=4,$fn=30);
    }
  }
  }
  }
  if(ramp2d1)
  {
    translate([24.5,12,8-ramp2d1-hexh2+.01]) cylinder(d2=hexd2,d1=hexd1,h=ramp2d1);
    //translate([24.5,12,8-(hexd2-hexd1)/2-hexh2+.01]) cylinder(d2=hexd2,d1=hexd1,h=(hexd2-hexd1)/2);
  }
  }
}
module hexagon_seat2(center=true,greg=false,nutside=false)
{
  seatw=greg?60:49;
  seath=(greg?28:24);
  seatz1=8;
  seatz2=6;
  yoff = 12 - seath/2;
  zoff = 5;
  boltswitch=false;
  translate(center?[-24.5,-12,-8]:[0,0,0]) {
  difference(){
    translate([greg?-5.5:0,yoff,8]) cube([seatw,seath,6]);
    translate([24.5,12,7.99]) cylinder(d=hexd2,h=9-zoff+0.02,$fn=50);
    translate([24.5,12,10.99]) cylinder(d=hexd1,h=3.02,$fn=50);
    translate([7,12,7.99]) cylinder(d=4,h=6.02,$fn=30);
    translate([7,12,7.99]) cylinder(d=10,h=3.01,$fn=40);
    translate([42,12,7.99]) cylinder(d=4,h=6.02,$fn=30);
    translate([42,12,7.99]) cylinder(d=10,h=3.01,$fn=40);
    translate([42,0,7.99]) {
      cylinder(d1=11,d2=10,h=3.01,$fn=40);
      cylinder(d=4,h=6.02,$fn=30);
    }
    translate([7,0,7.99]) {
      cylinder(d1=11,d2=10,h=3.01,$fn=40);
      cylinder(d=4,h=6.02,$fn=30);
    }
    translate([42,24,7.99]) {
      cylinder(d=10,h=3.01,$fn=40);
      cylinder(d=4,h=6.02,$fn=30);
    }
    translate([7,24,7.99]) {
      cylinder(d=10,h=3.01,$fn=40);
      cylinder(d=4,h=6.02,$fn=30);
    }
    translate([14,(greg?-2:0)-0.01,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=3.5+(greg?2:0),$fn=nutside?6:30);
      cylinder(d=screwd,h=24.02+(greg?4:0),$fn=30);
    }
    translate([35,(greg?-2:0)-0.01,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=3.5+(greg?2:0),$fn=nutside?6:30);
      cylinder(d=screwd,h=24.02+(greg?4:0),$fn=30);
    }
    translate([14,(greg?-2:0)+seath-2.99,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=3.5+(greg?2:0),$fn=nutside?6:30);
    }
    translate([35,(greg?-2:0)+seath-2.99,10.99]) rotate([-90,0,0]) {
      cylinder(d=nutd,h=3.5+(greg?2:0),$fn=nutside?6:30);
    }
    if(greg) {
      translate([-.5,seath/2+yoff,5]) cylinder(d=screwd+1,h=10);
      translate([49.5,seath/2+yoff,5]) cylinder(d=screwd+1,h=10);
    }
  }
  translate([24.5,12,7.7-zoff]) {
    difference(){
      union(){
        cylinder(d1=22,d2=24,h=zoff+.3);
        //translate([9,-10,3]) rotate([-90,0,0]) 
         // cylinder(d=6,h=10,$fn=30);
      }
      translate([0,0,3]) cylinder(d2=hexd2,d1=hexd1,h=1.01);
      translate([0,0,4]) cylinder(d2=hexd2,d1=hexd2,h=2.31);
      translate([0,0,-.01]) cylinder(d=hexd1,h=27);
    }
  } }
}
