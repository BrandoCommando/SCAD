part="bracket"; // [v6_shroud,v6_mount,v6_all,hex_mounted,hex_shroud,hex_mount,hex_all,carriage,bracket,carriage_belt_seat,carriage_belt_tightener]
// Add shrouds
shrouds=0; // [1:Yes,0:No]
mw=54;
off=10;
fang=30;
screwd=3.5;
screwd2=5;
bigd=26;
cw=107.5;
ch=48.5;
bod=23.5; // bearing bracket outer diameter
bid=15.8; // bearing bracket inner diameter
clh=8; // carriage leg hole height
hw1=60; // hole 1 width
hh1=46;
hw2=70;
hh2=20;

include <HexMount.scad>;
include <Hexagon-102.scad>;
include <e3d_v6_all_metall_hotend.scad>;

//carriage();
//translate([0,0,off*-1]) mirror([0,0,1]) mount();
if(part=="v6_shroud")
  mirror([0,0,1]) shroud(40);
else if(part=="v6_hotend")
  hotend();
else if(part=="hex_mounted")
  hotend_mounted("hexagon");
else if(part=="v6_mounted")
  hotend_mounted("v6");
else if(part=="cold_plate")
  cold_plate(false,false);
else if(part=="carriage_plate")
  carriage_plate();
else if(part=="carriage_greg_cord_holder")
  carriage_greg_cord_holder();
else if(part=="carriage_greg_fan")
  carriage_greg_fan();
else if(part=="dual_mix_plate")
  dual_plate("v6","hexagon","v6");
else if(part=="hex_greg")
  hex_greg();
else if(part=="xstop")
  carriage_xstop();
else if(part=="carriage_belt_seat")
  rotate([90,0]) carriage_belt_seat();
else if(part=="carriage_belt_tightener")
  carriage_belt_tightener();
else if(part=="hex_hotend")
  hotend("hex");
else if(part=="carriage")
  carriage_main();
else if(part=="carriage_full")
  carriage();
else if(part=="carriage_fans")
  carriage_fans();
else if(part=="bracket")
  mirror([0,0,1]) bearing_bracket();
else if(part=="dual_v6")
  cold_plate("v6","v6");
else if(part=="dual_mix")
{
//  carriage();
  translate([bod+6,0,2]) cold_plate("hexagon","v6");
}
else if(part=="dual_hex")
{
  carriage();
  translate([bod+6,1,2]) cold_plate("hexagon","hexagon");
}
else if(part=="v6_all") {
  yoff=4.4;
  translate([0,yoff,off]) mount();
  translate([-60,yoff,3]) shroud(60,23);
  translate([94,yoff,10]) mirror([1,0,0]) shroud(40);
  %translate([mw/2,ch/2-4+yoff,-14]) hotend("v6");
  translate([cw*-.5+mw/2,0,0]) mirror([0,0,1]) carriage();
} else if(part=="v6_mount") {
  mount("v6");
} else if(part=="hex_shroud") {
  mirror([0,0,1]) shroud(40,30,middle=false);
} else if(part=="hex_fan1") {
  //rotate([0,90])
  mirror([0,0,1])
  difference()
  {
    shroud_bracket(mount_height=30,depth=40);
    shroud_body(40);
  }
} else if(part=="hex_fan_bearing_mount") {
  mirror([0,0,0])
  {
    difference()
    {
      translate([40,10,12]) {
        cube([12,20,24]);
        translate([6,0,-2]) cube([6,20,5]);
        translate([10,0,-4]) cube([2,20,2]);
      }
      //shroud_bracket(mount_height=30,depth=40);
      shroud_body(40);
      translate([30,20,30]) rotate([0,90,0]) cylinder(d=3.6,h=30,$fn=20);
    }
    translate([29.5,-4.5,-2]) mirror([0,0,1])
    bearing_bracket(0);
  }
} else if(part=="hex_fan2") {
} else if(part=="shroud_body") {
  rotate([0,-1*atan(1/2)-90,0]) mirror([0,0,1]) {
  shroud_body(40,hollow=true);
  shroud_base(40);
  }
} else if(part=="hex_mount") {
  mount("hex");
} else if(part=="hex_all") {
  yoff=4.4;
//  translate([0,yoff,off]) mount("hex");
  *translate([-3,1,-2]) mirror([0,0,1]) {
    mount_placeholders("hexagon","v6");
  }
  if(shrouds) {
    translate([-55,yoff,2]) shroud(40,30,12,false);
    *translate([115,yoff,3]) mirror([1,0,0]) shroud(60,23);
  } else {
    *%translate([-27,40,32]) rotate([90,fang,0]) fan(40,40,10);
  }
  //translate([mw/2,ch/2,-8.5]) hotend("hex");
//  %translate([-40,0,42]) cube([130,40,2]);
  translate([cw*-.5+mw/2,0,0]) mirror([0,0,1]) { 
    mirror([0,0,1]) mirror([0,1]) carriage_plate();
    bearing_bracket();
    translate([cw-bod,0]) bearing_bracket();
  }
//  translate([-mirror([0,0,1]) bearing_bracket();
}

//color("blue")
//translate([10,0,22]) rotate([-90+fang,0,90]) translate([0,-20,0]) fan(40,40,20);
//translate([mw/2-20,-10,0]) fan(40,40,10);
  
  //rotate([0,0,90]) fan(40,40,20);
module hotend(variant="v6") {
  if(variant=="v6")
  {
    e3d_v6();
    /*
    cylinder(d=22.3,h=33,$fn=40);
    translate([-8,-14,35]) cube([16,20,11.5]);
    translate([0,0,47]) cylinder(d=7,h=3,$fn=6);
    translate([0,0,50]) cylinder(d1=6,d2=.4,h=2,$fn=20);
    cylinder(d=4,h=50,$fn=20);
    */
  } else {
    mirror([0,0,1])
    translate([0,0,-55.6])
    hexagon_hotend();
    /*
    difference(){
      cylinder(d=22.3,h=23,$fn=6);
      for(i=[1:8])
      {
        translate([0,0,i*2.6-1.3]) cylinder(d=50,h=1);
      }
    }
    translate([0,0,-5]) cylinder(d=16,h=5,$fn=30);
    translate([0,0,-8]) cylinder(d=12,h=4,$fn=30);
    translate([-8,-14,25]) cube([16,20,11.5]);
    translate([0,0,37]) cylinder(d=7,h=3,$fn=6);
    translate([0,0,40]) cylinder(d1=6,d2=.4,h=2,$fn=20)
    cylinder(d=4,h=40,$fn=20);
    */
  }
}
module hotend_mounted(which="hexagon",center="mount") {

  if(which=="hexagon")
  {
    hexagon_seat(true);
    translate([0,0,-52.8]) hexagon_hotend();
  }
  else {
    translate([0,0,0]) v6_seat();
    translate([0,0,12.8]) mirror([0,0,1]) rotate([0,0,-90]) e3d_v6();
  }
}
module mount_placeholders(mount1="hexagon",mount2=false) {
    translate([17,hh1/2,5]) {
      //rotate([0,0,90]) hexagon();
      if(mount2==false) {
        if(mount1!=false)
          translate([13,0]) rotate([0,0,90]) {
            hotend_mounted(mount1);
          }
      } else {
        translate([-1,0]) {
          rotate([0,0,90]) hotend_mounted(mount1);
        translate([28,0])
          rotate([0,0,90]) hotend_mounted(mount2);
        }
        //translate([-10,-10,-55]) cube([cw,ch,2]);
      }
    }
}
module cold_plate(mount1="hexagon",mount2=false) {
  mount_placeholders(mount1,mount2);
  difference() {
    union() {
      translate([0,0])
        cube([hw1,hh1,5]);
      translate([hw1/2-hw2/2,hh1/2-hh2/2])
        cube([hw2,hh2,8]);
      
      translate([16,5,5]) rotate([0,0,90]) cylinder(d=screwd+5,h=3);
      translate([16,hh1-5,5]) rotate([0,0,90]) cylinder(d=screwd+5,h=3);
      translate([hw1-16,5,5]) rotate([0,0,90]) cylinder(d=screwd+5,h=3);
      translate([hw1-16,hh1-5,5]) rotate([0,0,90]) cylinder(d=screwd+5,h=3);
      translate([hw1/2,5,5]) rotate([0,0,90]) cylinder(d=screwd+5,h=3);
      translate([hw1/2,hh1-5,5]) rotate([0,0,90]) cylinder(d=screwd+5,h=3);
    }
    translate([16,5,5]) rotate([0,0,90]) cylinder(d=nutd,h=3.01,$fn=6);
    translate([16,hh1-5,5]) rotate([0,0,90]) cylinder(d=nutd,h=3.01,$fn=6);
    translate([hw1-16,5,5]) rotate([0,0,90]) cylinder(d=nutd,h=3.01,$fn=6);
    translate([hw1-16,hh1-5,5]) rotate([0,0,90]) cylinder(d=nutd,h=3.01,$fn=6);
    translate([hw1/2,5,5]) rotate([0,0,90]) cylinder(d=nutd,h=3.01,$fn=6);
    translate([hw1/2,hh1-5,5]) rotate([0,0,90]) cylinder(d=nutd,h=3.01,$fn=6);
    translate([16,5,-0.01]) rotate([0,0,90]) cylinder(d=screwd,h=10);
    translate([16,hh1-5,-0.01]) rotate([0,0,90]) cylinder(d=screwd,h=10);
    translate([hw1-16,5,-0.01]) rotate([0,0,90]) cylinder(d=screwd,h=10);
    translate([hw1-16,hh1-5,-0.01]) rotate([0,0,90]) cylinder(d=screwd,h=10);
    translate([hw1/2,5,-0.01]) rotate([0,0,90]) cylinder(d=screwd,h=10);
    translate([hw1/2,hh1-5,-0.01]) rotate([0,0,90]) cylinder(d=screwd,h=10);
    translate([-2.5,0,5.5]) rotate([-90,0,0]) cylinder(d=screwd,h=50);
    translate([hw2-7.5,0,5.5]) rotate([-90,0,0]) cylinder(d=screwd,h=50);
    translate([4,10,-0.01]) {
     cube([hw1-8,hh1-20,8.02]);
    }
  }
}
module carriage_belt_tightener() {
  bth=12;
  %carriage_belt_seat(true);
  translate([2,24,14]) {
        translate([8,3.5,bth]) rotate([0,90]) cylinder(d=10,h=1,$fn=30);
        translate([19,3.5,bth]) rotate([0,90]) cylinder(d=10,h=1,$fn=30);
    difference(){
      union(){
        cube([20,10,bth]);
        translate([0,0,bth-8]) intersection(){
          translate([9,4,4]) rotate([0,90]) cylinder(d=11,h=10,$fn=30);
          cube([20,8,10]);
        }
      }
      translate([4,5,-0.01]) {
        rotate([0,0,30]) cylinder(d=nutd,h=3,$fn=6);
        cylinder(d=screwd+1,h=bth-0.2);
      }
      translate([16,5,-0.01]) {
        rotate([0,0,30]) cylinder(d=nutd,h=3,$fn=6);
        cylinder(d=screwd+1,h=bth-0.2);
      }
    }
  }
}
module carriage_greg_cord_holder() {
  //%carriage_plate();
  //rotate([90,0])
    difference(){
      union(){
        translate([cw/2-20,-7,-3]) cube([40,18,3]);
        translate([cw/2-20,-10,-3]) cube([40,10,8]);
        *translate([cw/2-20,-10,-36]) cube([40,21,33]);
        translate([cw/2-5,-10,5]) cube([10,5,40]);
        translate([cw/2,2,20]) cylinder(d=17,h=25,$fn=20);
      }
      translate([cw/2,2,19.99]) cylinder(d=14,h=26,$fn=20);
      translate([cw/2-4,2,19.99]) cube([8,10,26]);
      translate([cw/2-10,-5,19.99]) rotate([-90,0]) mirror([0,1,0]) rotate([45,0]) cube([20,40,10]);
      *translate([cw/2-20-.01,-6,-33]) cube([40.02,20,30]);
      *translate([cw/2,-10.01,-13.5]) rotate([-90,0]) cylinder(d1=34,d2=20,h=22);
      *translate([cw/2,-8,-9]) rotate([-90,0]) cylinder(d=20,h=20);
    translate([cw/2-16, -10.01, 2.5]) rotate([-90,0]) cylinder(d=screwd,h=9);
      translate([cw/2-16, -10.01, -29.5]) rotate([-90,0]) cylinder(d=screwd,h=9);
      translate([cw/2+16, -10.01, -29.5]) rotate([-90,0]) cylinder(d=screwd,h=9);
    translate([cw/2+16, -10.01, 2.5]) rotate([-90,0]) cylinder(d=screwd,h=9);
      translate([cw/2-14,7,-3.01]) cylinder(d=screwd,h=32);
      translate([cw/2,7,-3.01]) cylinder(d=screwd,h=32);
      translate([cw/2+14,7,-3.01]) cylinder(d=screwd,h=32);
      translate([cw/2-14,-.5,-3.01]) cylinder(d=screwd2,h=32);
      translate([cw/2,-.5,-3.01]) cylinder(d=screwd2,h=32);
      translate([cw/2+14,-.5,-3.01]) cylinder(d=screwd2,h=32);
    }
}
module carriage_greg_fan() {
  //%carriage_plate();
  rotate([90,0])
    difference(){
      union(){
        translate([cw/2-20,-7,-3]) cube([40,18,3]);
        translate([cw/2-20,-10,-3]) cube([40,10,8]);
        translate([cw/2-20,-10,-36]) cube([40,21,33]);
      }
      translate([cw/2-20-.01,-6,-33]) cube([40.02,20,30]);
      translate([cw/2,-10.01,-13.5]) rotate([-90,0]) cylinder(d1=34,d2=20,h=22);
      translate([cw/2,-8,-9]) rotate([-90,0]) cylinder(d=20,h=20);
    translate([cw/2-16, -10.01, 2.5]) rotate([-90,0]) cylinder(d=screwd,h=9);
      translate([cw/2-16, -10.01, -29.5]) rotate([-90,0]) cylinder(d=screwd,h=9);
      translate([cw/2+16, -10.01, -29.5]) rotate([-90,0]) cylinder(d=screwd,h=9);
    translate([cw/2+16, -10.01, 2.5]) rotate([-90,0]) cylinder(d=screwd,h=9);
      translate([cw/2-14,7,-3.01]) cylinder(d=screwd,h=32);
      translate([cw/2,7,-3.01]) cylinder(d=screwd,h=32);
      translate([cw/2+14,7,-3.01]) cylinder(d=screwd,h=32);
      translate([cw/2-14,-.5,-3.01]) cylinder(d=screwd2,h=32);
      translate([cw/2,-.5,-3.01]) cylinder(d=screwd2,h=32);
      translate([cw/2+14,-.5,-3.01]) cylinder(d=screwd2,h=32);
    }
}
module carriage_belt_seat(center=true) {
  seath=18;
  beltw=8;
  beltth=20;
  translate(center?[4,-12,-5]:[])
  difference() {
    translate([-4,12,5]) cube([bod,24,seath]);
     translate([0,24,-.01]) {
       cylinder(d=screwd,h=seath+8);
       translate([0,0,7]) cylinder(d=nutd,h=seath,$fn=30);
       translate([0,8])
         cylinder(d=screwd,h=seath+8);
       translate([0,-8])
         cylinder(d=screwd,h=seath+8);
       translate([0,-1.34+8,seath+5]) rotate([90,45,90]) cube([2,2,10]);
       translate([0,-1.34-8,seath+5]) rotate([90,45,90]) cube([2,2,10]);
       translate([8,-12.01,5]) cube([beltw,24.02,3]);
       for(gy=[1:2:25])
         translate([8,gy-14.4,seath+5]) rotate([90,45,90]) cube([2,2,beltw]);
     }
   }
   translate(center?[]:[-4,12,5])
   {
     translate([14,24,8]) difference(){
       cube([beltw+1.2,beltth,6]);
       translate([beltw/2,beltth-3,-0.01]) cylinder(d=screwd+1,h=6.02);
       translate([beltw/2-2.75,beltth-3,1.5]) cube([5.5,4,3]);
       translate([beltw/2,beltth-3,1.5]) rotate([0,0,30]) cylinder(d=nutd,h=3,$fn=6);
       translate([beltw/2,beltth-.5,-1.5]) rotate([0,0,30]) cylinder(d=5,h=4,$fn=20);
     }
     difference() {
       union(){
       translate([0,24,0]) cube([1.2,beltth,18]);
        translate([bod-1.2,24,0]) cube([1.2,beltth,18]);
       }
       translate([-.01,45,-20]) rotate([45,0]) cube([40,20,20]);
     }
     translate([2,24,8]) difference(){
       translate([-1.2,0]) cube([beltw+6,beltth,6]);
       translate([beltw/2,beltth-3,-0.01]) cylinder(d=screwd+1,h=6.02);
       translate([beltw/2-2.75,beltth-3,1.5]) cube([5.5,4,3]);
       translate([beltw/2,beltth-3,1.5]) rotate([0,0,30]) cylinder(d=nutd,h=3,$fn=20);
       translate([beltw/2,beltth-.5,-1.5]) rotate([0,0,30]) cylinder(d=5,h=6,$fn=20);
     }
   }

}
module carriage_xstop() {
  %carriage_plate();
  translate([cw-6,0,5]) {
    difference() {
      union(){
        cube([9,7,8]);
        cube([10,36,2]);
      }
      translate([5.5,16,-0.01]) screwhole(h=3,chamfer="top");
      translate([5.5,24,-0.01]) screwhole(h=3,chamfer="top");
      translate([5.5,32,-0.01]) screwhole(h=3,chamfer="top");
      translate([4.5,-0.01,5]) rotate([-90,0]) cylinder(d=screwd,h=10.02);
      translate([1,2,5]) cube([7,3,6.01]);
      translate([4.5,2,5]) rotate([-90,0]) cylinder(d=7,h=3,$fn=6);
    }
  }
}
module hex_greg() {
  //hotend_mounted("hexagon");
  hexagon_seat(true,true);
  %rotate([0,0,90]) translate([-16.5,-6.5,10]) rotate([112,0]) import("RoboGreg.stl");
}
module dual_plate(m1,m2=false) {
  carriage_plate();
  translate([30,0]) mount_placeholders(m1,m2);
  translate([56.5,18,20]) rotate([112,0]) import("RoboGreg.stl");
  //translate([60,32,20]) rotate([180,180,0]) rotate([112,0]) import("RoboGreg.stl");
}
module carriage_plate() {
  mnx=14;
  mny=35;
  mnh=2.5;
  mnod=8.5;
  cp_type=1;
  cp_screwd=cp_type==1?10.4:screwd;
  cp_holeh=cp_type==0?26:22;
  //carriage_belt_seat(false);
  rotate([cp_type==1?180:0,0])
  difference(){
    union(){
      translate([-4,0])
        cube([cw+8,ch,5]);
      if(cp_type==0)
      translate([cw/2-mnx, ch/2-mny/2, 5])
        for(x=[0:2])
          for(y=[0:1])
            translate([mnx*x,mny*y]) {
              cylinder(d=mnod,h=mnh);
            }
    }
    

    translate([cw/2-mnx, ch/2-mny/2, 5])
    for(x=cp_type==0?[0:2]:[0,2])
      for(y=[0:1])
        translate([mnx*x,mny*y]) {
          translate([0,0,cp_type==1?mnh*-1:0]) cylinder(d=nutd,h=mnh+0.01,$fn=6);
          translate([0,0,-5.01]) screwhole(d=cp_screwd,h=cp_type==0?6:4);
          if(cp_type==0) translate([0,(2*y-1)*7.5,-5.01]) cylinder(d=screwd2, h=5.02, $fn=30);
        }

     translate([0,24,-.01]) {
       screwhole(chamfer="top",h=5.02);
       translate([0,8]) screwhole(h=5.02, chamfer="top");
       translate([0,-8]) screwhole(h=5.02, chamfer="top");
     }
     translate([cw-.5,24,-.01]) {
       screwhole(chamfer="top",h=5.02);
       translate([0,8]) screwhole(h=5.02, chamfer="top");
       translate([0,-8]) screwhole(h=5.02, chamfer="top");
     }

  translate([cw/2-hw1/2+.5, 0, -0.01]) rotate([0,0,0])
  {
      translate([0,ch/2-cp_holeh/2])
        cube([hw1,cp_holeh,5.02]);
  }
  
//  translate([cw/2-hw1/2,ch/2-hh1/2,-0.01]) cube([hw1,hh1,20]);
//  translate([cw/2-hw2/2,ch/2-hh2/2,-10]) cube([hw2,hh2,30]);
//  translate([cw/2-15,ch/2-20,-10]) cube([30,40,20]);
//  translate([cw/2-15,ch/2,-10]) rotate([0,0,90]) cylinder(d=40,h=40);
//  translate([cw/2+15,ch/2,-10]) rotate([0,0,90]) cylinder(d=40,h=40);
  bx1=bod/2;
  bx2=bx1+84;
  translate([0,0]) bracket_nuts(cp_type==0?0:1); // close nuts
  translate([cw-bod,0]) bracket_nuts(cp_type==0?0:1); // far nuts
  echo(str("Bearing X: ", bx1, ", ", bx2));
  translate([bx1,-.01,-5]) rotate([-90,0]) cylinder(d=bid,h=ch+0.02,$fn=40);
  translate([bx2,-.01,-5]) rotate([-90,0]) cylinder(d=bid,h=ch+0.02,$fn=40);
}
module bracket_nuts(slope=0)
{
    for(x=[0,bod],y=[4,ch-4])
    translate([x,y,-.01])
    {
      screwhole();
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
}
module carriage_fans() {
  carriage();
  translate([-14,ch/2-20,-0.5]) mirror([0,0,1]) mirror([1,0]) rotate([fang,0,90]) fan(40,40,10);
}
module carriage_main() {
  intersection()
  {
    carriage();
    color("green") translate([-4.01,-0.01,0]) cube([cw+8.02,ch+0.02,20]);
  }
}
module carriage_bearing_bracket() {
  intersection()
  {
    carriage();
    color("blue") translate([-8,-0.01,-20.01]) cube([36,ch+0.02,20]);
  }
}
module bearing_bracket(nipples=1) {
  bex=0.2;
  difference(){
    union(){
      intersection()
      {
        translate([0,0,-1*bod]) cube([bod,ch,bod+bex]);
        union(){
        translate([bod/2,0,-5]) rotate([-90,0]) cylinder(d=bod,h=ch,$fn=40);
        }
      }
      translate([0,0,-1*min(2,clh)+bex]) {
        translate([-4,4]) cube([4,4,min(2,clh)]);
        translate([0,7]) cylinder(d=8,h=min(2,clh),$fn=30);
        translate([bod,4]) cube([4,4,min(2,clh)]);
        translate([bod,7]) cylinder(d=8,h=min(2,clh),$fn=30);
        translate([-4,ch-7]) cube([4,4,min(2,clh)]);
        translate([0,ch-7]) cylinder(d=8,h=min(2,clh),$fn=30);
        translate([bod,ch-7]) cube([4,4,min(2,clh)]);
        translate([bod,ch-7]) cylinder(d=8,h=min(2,clh),$fn=30);
        translate([bod,4,-1*clh+min(2,clh)]) cylinder(d=8,h=clh,$fn=16);
        translate([bod,ch-4,-1*clh+min(2,clh)]) cylinder(d=8,h=clh,$fn=16);
        translate([0,4,-1*clh+min(2,clh)]) cylinder(d=8,h=clh,$fn=16);
        translate([0,ch-4,-1*clh+min(2,clh)]) cylinder(d=8,h=clh,$fn=16);
      }
      if(nipples){
      translate([8.5,ch/2-16,-9]) mirror([1,0]) rotate([0,fang*-1]) translate([0,0,-8]) cylinder(d1=screwd2,d2=screwd2+4,h=3);
      translate([8.5,ch/2+16,-9]) mirror([1,0]) rotate([0,fang*-1]) translate([0,0,-8]) cylinder(d1=screwd2,d2=screwd2+4,h=3);
      translate([15,ch/2-16,-9]) rotate([0,fang*-1]) translate([0,0,-8]) cylinder(d1=screwd2,d2=screwd2+4,h=3);
      translate([15,ch/2+16,-9]) rotate([0,fang*-1]) translate([0,0,-8]) cylinder(d1=screwd2,d2=screwd2+4,h=3);
      }
    }
    translate([0,0,-1*bod+bex]) {
      translate([0,4]) cylinder(d1=6,d2=6,h=bod-clh,$fn=30);
      translate([0,ch-4]) cylinder(d1=6,d2=6,h=bod-clh,$fn=30);
      translate([bod,4]) cylinder(d1=6,d2=6,h=bod-clh,$fn=30);
      translate([bod,ch-4]) cylinder(d1=6,d2=6,h=bod-clh,$fn=30);
    }
    translate([bod/2,-.01,-5]) rotate([-90,0]) difference(){
      cylinder(d=bid,h=ch+0.02,$fn=40);
      translate([0,0,3.3]) ring(bid+1,bid-1,1);
      translate([0,0,ch-4.3]) ring(bid+1,bid-1,1);
      translate([0,0,19.7]) ring(bid+1,bid-1,1);
      translate([0,0,ch-20.7]) ring(bid+1,bid-1,1);
    }
    translate([bod/2-2,-0.01,-5-bid/2]) cube([4,ch+0.02,2]);
    
     translate([0,0,-1*clh-.61-bex]) {
        translate([bod,4,1]) screwhole(h=clh+1);
        translate([bod,ch-4,1]) screwhole(h=clh+1);
        translate([0,4,1]) screwhole(h=clh+1);
        translate([0,ch-4,1]) screwhole(h=clh+1);
     }
  //translate([10,ch/2,-38]) rotate([0,-60,0]) cylinder(d=40,h=50,$fn=80);
  //translate([-21,ch/2,-20]) rotate([0,0,0]) cylinder(d=50,h=50,$fn=80);
     if(nipples){
    translate([8.5,ch/2-16,-9]) mirror([1,0]) rotate([0,fang*-1]) {
     translate([0,0,-8.01]) cylinder(d1=screwd,h=5);
   }
    translate([8.5,ch/2+16,-9]) mirror([1,0]) rotate([0,fang*-1]) translate([0,0,-8.01]) cylinder(d1=screwd,h=5);
    translate([15,ch/2-16,-9]) rotate([0,fang*-1]) translate([0,0,-8.01]) cylinder(d1=screwd,h=5);
    translate([15,ch/2+16,-9]) rotate([0,fang*-1]) translate([0,0,-8.01]) cylinder(d1=screwd,h=5);
 }

     translate([bod/2-bid/2,-0.01,bid*-.5+2]) cube([bid,ch+0.02,bid]);

  for(m=[0,1])
    translate([m==1?bod:0,0]) mirror([m,0]) {
      for(x=[15,ch/2-1,ch/2+7])
      translate([-3,x,-20]) minkowski() {
      cube([5,2,50]);
      sphere(1);
    }
    minkowski()
     {
  translate([-3,12,-6]) union() {
      cube([5,ch-24,10]);
      translate([-2.1,0,-7.05]) rotate([0,-45,0]) cube([10,ch-24,10]);
    }
    sphere(1);
  }
}
 }
}
module screwhole(d=screwd,h=10,chamfer="bottom",bolthead=0)
{
  chamh=.8;
  chamw=1;
  cylinder(d=d,h=h,$fn=20);
  if(chamfer=="top") {
    translate([0,0,h-chamh*2]) cylinder(d1=d,d2=d+chamw,h=chamh, $fn=20);
  } else if(chamfer=="bottom") {
    translate([0,0,bolthead?(min(6,max(3,h-4)))-.01:0]) cylinder(d1=d+chamw,d2=d,h=chamh,$fn=20);
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
module carriage() {
  difference(){union(){
    translate([-0,ch/2-16,-10]) rotate([0,fang-90]) translate([0,0,-8]) cylinder(d1=screwd2,d2=screwd2+4,h=13);
    translate([-0,ch/2+16,-10]) rotate([0,fang-90]) translate([0,0,-8]) cylinder(d1=screwd2,d2=screwd2+4,h=13);
    translate([cw,ch/2-16,-10]) rotate([0,180-fang-90]) translate([0,0,-8]) cylinder(d1=screwd2,d2=screwd2+4,h=13);
    translate([cw,ch/2+16,-10]) rotate([0,180-fang-90]) translate([0,0,-8]) cylinder(d1=screwd2,d2=screwd2+4,h=13);
  translate([-4,0]) cube([cw+8,ch,5]);
  intersection()
  {
    translate([0,0,-1*bod]) cube([cw,ch,bod]);
    union(){
    translate([bod/2,0,-5]) rotate([-90,0]) cylinder(d=bod,h=ch,$fn=40);
    translate([cw-bod/2,0,-5]) rotate([-90,0]) difference() { cylinder(d=bod,h=ch,$fn=40); }
    }
  }
  translate([bod,4,-1*clh]) rotate([0,0,90]) cylinder(d=8,h=clh,$fn=16);
  translate([bod,ch-4,-1*clh]) rotate([0,0,90]) cylinder(d=8,h=15,$fn=16);
  translate([0,4,-1*clh]) rotate([0,0,90]) cylinder(d=8,h=15,$fn=16);
  translate([0,ch-4,-1*clh]) rotate([0,0,90]) cylinder(d=8,h=15,$fn=16);
  translate([cw-bod,0,-1*clh]) {
    translate([bod,4]) rotate([0,0,90]) cylinder(d=8,h=clh,$fn=16);
    translate([bod,ch-4]) rotate([0,0,90]) cylinder(d=8,h=clh,$fn=16);
    translate([0,4]) rotate([0,0,90]) cylinder(d=8,h=clh,$fn=16);
    translate([0,ch-4]) rotate([0,0,90]) cylinder(d=8,h=clh,$fn=16);
  }
    translate([cw/2-hw1/2-4.99,ch/2-hh1/2+4,5]) cube([5,hh1-8,5]);
    translate([cw/2+hw1/2-0.01,ch/2-hh1/2+4,5]) cube([5,hh1-8,5]);
  }
   translate([-0,ch/2-16,-10]) rotate([0,fang-90]) translate([0,0,-0.01]) cylinder(d=screwd,h=6.02);
   translate([-0,ch/2+16,-10]) rotate([0,fang-90]) translate([0,0,-0.01]) cylinder(d=screwd,h=6.02);
   translate([cw,ch/2-16,-10]) rotate([0,180-fang-90]) translate([0,0,-0.01]) cylinder(d=screwd,h=6.02);
   translate([cw,ch/2+16,-10]) rotate([0,180-fang-90]) translate([0,0,-0.01]) cylinder(d=screwd,h=6.02);

  translate([cw/2-hw1/2,ch/2-hh1/2,-0.01]) cube([hw1,hh1,20]);
  translate([cw/2-hw2/2,ch/2-hh2/2,-10]) cube([hw2,hh2,30]);
  translate([cw/2-hw1/2-2.5,ch/2-hh1/2+3.99,7.5]) rotate([-90,0]) cylinder(d=screwd,h=hh1);
  translate([cw/2+hw1/2+2.5,ch/2-hh1/2+3.99,7.5]) rotate([-90,0]) cylinder(d=screwd,h=hh1);
//  translate([cw/2-15,ch/2-20,-10]) cube([30,40,20]);
//  translate([cw/2-15,ch/2,-10]) rotate([0,0,90]) cylinder(d=40,h=40);
//  translate([cw/2+15,ch/2,-10]) rotate([0,0,90]) cylinder(d=40,h=40);
  translate([bod,4,-20]) rotate([0,0,90]) {
    cylinder(d=screwd,h=30,$fn=16);
    translate([0,0,bod-2]) cylinder(d=nutd,h=4,$fn=6);
  }
  translate([bod,ch-4,-20]) rotate([0,0,90]) {
    cylinder(d=screwd,h=30,$fn=16);
    translate([0,0,bod-2]) cylinder(d=nutd,h=4,$fn=6);
  }
  translate([0,4,-20]) rotate([0,0,90]) {
    cylinder(d=screwd,h=30,$fn=16);
    translate([0,0,bod-2]) cylinder(d=nutd,h=4,$fn=6);
  }
  translate([0,ch-4,-20]) rotate([0,0,90]) {
    cylinder(d=screwd,h=30,$fn=16);
    translate([0,0,bod-2]) cylinder(d=nutd,h=4,$fn=6);
  }
  translate([cw-bod,0])
  {
    translate([bod,4,-20]) rotate([0,0,90]) {
      cylinder(d=screwd,h=30,$fn=16);
      translate([0,0,bod-2]) cylinder(d=nutd,h=4,$fn=6);
    }
    translate([bod,ch-4,-20]) rotate([0,0,90]) {
      cylinder(d=screwd,h=30,$fn=16);
      translate([0,0,bod-2]) cylinder(d=nutd,h=4,$fn=6);
    }
    translate([0,4,-20]) rotate([0,0,90]) {
      cylinder(d=screwd,h=30,$fn=16);
      translate([0,0,bod-2]) cylinder(d=nutd,h=4,$fn=6);
    }
    translate([0,ch-4,-20]) rotate([0,0,90]) {
      cylinder(d=screwd,h=30,$fn=16);
      translate([0,0,bod-2]) cylinder(d=nutd,h=4,$fn=6);
    }
  }
  translate([cw-bod/2,-.01,-5]) rotate([-90,0]) cylinder(d=bid,h=ch+0.02,$fn=40);
  translate([bod/2,-.01,-5]) rotate([-90,0]) cylinder(d=bid,h=ch+0.02,$fn=40);
  translate([bod/2-bid/2,-0.01,-5]) cube([bid,ch+0.02,5]);
}
}
module shroud_bracket(mount_height=30,face_depth=12,middle=false,depth=40)
{
  sang=atan(depth/20);
  slen=depth*1.5;
  
   translate([depth,0,10]) difference() {
     union(){
    translate([0,0,30-mount_height]) cube([face_depth,40,mount_height]);
       translate([-10,0,30-mount_height]) cube([face_depth+10,40,10]);
     }
    translate([-1,-1,10]) cube([20,11,30]);
    translate([-1,30,10]) cube([20,11,30]);
    if(!middle)
    {
      translate([-10.5,-4.5,-12]) mirror([0,0,1]) bearing_bracket();
    }
    translate([1.2,40.01]) rotate([90,0]) cylinder(d=8,h=40.02);
    translate([.1,-0.2,30-mount_height]) rotate([0,fang,0]) {
      *translate([-5,0])
        cube([20,40.2,5]);
      translate([5.2,4]) {
        cylinder(d=screwd+.2,h=30,$fn=20);
        translate([0,0,9]) {
          translate([0,0,2.49]) cylinder(d1=screwd2+9,d2=screwd2+5,h=30,$fn=50);
//          translate([0,0,2.49]) cylinder(d2=screwd2,d1=screwd2-1.5,h=2.51,$fn=50);
          cylinder(d2=screwd2-1.5,d1=screwd2-6,h=2.5,$fn=50);
          *translate([-20,-6,-25]) cube([10,12,45]);
        }
      }
      translate([5.2,36]) {
        cylinder(d=screwd+.2,h=30,$fn=20);
        translate([0,0,9]) {
          translate([0,0,2.49]) cylinder(d1=screwd2+9,d2=screwd2+5,h=30,$fn=50);
//          translate([0,0,2.49]) cylinder(d2=screwd2,d1=screwd2-1.5,h=2.51,$fn=50);
          cylinder(d2=screwd2-1.5,d1=screwd2-6,h=2.5,$fn=50);
          *translate([-20,-6,-25]) cube([10,36,45]);
        }
      }
    }
    
    translate([2.2,-.2,30-mount_height]) mirror([1,0]) rotate([0,fang,0]) {
      *translate([-5,0])
        cube([20,40.2,5]);
      translate([5.2,4]) {
        cylinder(d=screwd+.2,h=30,$fn=20);
        translate([0,0,9]) {
          translate([0,0,2.49]) cylinder(d1=screwd2+9,d2=screwd2+5,h=30,$fn=50);
//          translate([0,0,2.49]) cylinder(d2=screwd2,d1=screwd2-1.5,h=2.51,$fn=50);
          cylinder(d2=screwd2-1.5,d1=screwd2-6,h=2.5,$fn=50);
          *translate([-20,-6,-25]) cube([10,12,45]);
        }
      }
      translate([5.2,36]) {
        cylinder(d=screwd+.2,h=30,$fn=20);
        translate([0,0,9]) {
          translate([0,0,2.49]) cylinder(d1=screwd2+9,d2=screwd2+5,h=30,$fn=50);
//          translate([0,0,2.49]) cylinder(d2=screwd2,d1=screwd2-1.5,h=2.51,$fn=50);
          cylinder(d2=screwd2-1.5,d1=screwd2-6,h=2.5,$fn=50);
          *translate([-20,-6,-25]) cube([10,36,45]);
        }
      }
    }
    
  translate([-3,20,20]) rotate([0,90,0])
   {
     cylinder(d=3.6,h=20);
   }
    translate([depth*-1,20,10]) rotate([0,sang,0]) translate([0,0,-10]) rotate([0,0,45]) cylinder(d1=38,d2=10,h=slen+4,$fn=60);
  }

}
module shroud_body(depth=30,mount_height=30,face_depth=12,middle=true,hollow=false) {
  sang=atan(depth/20);
  slen=depth*1.5;
  difference(){union(){
   translate([depth-3,20,30]) rotate([0,90,0]) difference() {
     translate([-5,-5,-4]) cube([10,10,12]);
     //cylinder(d=10,h=8);
     translate([0,0,1]) cylinder(d=3.5,h=7.01);
   }
     rotate([0,sang-90,0]) difference(){
        cube([6,40,40]);
        translate([-0.01,20,20]) rotate([0,90]) cylinder(d=38,h=2.02,$fn=60);
      }
      difference(){
        intersection()
        {
        translate([0,0,0]) {
          difference(){
            translate([-15,0,0]) cube([depth+25,40,40]);
            translate([-15,-.01,-8.01]) rotate([0,sang-90,0]) cube([depth/2,40.02,40.02]);
          }
        }
        translate([-0.01,20,20]) rotate([0,sang,0]) translate([0,0,-10]) rotate([0,0,45]) cylinder(d1=45,d2=15,h=slen,$fn=50);
        }
        *translate([0,-0.01,-5]) rotate([0,70,0]) cube([20,40.02,40]);
        translate([depth-10,20,30]) rotate([0,90,0]) cylinder(d=3.5,h=30);
      }
    }
    translate([-1,0,-0.5]) rotate([0,sang-90,0]) {
      translate([-.01,4,4]) rotate([0,90]) {
        cylinder(d=screwd,h=20.02,$fn=14);
        translate([0,0,4]) cylinder(d=nutd,h=4,$fn=6);
      }
      translate([-.01,36,4]) rotate([0,90]) {
        cylinder(d=screwd,h=7,$fn=14);
        translate([0,0,4]) cylinder(d=nutd,h=4,$fn=6);
      }
      translate([-.01,4,36]) rotate([0,90]) {
        cylinder(d=screwd,h=20.02,$fn=14);
        translate([0,0,4]) cylinder(d=nutd,h=4,$fn=6);
      }
      translate([-.01,36,36]) rotate([0,90]) {
        cylinder(d=screwd,h=7,$fn=14);
        translate([0,0,4]) cylinder(d=nutd,h=4,$fn=6);
      }
      translate([-.01,4,36]) rotate([0,90]) cylinder(d=screwd,h=7,$fn=14);
      translate([-.01,36,36]) rotate([0,90]) cylinder(d=screwd,h=7,$fn=14);
    }
    if(hollow)
      translate([-0.01,20,21]) rotate([0,sang,0]) translate([0,0,-10]) rotate([0,0,45]) cylinder(d1=38,d2=10,h=slen+4,$fn=60);
  }
  
}
module shroud_base(depth=30)
{
  sang=atan(depth/20);
  slen=depth*1.5;
  intersection(){
    translate([-0.01,20,20]) rotate([0,sang,0]) translate([0,0,-10]) rotate([0,0,45]) cylinder(d1=45,d2=15,h=slen,$fn=50);
  difference(){
    translate([0,10,38]) cube([depth,20,2]);
    translate([depth-40,0,20]) rotate([0,79,0]) translate([0,20,0]) cylinder(d1=30,d2=24,h=45,$fn=50);
  }
}
}
module shroud(depth=30,mount_height=30,face_depth=12,middle=true) {
  sang=atan(depth/20);
  slen=depth*1.5;
  echo(str("Shroud: ", sang, " / ", slen));
  shroud_base(depth);
  difference(){union(){
    shroud_body(depth,mount_height,face_depth,middle);
    shroud_bracket(mount_height,face_depth,middle);
    if(middle)
      translate([depth-10,20,32 - mount_height]) intersection() {
        cylinder(d=37,h=mount_height,$fn=50);
        translate([9,-6]) cube([19,12,mount_height]);
      }
    }
    if(middle) translate([depth+4,20,0]) cylinder(d=8,h=mount_height+20,$fn=20);
//} }
    translate([-0.01,20,21]) rotate([0,sang,0]) translate([0,0,-10]) rotate([0,0,45]) cylinder(d1=38,d2=10,h=slen+4,$fn=60);
}
  //radial_flow();
}

module radial_flow()
{
    translate([57,20,35]) difference() {
    cylinder(d=40,h=5,$fn=50);
    translate([0,0,-0.01]) cylinder(d=bigd+2,h=5.02,$fn=50);
    translate([0,0,1.01]) difference(){
      cylinder(d2=bigd+8,d1=bigd+10,h=4,$fn=50);
      cylinder(d2=bigd+4,d1=bigd+8,h=4,$fn=50);
    }
//    translate([-28.5,
  }

}

module mount(mode="v6"){
difference(){
  union(){
    cube([mw,40,25]);
    translate([0,0,-1*off]) cube([mw,40,off]);
    //translate([29,20,0]) cylinder(d=30,h=33,$fn=50);
  }
  //translate([29,20,-0.01]) cylinder(d=28,h=33.02,$fn=40);
  translate([0,-0.01,15]) rotate([0,fang,0]) {
    translate([-4,0,0]) cube([16.5,40.02,20]);
    translate([7,4,-30.01]) cylinder(d=screwd,h=40,$fn=20);
    translate([7,36,-30.01]) cylinder(d=screwd,h=40,$fn=20);
    translate([-7,20,-10]) cylinder(d1=36,d2=40,h=20,$fn=80);
    translate([-1,0,-4]) rotate([0,-1*fang,0]) translate([-7,20,-10]) cylinder(d1=36,d2=40,h=20,$fn=80);
  }
  translate([4,20,-1*off-.01]) cylinder(d=screwd2,h=8+off,$fn=20);
  translate([mw-4,20,-1*off-.01]) cylinder(d=screwd2,h=8+off,$fn=20);
  translate([mw,0,0]) mirror([1,0,0]) translate([0,-0.01,15]) rotate([0,fang,0]) {
    translate([-4,0,0]) cube([16.5,40.02,20]);
    translate([7,4,-30.01]) cylinder(d=screwd,h=40,$fn=20);
    translate([7,36,-30.01]) cylinder(d=screwd,h=40,$fn=20);
    translate([-7,20,-10]) cylinder(d1=36,d2=40,h=20,$fn=80);
    translate([-1,0,-4]) rotate([0,-1*fang,0]) translate([-7,20,-10]) cylinder(d1=36,d2=40,h=20,$fn=80);
  }
  translate([mw/2,20,-1*off-0.01]) cylinder(d=bigd,h=off+27.02,$fn=80);
  translate([mw/2-17,-0.01,-6.01]) {
    intersection(){
      cube([34,40.02,50.02]);
      minkowski(){
      translate([10,0,10]) cube([14,35.02,50.02]);
      sphere(10,$fn=50);
      }
    }
  }
  fsize=32;
  translate([mw/2-fsize/2,-0.01,off*-1+4]) rotate([-90,0,0]) cylinder(d=screwd,h=58,$fn=30);
  translate([mw/2+fsize/2,-0.01,off*-1+4]) rotate([-90,0,0]) cylinder(d=screwd,h=58,$fn=30);
}
//  translate([mw/2,20,-20]) cylinder(d=25,h=62,$fn=30);
}

module fan(w=40,h=40,d=20) {
  r=4;
  difference(){
    intersection(){
      cube([w,d,h]);
      minkowski(){
        translate([r,0,r]) cube([w-r*2,d,h-r*2]);
        sphere(r,$fn=30);
      }
    }
    translate([w*.5,-0.01,h*.5]) rotate([-90,0,0]) {
      cylinder(d1=39.7,d2=39,h=2,$fn=60);
      translate([0,0,1.99]) cylinder(d=39,h=d-3.01,$fn=60);
      translate([0,0,d-2]) cylinder(d1=39,d2=39.6,h=2.02,$fn=60);
    }
    translate([4,-.01,4]) rotate([-90,0,0]) cylinder(d=4.3,h=d+0.02,$fn=20);
    translate([w-4,-0.01,4]) rotate([-90,0,0]) cylinder(d=4.3,h=d+0.02,$fn=20);
    translate([w-4,-0.01,h-4]) rotate([-90,0,0]) cylinder(d=4.3,h=d+0.02,$fn=20);
    translate([4,-0.01,h-4]) rotate([-90,0,0]) cylinder(d=4.3,h=d+0.02,$fn=20);
  }
  translate([w/2,0,h/2]) rotate([-90,0,0]) cylinder(d=24,h=d,$fn=50);
  fan_arms(w,h,d);
  translate([0,d-2,0]) fan_arms(w,h,d);
  /*
  translate([20,d/2,20]) rotate([0,0,0]) translate([0,0,8]) blade();
  translate([20,d/2,20]) rotate([0,72,0]) translate([0,0,8]) blade();
  translate([20,d/2,20]) rotate([0,144,0]) translate([0,0,8]) blade();
  translate([20,d/2,20]) rotate([0,216,0]) translate([0,0,8]) blade();
  translate([20,d/2,20]) rotate([0,288,0]) translate([0,0,8]) blade();
  */
}
module fan_arms(w,h,d) {
  translate([0,0,h/2-4]) fan_arm(w,h,d);
  translate([20,0,h/2]) rotate([0,120,0]) translate([-20,0,-4]) fan_arm(w,h,d);
  translate([20,0,h/2]) rotate([0,240,0]) translate([-20,0,-4]) fan_arm(w,h,d);
}
module fan_arm(w,h,d) {
    difference(){
      cube([20,2,8]);
      translate([3,-.01,8]) rotate([-90,0,0]) cylinder(d=5,h=2.02,$fn=30);
      translate([3,-0.01,0]) rotate([-90,0,0]) cylinder(d=5,h=2.02,$fn=30);
      translate([3,-0.01,0]) cube([4,2.02,2.5]);
      translate([7,-0.01,.5]) rotate([-90,0,0]) cylinder(d=4,h=2.02,$fn=30);
      translate([3,-0.01,5.5]) cube([4,2.02,3]);
      translate([7,-0.01,7.5]) rotate([-90,0,0]) cylinder(d=4,h=2.02,$fn=30);
  }
}

module blade() {
  bw=16;
  bh=8;
translate([0,-1,0]) rotate([0,0,-10]) {
  difference()
  {
//    translate([10,0]) cube([20,2,12]);
    translate([-.5*bw,2,0]) rotate([90,0]) linear_extrude(2) {
    difference(){
      square([bw,bh]);
      translate([bw+20,4]) circle(d=44,$fn=60);
    }
    translate([10,3]) circle(d=14,$fn=50);
    translate([bw-13,3]) circle(d=14,$fn=40);
    translate([0,0]) circle(d=16,$fn=40);
    intersection(){
      translate([-2,0]) square([bw,bh]);
      translate([20,4]) circle(d=44,$fn=60);
    }
//    translate([40,-0.01,5]) cylinder
  }
}
}
}