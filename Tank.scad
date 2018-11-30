include <GT2Pulley.scad>;
part="rail2"; // [all:Preview Tank,all2:Preview New Tank,wheel:Front Wheel,wheel_back:Back Wheel,wheel_pulley:Wheel Pulley,tread:Single Tread Piece,track:Full Track of Tread (3x8),adapter:Stock Motor to Wheel Adapter,adapter2:Small Stepper Pulley,rail:Inside Rail,rail_outside:Outside Rail,rail2:New Rail,rail2_outside:New Outside Rail,frame:Tank Frame,skid:Skid Plate,bumper:Front Bumper,bumper_r:Rear Bumper,battery_pack:Battery Pack]
mid_width=110;
tread_height=18; // Default: 18
tread_width=34; // Default: 34
tread_hole_offset=0;
tread_flap=1;
spike_type=4;
rows=8;
cols=1;
stamp="15";
boltless=0;
total_tracks=40;
wheel_track_diameter=16; // Default: 14
wheel_pulley_teeth=72;
/*
stepper_teeth=14;
belt_teeth=101;
/*/
belt_teeth=150;
stepper_teeth=72;
//*/
servoff=(belt_teeth-wheel_pulley_teeth/2-stepper_teeth/2);
//servoff=39; // 202
motor_offset=-57;
dist=(total_tracks/2-wheel_track_diameter/2)*tread_height;
//dist=160.8;
dr=tread_height*0.2688889; // 4.84
//bd=wheel_track_diameter*4.84;
bd=wheel_track_diameter*dr;
fd=76.89;
//fd=59.68;
echo(str("Total Distance: ", dist, " Big D: ", bd, " Full D: ", fd, " SO: ", servoff));
if(part=="track")
  tread_full();
else if(part=="tread")
  tread2();
else if(part=="wheel")
  wheel(front=1);
else if(part=="wheel_spacer")
  wheel_spacer();
else if(part=="wheel_pulley")
  wheel_pulley();
else if(part=="wheel_edge")
  wheel_edge();
else if(part=="wheel_cap")
{
  difference(){
    cylinder(d=56.81,h=2,$fn=100);
    for(r=[0:90:359]) rotate([0,0,r]) translate([18,0,-.01]) cylinder(d=3,h=60,$fn=20);
    translate([0,0,-.01]) cylinder(d=25,h=2.02,$fn=50);
  }
}
else if(part=="wheel_mid1")
  translate([0,0,9]) rotate([180,0]) intersection(){
    wheel_spikes();
    cylinder(d=60,h=9,$fn=60);
  }
else if(part=="wheel_idler")
  wheel_idler();
else if(part=="wheel_spikes")
  wheel_spikes();
else if(part=="wheel_back")
{
  wheel(front=0);
}
else if(part=="rail")
  //rotate([0,0,90])
    intersection(){
      rail();
      *translate([-22,-5]) cube([90,45,1]);
    }
else if(part=="adapter2")
{
  teeth=20;
  difference() {
    union(){
      pulley("GT2 2mm", tooth_spacing (2,0.254,teeth=teeth) , 0.764 , 1.494, 12, idler = 0, retainer = 1, motor_shaft = 3.2, draw_base = 0, teeth=teeth );
      translate([0,0,7.5]) cylinder(d1=11,d2=15,h=3,$fn=50);
      *translate([0,0,9]) cylinder(d=12.5,h=9,$fn=40);
      translate([-5,-4,9]) cube([10,8,9]);
      cylinder(d=8,h=9,$fn=30);
    }
    translate([-2.6,-1.6,12.99]) cube([5.2,3.2,5.02]);
    translate([0,-8,15]) rotate([-90,0]) cylinder(d=3,h=20,$fn=20);
  }
}
else if(part=="battery_full")
{
  battery_pack("full");
}
else if(part=="battery_pack")
  battery_pack("body");
else if(part=="battery_cap")
  mirror([0,0,1]) battery_pack("cap");
else if(part=="battery_cap2")
  mirror([0,0,1]) battery_pack("cap2");
else if(part=="rail2")
{
  intersection() {
    rotate([0,0,90]) rail2();
    sop=dist-servoff-22;
    linear_extrude(10) {
      circle(d=20,$fn=50);
      translate([0,dist]) circle(d=20,$fn=50);
      translate([-22,sop]) square([44,44]);
      polygon([[-10,0],[-22,sop],[-22,sop+44],[-10,dist],[10,dist],[22,sop+44],[22,sop],[10,0]]);
    }
  }
}
else if(part=="rail2_right")
  rotate([0,0,90]) mirror([1,0]) rail2();
else if(part=="rail2_outside")
  rotate([0,0,-90]) rail2(0);
else if(part=="rail_outside")
  rotate([0,0,-90]) rail(inner=0);
else if(part=="adapter")
  adapter();
else if(part=="frame")
  frame();
else if(part=="teeth_test")
{
  cylinder(d=48.8,h=0.5,$fn=75/4);
  
  #translate([25,-.6]) cube([2,2,2]);
}
else if(part=="skid")
{
  skid_plate();
  *%translate([0,0,26]) rotate([90,0]) rail2();
}
else if(part=="skid2") skid_plate2();
else if(part=="aligner") aligner();
else if(part=="bumper")
  rotate([90,0]) bumper(front=1);
else if(part=="bumper_r")
  rotate([90,0]) bumper(front=0);
else if(part=="stepper") stepper();
else if(part=="all")
  tank();
else if(part=="all2")
  tank2();

//tank_stl();
/*
*for(front=[0,1],right=[0,1])
  translate([right*55,front*55]) wheel(front=front,right=right);
*tread_circle();
*translate([-12,-68.36,45.41]) import("Tank_that_Prints_without_Support/files/tank_tracks.stl");
*rotate([0,0,4]) cylinder(d=146,h=20,$fn=24);
*#translate([65,-3]) rotate([0,0,8]) cube([2,18,20]);
*for(y=[0:18:100],x=[0]) translate([x,y]) tread2(mh=18,mw=34);
*/

module aligner()
{
  //*
  %rail2();
  %translate([0,0,6]) wheel();
  %translate([0,0,52]) mirror([0,0,1]) rail2(inside=0);
  //*/
  difference() {
    translate([22,-bd/2-1,4]) linear_extrude(44) {
      *polygon([[0,0],[0,2],[8,8],[dist-56,8],[dist-48,2],[dist-48,0]]);
      translate([8,0]) square([dist-60,8]);
      translate([8,4]) circle(d=8,$fn=30);
      translate([dist-52,4]) circle(d=8,$fn=30);
    }
    for(x=[0:10:dist-60])
      translate([x+33,-bd/2+3.3,3.99]) cylinder(d=3,h=45,$fn=20);
  }
  //translate([0,0,bd/2]) rotate([90,0]) wheel();
  
}
module battery_pack(which="body")
{
    ph=67;
  if(which=="body") {
    difference(){
      union(){
        cylinder(d=50,h=ph,$fn=100);
        *translate([-25,-25]) cube([25,50,ph]);
      }
      mirrory()
      translate([-25,21.5,-.01]) cube([50,10,ph+.02]);
      mirrorx()
      translate([21.5,-25,-.01]) cube([10,50,ph+.02]);
      translate([0,0,-.01]) cylinder(d=9,h=ph+.02,$fn=30);
      for(r=[0:90:359]) rotate([0,0,45+r]) translate([15,0,-.01]) {
        *rotate([0,0,90]) battery();
        translate([0,0,ph-65])
        cylinder(d=19.2,h=80,$fn=40);
        cylinder(d=10,h=ph-65+.02,$fn=20);
        translate([0,-3]) cube([30,6,ph+10]);
        //if(r%180!=0)
        translate([-15,0]) rotate([0,0,-45]) 
        translate([0,18,-12]) cylinder(d=3,h=ph+20,$fn=12);
      }
    }
  } else if(which=="cap") {
    tallcap=1;
    difference(){
      union(){
        intersection() {
          translate([-25,-25,-4.7]) cube([50,50,9]);
          translate([0,0,0]) cylinder(d=50,h=3,$fn=100);
        }
        if(tallcap) for(r=[45:90:360])
          rotate([0,0,r]) translate([-4,0,-4.7]) cube([8,25,5]);
        translate([0,0,-4.7]) cylinder(d=28,h=6,$fn=100);
      }
      translate([0,0,-4.71]) {
        cylinder(d=22.2,h=7.02,$fn=90);
        *translate([0,0,-1.99]) cylinder(d2=22.2,d1=20,h=2,$fn=90);
      }
      translate([0,0,-5]) rotate([0,0,45]) mirrory()
      translate([-25,22.5,-.01]) cube([50,8,ph+.02]);
      translate([0,0,-5]) rotate([0,0,45]) 
      mirrorx()
      translate([21.5,-25,-.01]) cube([10,50,ph+.02]);
      translate([0,0,-5.01]) cylinder(d=18,h=16,$fn=30);
      translate([0,0,-5.01]) for(r=[45:90:359]) rotate([0,0,r])
        translate([18,0,-1]) cylinder(d=3,h=16,$fn=12);
    }
  } else if(which=="cap2") {
    difference(){
      intersection() {
        translate([-25,-25,2.31]) cube([50,50,4]);
        translate([0,0,2.7]) cylinder(d=50,h=1.3,$fn=100);
      }
      rotate([0,0,45])
      mirrory()
      translate([-25,21.5,-.01]) cube([50,10,ph+.02]);
      rotate([0,0,45]) 
      mirrorx()
      translate([21.5,-25,-.01]) cube([10,50,ph+.02]);
      translate([0,0,-1]) cylinder(d=9.5,h=6,$fn=30);
      for(r=[0:90:359]) rotate([0,0,r])
        translate([15,0,4]) rotate([0,0,90]) battery();
      for(r=[45:90:359]) rotate([0,0,r])
        translate([18,0,-1]) cylinder(d=3,h=6,$fn=12);
    }
  } else if(which=="full") {
    translate([0,0,3.3]) rotate([0,0,45]) battery_pack("body");
    battery_pack("cap");
    *battery_pack("cap2");
    translate([0,0,73]) mirror([0,0,1]) {
      battery_pack("cap2");
      translate([0,0,-2]) mirror([0,0,1]) 
      battery_pack("cap");
    }
  } else if(which=="flat") {
    difference() {
      cube([65,60,14]);
      for(x=[0:19:20])
      translate([-.01,x+15,10]) rotate([0,90,0]) rotate([0,0,-90]) battery();
    }
  }
}
module bumper(front=0,fd=fd)
{
  bo=6.5;
  translate([0,0,1]) {
  difference() {
    union() {
      translate([0,-.01,fd/2]) rotate([-90,0]) cylinder(d=fd,h=mid_width,$fn=100);
      translate([15,0,5.3]) cube([3.5,mid_width,fd-10.6]);
    }
    translate([18.5,-.05,0]) cube([10,mid_width+.1,fd]);
    difference(){
      translate([-10,-1,bo]) cube([60,mid_width+2,fd-bo*2-.4]);
      mirrorz(fd/2)
      for(y=[9,mid_width-11])
      translate([10,y,bo-.01]) cylinder(d1=16,d2=8,h=4,$fn=40);
    }
    if(front)
    {
      //#translate([-14,-1,8]) cube([4,mid_width+2,34])
      for(x=[-13.25,13.25])
        translate([-9,x+mid_width/2,20]) rotate([0,-90]) 
          cylinder(d=16.5,h=40,$fn=50);
      *translate([-14,mid_width/2-14,10]) {
        cube([10,28,20]);
      }
      for(z=[fd/2,0,fd/-2])
        mirrory(mid_width/2) for(y=[7,17,27]) translate([-30,y,z*.7+fd/2]) rotate([0,90]) rotate([0,z,0]) translate([0,0,-10]) cylinder(d=5,h=40,$fn=20);
      translate([-30,mid_width/2,fd*.7]) rotate([0,90]) rotate([0,20,0]) translate([0,0,-10]) cylinder(d=10,h=30,$fn=30);
    } //else
    translate([-10,-1,fd/2]) rotate([-90,0]) scale([0.6,1]) cylinder(d=fd-bo*2-.4,h=mid_width+2,$fn=50);
    mirrorz(fd/2) translate([-.2,-1,-.1]) {
      cube([30,mid_width+2,5.4]);
      for(y=[10,mid_width-10])
        translate([10,y]) {
          cylinder(d=3,h=20,$fn=20);
          *translate([0,0,7]) cylinder(d=7.4,h=4,$fn=6);
        }
    }
    
  }
}
}
module skid_plate2()
{
  skid_thick=8;
  xo=23;
  holes=[0:10:dist-44];
  difference() {
    cube([dist,mid_width,skid_thick]);
    mirrorx(dist/2) translate([-.01,-.01,5]) cube([xo-4,mid_width+.02,skid_thick-3.99]);
    for(x=holes)
      translate([xo+x,-.01,skid_thick/2]) {
        rotate([-90,0]) cylinder(d=3,h=mid_width+.02,$fn=20);
        mirrory(mid_width/2)
        translate([-3.6,8,skid_thick*-.5-.01])
          cube([7.2,x%20==0?3.5:3.5,skid_thick+.02]);
      }
    mirrory(mid_width/2) mirrorx(dist/2)
    translate([10,10,-.01]) cylinder(d=3,h=skid_thick+.02,$fn=20);
  }
  *#skid_plate();
}
module skid_plate()
{
  skid_thick=1.2;
  holes=[0:10:dist-44];
  difference() { union() {
      for(y=[0,mid_width/2-1,mid_width-2]) translate([0,y,1+skid_thick]) cube([dist,2,4]);
      mirrorx(dist/2) translate([0,0,1]) cube([19,mid_width,5.2]);
      for(x=[0,dist-2])
        translate([x,0,1+skid_thick])
          cube([2,mid_width,4]);
      for(x=holes)
        if(wheel_track_diameter>10||(x<dist-100||x>dist-55))
        translate([x+17,0,1+skid_thick]) {
          translate([-0.5,0]) cube([3,mid_width,4]);
          translate([10,0]) cube([2,mid_width,4]);
        }
      translate([0,0,1]) cube([dist,mid_width,skid_thick]);
      mirrory(mid_width/2)
      for(x=holes) if(wheel_track_diameter>10||(x<dist-100||x>dist-55)) translate([23+x,0,2]) difference() {
        translate([0,4]) rotate([90,0])
        linear_extrude(4) {
          polygon([[-4,0],[-4,4],[4,4],[4,0]]);
          translate([0,3]) circle(d=8,$fn=24);
        }
      }
      mirrorx(dist/2) mirrory(mid_width/2)
      translate([10,10,2]) cylinder(d1=16,d2=8,h=4,$fn=30);
    }
    mirrory(mid_width/2) for(x=holes) if(wheel_track_diameter>10||(x<dist-100||x>dist-55)) translate([23+x,0,2]) 
        translate([0,-.01,3]) rotate([-90,0]) cylinder(d=3,h=4.02,$fn=20);
    mirrorx(dist/2) mirrory(mid_width/2)
    translate([10,10,-.01]) {
      cylinder(d=3,h=10,$fn=20);
      cylinder(d=9,h=3.5,$fn=30);
    }
  }
}
module wheel_spacer() {
  union() {
  mirrorz(20) translate([0,0,4]) %difference() {
    cylinder(d=22,h=7,$fn=40);
    translate([0,0,-.01]) cylinder(d=8,h=7.02,$fn=30);
  }
  translate([0,0,11])
    difference() {
      cylinder(d=13,h=18,$fn=40);
      translate([0,0,-.01]) cylinder(d=9,h=30.02,$fn=30);
    }
  }
}
module wheel_idler()
{
  translate([0,0,2])
  difference() {
    cylinder(d=bd,h=6,$fn=bd*2);
    translate([0,0,-.01]) cylinder(d=22.4,h=8.02,$fn=80);
    for(r=[0:45:359]) rotate([0,0,r]) translate([18,0,-.01]) cylinder(d=3,h=10,$fn=20);
  }
}
module wheel_edge()
{
  difference() {
    union() {
      cylinder(d=bd+6,h=2,$fn=100);
      cylinder(d=bd,h=8,$fn=100); 
    }
    translate([0,0,-.01]) cylinder(d=22.2,h=8.02,$fn=60);
    for(r=[0:45:359]) rotate([0,0,r]) translate([18,0,-.01]) {
      if(r%90==0)
      {
        cylinder(d=10,h=8.04,$fn=20);
        *translate([0,0,2.99]) cylinder(d1=7.2,d2=3,h=2,$fn=4);
      }
      else
      {
        cylinder(d=6,h=4,$fn=20);
        *translate([0,0,2.99]) cylinder(d1=6,d2=3,h=2,$fn=20);
      }
      cylinder(d=3,h=8.02,$fn=20);
    }
  }
}
module wheel_spikes()
{
  difference() {
    union() {
      cylinder(d=bd,h=12,$fn=100);
      for(r=[0:360/(wheel_track_diameter):359]) rotate([0,0,r])
        translate([0,bd/2-1.4,6]) spike();
    }
    translate([0,0,-.01]) cylinder(d=20,h=20,$fn=80);
    for(r=[0:45:359]) rotate([0,0,r]) translate([18,0,-.01]) cylinder(d=3,h=20,$fn=20);
  }
}
module spike(deep=0) {
  union() {
    if(spike_type==0)
      rotate([-90,90]) scale([1,0.5,1]) cylinder(d1=11.4,d2=0,h=6,$fn=4);
    else if(spike_type==2)
      rotate([-90,90]) scale([1,1,1]) cylinder(d1=8,d2=5,h=5,$fn=8);
    else if(spike_type==1)
      translate([-2,0,-4]) linear_extrude(8) {
        polygon([[0,0],[1,3],[5,3],[6,0]]);
        *square([5,3]);
      }
    else if(spike_type==3)
    {
      translate([0,0,-2]) cylinder(d=8,h=4,$fn=32);
    } else if(spike_type==4)
      rotate([-90,90]) scale([1,0.5,1]) cylinder(d1=11.4,d2=3,h=4,$fn=4);
    else if(spike_type==5)
        rotate([-90,90]) scale([1,0.5,1]) cylinder(d=11.4,h=deep?deep:4,$fn=4);
  }
}
module wheel_pulley()
{
  teeth=wheel_pulley_teeth;
  ts=str(teeth);
  difference(){
    union() {
      *cylinder(d=bd,h=2,$fn=100);
      intersection() {
      translate([0,0,2]) pulley("GT2 2mm" , tooth_spacing (2,0.254,teeth=teeth) , 0.764 , 1.494, 12, idler = 1, retainer = 1, motor_shaft = 3.2, draw_base = 0, teeth=teeth );
        translate([0,0,3]) cylinder(d=bd,h=7,$fn=bd*2);
      }
    }
    if(teeth>70)
    rotate([0,0,22]) translate([0,0,9.5]) linear_extrude(5,convexity=10) text(str(ts[0],"        ",ts[1]),size=9,valign="center",halign="center");
    translate([0,0,-.01]) cylinder(d=22.4,h=10.02,$fn=80);
    for(r=[0:45:359]) rotate([0,0,r]) translate([18,0,-.01]) {
      cylinder(d=3,h=12,$fn=20);
      *translate([0,0,9]) cylinder(d=9,h=2,$fn=30);
    }
  }
}

module frame()
{
  //translate([62.31,78.67])
  {
    //translate([-11,0,29]) rotate([180,0]) rotate([0,0,-90])
  {
    *#translate([-59.35,88.17,76]) import("Tank_that_Prints_without_Support/files/tank_frame.stl");
  }
  translate([-62.31,-78.67]) {
    difference() {
      cube([124.62,157.3,4.96]);
      for(x=[5,99]) {
      translate([x,5,-.01]) cube([21,58,5.02]);
      translate([x,68,-.01]) cube([21,44.5,5.02]);
      }
      translate([5,117.5,-.01]) cube([114.5,60,5.02]);
      translate([31,-.01,-.01]) cube([62.5,17,5.02]);
      translate([31,35,-.01]) cube([62.5,28,5.02]);
      translate([31,68,-.01]) cube([62.5,44.5,5.02]);
    }
    for(x=[-15,105],y=[23,152.3]) translate([x+(y==23&&x==105?2:0),y]) {
      //if(boltless)
        cube([35-(y==23?2:0),5,4.96]);
      if(!boltless) {
        *translate([0,2.5,2.5]) rotate([0,90]) {
          difference(){
            cylinder(d=15,h=35,$fn=30);
            translate([0,0,-.01]) cylinder(d=8,h=35,$fn=24);
          }
        }
      }
    }
  }
  mirrorx() translate([5.25,-61.8]) motor_holder();
}

}
module motor_holder() {
  difference() {
    cube([21.5,18,53]);
    translate([-.01,3,43]) cube([21.6,12,20]);
  }
}
module stepper(h=40) {
  difference(){
    translate([-21,-21,-h]) cube([42,42,h]);
    mirrorx() mirrory() translate([-15.5,-15.5,-5]) cylinder(d=3,h=10,$fn=20);
  }
  cylinder(d=5,h=15,$fn=20);
}
module tank2()
{
  *translate([-32.5,75,-19]) battery_pack("flat");
  //difference()
  union() {
  translate([mid_width*.5,0,fd*-.5-1]) rotate([0,0,90]) bumper(front=1);
  translate([mid_width*-.5,dist,fd*-.5-1])  rotate([0,0,-90]) bumper(front=0);
  translate([-37.5,dist]) rotate([0,90,0]) rotate([0,0,45]) battery_pack("full");
  }
  //mirrorx()
  union() {
  translate([mid_width/2+8,0]) rotate([0,90]) wheel();
  translate([mid_width/2+8,dist]) rotate([0,90]) wheel();
    //translate([mid_width/2+54,0]) rotate([90,0,-90]) rotate([0,0,180]) rail2(inside=0);
  translate([mid_width/2+28.5,tread_height/-2,bd/-2-3.6]) {
    for(y=[tread_height:tread_height:dist]) {
      translate([0,y]) mirror([0,0,tread_flap]) tread2();
      translate([0,dist-y+tread_height,bd+7.2]) rotate([180,0]) mirror([0,0,tread_flap]) tread2();
    }
    }
  for(r=[-180:360/wheel_track_diameter:5])
  rotate([r,0]) translate([mid_width/2+28.5,tread_height/-2,bd/-2-3.6]) mirror([0,0,tread_flap]) tread2();
  
  translate([0,dist]) for(r=[-180:360/wheel_track_diameter:5])
  rotate([r+180,0]) translate([mid_width/2+28.5,tread_height/-2,bd/-2-3.6]) mirror([0,0,tread_flap]) tread2();
  }
  translate([mid_width*.5,0,fd*-.5-1]) rotate([0,0,90]) skid_plate();
  %mirrorx()
    //translate([mid_width/-2,dist+motor_offset+2.5])
    translate([mid_width/-2,dist-servoff])
      rotate([0,-90]) stepper(50);
  translate([mid_width*.5,0]) {
    rotate([0,0,90]) rotate([90,0]) rail2(color=0);
    *translate([8+tread_width,0]) mirror([1,0]) rotate([0,0,90]) rotate([90,0]) rail2(inside=0,color=0);
  }
}
module tank()
{
  real_wheel=0;
  translate([0,mid_width/2+8]) mirrory(-(mid_width/2)+2) translate([-7,0,0]) rotate([-90,0])
  {
    translate([0,0,2]) color("green") rail();
    translate([0,0,52]) rotate([0,180])
      rail(inner=0);
    translate([-65,17.5,7]) {
      if(!real_wheel)
        difference(){
          cylinder(d=57,h=40,$fn=50);
          translate([0,0,-.01]) cylinder(d=8,h=40.02,$fn=30);
        }
      else
        wheel(front=0);
    }
  }
  mirrory() mirrorx(-9)
  %translate([-72,34,-18]) rotate([-90,0]) cylinder(d=8,h=60,$fn=30);
  for(x=[-72,54])
  translate([x,-94,25])
    rotate([-90,0]) cylinder(d=8,h=188,$fn=30);
  *rotate([0,0,90]) translate([0,0,boltless?22.5:30]) frame();
  translate([-75,-40,-46]) skid_plate();
}
module adapter()
{
  stock=0;
  set_screw=0;
  adapter_size=stock?13.86:13.4;
  adapter_hole=8;
  adapter_notch=0;
  *#rotate([0,0,15.45]) translate([-141,27.7,31.43]) import(str("Tank_that_Prints_without_Support/files/tank_adapter.stl"));
  difference() {
    union() {
      cylinder(d=28.5,h=2,$fn=60);
      translate([adapter_size*-.5,adapter_size*-.5,2]) cube([adapter_size,adapter_size,9.52]);
      if(stock) difference(){
        cylinder(d=28.5,h=3.51,$fn=60);
        translate([0,0,1.99]) cylinder(d=25.5,h=5,$fn=50);
      }
    }
    if(set_screw) {
      translate([0,0,4]) rotate([0,90,0]) cylinder(d=2.5,h=10,$fn=30);
    }
    rotate([0,0,stock?-74.4:0]) translate([0,0,-.01]) linear_extrude(15) difference() {
      circle(d=adapter_hole,$fn=adapter_hole*4);
      if(adapter_notch)
        translate([0.96,adapter_hole*-1]) square([5,adapter_hole*2]);
    }
  }
  
}

module rail2(inside=1,right=1,color=1)
{
  thick=4;
  full=1;
  top_shelf=0;
  echo(str("Rail 2 FD: ",fd));
  *translate([-20,-25,-6]) difference() {
    cube([12*25.4,50,5]);
    for(hi=[0:5])
      translate([20+hi*55, 25, -.01]) cylinder(d=8,h=5.02,$fn=40);
  }
  difference() {
    union() {
      for(x=full?[0,dist]:[0]) {
        color(color?"blue":undef) translate([x,0]) cylinder(d=full?fd:20,h=thick,$fn=100);
        translate([x,0,thick-.01]) cylinder(d1=14,d2=12,h=x>0?6:6,$fn=30);
        if(top_shelf)
          color("green") translate([x,40]) {
            cylinder(d=20,h=thick,$fn=50);
            translate([-10,-20]) linear_extrude(thick) polygon([[-13,-10],[33,-10],[19.5,23],[.5,23]]);
          }
      }
      translate([0,fd*-.5,.01]) cube([dist/(full?1:1.8),fd,thick-.02]);
      *mirrory() translate([0,10,thick]) cube([20,3,2]);
    }
    for(x=[0,dist],y=[0])
      translate([x,y,-1]) cylinder(d=8.4,h=thick+15,$fn=30);
    //for(m=full?[0,1]:[0]) mirror([m,0]) translate(m?[dist*-1,0]:[])
    for(x=[23:10:dist-16],y=[fd*-.5+4,fd/2-4]) {
      //if(x<(y<0?70:60)||x>(y<0?75:65))
      translate([x,y,-1]) cylinder(d=3,h=thick+5,$fn=20);
    }
    if(inside) translate([right*dist,0]) mirror([right,0])
    {
      translate([servoff-15.5,-15.5,-1]) {
        cylinder(d=3,h=thick+2,$fn=20);
      //translate([x,0])
        for(r=[-8:5]) rotate([0,0,r]) {
          //translate([31,0]) cylinder(d=3,h=thick+2,$fn=20);
          translate([31,31]) cylinder(d=3,h=thick+2,$fn=20);
          //translate([0,31]) cylinder(d=3,h=thick+2,$fn=20);
          translate([15.5,15.5]) cylinder(d=20,h=thick+2,$fn=50);
        }
      }
      translate([servoff+15.5,-15.5,-1]) cylinder(d=3,h=thick+2,$fn=20);
      translate([servoff-15.5,15.5,-1]) cylinder(d=3,h=thick+2,$fn=20);
    }
  }
}
module rail(inner=1,left=1)
{
  belt_drive=1;
  rail_flat=1;
  rail_thickness=4;
  echo(str("Rail Distance: ", dist));
  *#translate(inner?(left?[-80.8,45.33,21.54]:[80.8,45.33,-108.37+11]):(left?[80.06,45.57,22.6]:[-80.06,45.57,141.38])) import(str("Tank_that_Prints_without_Support/files/tank_",(left?"left":"right"),"_",(inner?"inner":"outer"),"_rail.stl"));
  mirror([inner==left?0:1,0]) translate(left&&!inner?[0.75,0]:[])
  union() {
    if(!rail_flat) {
      mirrorx(-5.7) translate([3.7,16.633]) difference() {
        cube([20,2,22]);
        translate([19.3,-.01]) rotate([0,-41.3]) cube([30,3,30]);
      }
      translate([-35.33,-6.37]) {
        cube([39,3.5,22]);
        rotate([90,0]) linear_extrude(3.5) polygon([[0,0],[0,2],[10,3.2],[12,3.3],[15,3.5],[16,3.6],[39,3.7],[39,0]]);
      }
    }
      
  if(!inner&&0)
  {
    translate([60.25,17.7,2]) {
      *cylinder(d=24,h=7.13,$fn=50);
      for(x=inner?[-dist]:[0,-dist])
      translate([x,0]) {
        cylinder(d=7.8,h=10,$fn=20);
        cylinder(d=10,h=1,$fn=30);
      }
    }
  }
  difference() {
    union() {
      *if(!boltless)
      translate([-35.33,-6.37]) cube([39,3.5,rail_thickness]);
      if(boltless) {
        translate([54.22,-34.7]) difference() {
          cube([12,12,inner?9:11.13]);
          translate([3.32,3.32-(inner?0:-.5),6]) cube([5.35,5.35,10]);
        }
        translate([-74.8,-33.7]) difference() {
          cube([12,11,11]);
          translate([3.32,3,4]) cube([5.35,5.2,10]);
        }
      } else {
        for(x=[-dist+54,54])
          translate([x+6,-33+8]) {
            cylinder(d=20,h=rail_thickness,$fn=40);
            *translate([0,0,4]) cylinder(d=14,h=18,$fn=30);
            *translate([-10,-6]) difference() {
              cube([20,16,22]);
              translate([6,5,-.01]) mirror([0,1]) cube([8,10,24]);
            }
          }
      }
      if(!rail_flat)
      for(y=[-6.37,11.63]) translate([-15.2,y]) difference() {
        union(){
          if(boltless)
          {
            cube([18.9,12,22]);      
            if(!inner)
              translate([3.6,4,22]) cube([11.5,4.5,6.44]);
          } else {
            linear_extrude(22) union() {
              translate([6,6]) circle(d=12,$fn=30);
              translate([6,0]) square([7,12]);
              translate([13,6]) circle(d=12,$fn=30);
              if(y<0)
              translate([0,0]) square([19,6]);
            }
          }
        }
        if(inner&&boltless)
            translate([3.48,3.66,14]) cube([11.7,4.65,20]);
      }
      linear_extrude(rail_thickness) {
        if(rail_flat)
        {
          *translate([-40,-8]) square([22,24]);
        } else
          translate([-15.32,-2.87]) square([19,18]);

        translate([60.25,17.7]) difference() {
          union() {
            translate([-60.25,-20]) {
              color("blue") for(x=[60,60-dist])
                translate([x,21.5]) circle(d=50,$fn=80);
              translate([-dist/2,-4]) square([dist,50]);
            }
            if(inner&&!belt_drive)
              circle(d=33.9,$fn=50);
            circle(d=18,$fn=36);
            rotate([0,0,180]) translate([-10,0]) square([20.25,43]);
            rotate([0,0,90]) translate([-6,0]) square([20.25,dist]);
            translate([-dist+9.75,0]) rotate([0,0,180]) square([20.25,43]);
            translate([-dist,0]) circle(d=18,$fn=36);
          }
          if(inner&&!belt_drive)
            circle(d=26.2,$fn=40);
          else
            circle(d=8,$fn=30);
          translate([-dist,0]) circle(d=8,$fn=30);
          
        }
        if(!boltless&&belt_drive&&inner)
          translate([60,18]) translate([motor_offset,0]) translate([-21.5,-21.5]) {
            square([63,43]);
            translate([63,0]) polygon([[0,0],[16,0],[14,17.5],[10,17.5],[10,25],[14,30],[0,43],[0,17.5]]);
          }
      }
    }
    
    if(!boltless&&belt_drive)
    {
      translate([20,18,-.01]) {
        translate([motor_offset,0]) {
          %if(inner) {
          cylinder(d=20,h=20,$fn=40);
          translate([70,0]) cylinder(d=20,h=20,$fn=40);
          translate([0,-10]) cube([70,20,20]);
          }
          //for(x=[8,15.75,23.5,31.25,39,46.75,54.5])
          for(x=[7:31/4:62]) {
          echo(str("X: ",x));
            translate([x,0]) {
              if(x%.5!=0)
              cylinder(d=20,h=20,$fn=50);
              mirrorx() mirrory() translate([-15.5,-15.5]) cylinder(d=3,h=20,$fn=16);
            }
          }
        }
      }
    }
    
    if(!boltless)
    {
      *translate([-10,0]) translate(inner&&boltless?[1,0]:[-13,0]) for(x=[5,13],y=[-6.37,11.63])
          translate([x-15.2,y+6,-1]) cylinder(d=3,h=30,$fn=20);
      
    for(x=[-dist+54,54])
      translate([x+6,-33+8,-1]) {
        cylinder(d=8,h=30,$fn=40);
      }
    }
  }
}
    *if(part=="rail")
    {
      translate([60,18,rail_thickness+1]) rotate([0,0,180]) {
        *wheel();
        %belt_drive(72,14,202);
      }
    }
}
module belt_drive(teeth1, teeth2, belt_teeth)
{
  od1=tooth_spacing(2,0.254,teeth=teeth1);
  od2=tooth_spacing(2,0.254,teeth=teeth2);
  teeth_left=belt_teeth-((teeth1/2)+(teeth2/2));
  dist=teeth_left/4;
  r=(od1/2)-(od2/2);
  distx=sqrt(pow(dist,2)+pow(r,2));
  bang=atan(distx/((od1-od2+2)/2));
  echo(str("Tangent distance: ",dist," Teeth left: ",teeth_left," Dist X: ",distx," Belt Angle: ",bang));
  mirrory() rotate([0,0,bang-90]) translate([0,od1/2]) cube([dist,1,6]);
  translate([0,0,0]) pulley("GT2 2mm", od1, 0.764 , 1.494, 12, idler = 1, retainer = 0, motor_shaft = 3.2, teeth=teeth1, draw_base = 0 );
  translate([distx,0,0]) pulley("GT2 2mm", od2, 0.764 , 1.494, 12, idler = 1, motor_shaft = 3.2, teeth=teeth2, draw_base = 0 );
}
module wheel(front=1,right=1) {
  *#translate(right?(front?[-141,27.7,139.27]:[-12,27.7,139.27]):(front?[141,27.7,-3.43+24]:[12,27.7,-2.18+22.7]))
    import(str("Tank_that_Prints_without_Support/files/tank_",right?"right":"left","_",front?"front":"back","_wheel.stl"));
  
  difference() {
    union(){
      color("red") wheel_edge();
      wheel_spacer();
      translate([0,0,6]) color("green") wheel_pulley();
      translate([0,0,14]) color("blue") wheel_spikes();
      translate([0,0,34]) mirror([0,0,1]) color("green") wheel_idler();
      translate([0,0,40]) mirror([0,0,1]) color("red") wheel_edge();
      /*
      if(front)
        cylinder(d=25,h=48,$fn=60);
      else
        *translate([0,0,38]) {
          cylinder(d=10,h=2.5,$fn=10);
          cylinder(d=8,h=7.5,$fn=30);
        }
      //*/
    }
    *union(){
      *if(front)
        translate([0,0,30]) {
          gt2_teeth(48.8);
        }
      translate([0,0,-.01]) {
        #cylinder(d=22.4,h=8,$fn=80);
        #translate([0,0,7.99]) cylinder(d1=20,d2=front?10:6,h=26,$fn=80);
        if(!front)
        {
          translate([0,0,7.99]) cylinder(d=20,h=40,$fn=80);
          cylinder(d=10,h=46,$fn=30);
          translate([0,0,30.02]) cylinder(d=22.4,h=8,$fn=80);
        }
      }
      if(front)
        translate([0,0,41.01]) rotate([0,0,45]) cube([14,14,50],center=true);
    }
   *if(!front) {
      translate([0,0,-.01]) {
        cylinder(d=8,h=10,$fn=80);
        translate([0,0,9.99]) cylinder(d=6,h=80,$fn=4);
      }
    }
    for(r=[0:90:359])
      rotate([0,0,r]) translate([18,0,-.01]) cylinder(d=3,h=60,$fn=20);
    if(stamp!="")
    {
      translate([0,-20,37.2]) rotate([0,0,90]) linear_extrude(2,convexity=10) text(front?"f":"r",halign="left",valign="center");
      translate([0,21,37.2]) rotate([0,0,90]) linear_extrude(2,convexity=10) text(stamp,size=8,valign="center",halign="right");
    }
  }
}
module gt2_teeth(dia,h=6,depth=1,inverse=1)
{
  ang=360/((dia-depth)/2*PI);
  teeth=((dia-depth)/2*PI);
  echo(str("GT2 Teeth: ", teeth, "(", ang,"): ", teeth/PI*2));

  union(){
    for(r=[0:ang:360-ang]) rotate([0,0,r])
      translate([dia/2-depth,-.6]) linear_extrude(h) polygon([[0,0],[0,1],[depth+.01,1],[depth+.01,0]]);
    *difference(){
      cylinder(d=50,h=4,$fn=100);
      translate([0,0,-.01]) cylinder(d=47,h=3.02,$fn=100);
      translate([0,0,2.99]) cylinder(d1=47,d2=50,h=1.02,$fn=100);
    }
  }
}
module tread_full() {
  for(y=[0:rows-1],x=[0:cols-1]) translate([x*(tread_width+2),y*(tread_height)]) tread2(mh=tread_height,mw=tread_width);
}
module tread_circle()
{
  //off=67.3;
  off=PI*1.21*tread_height;
  for(n=[0:23])
    rotate([0,0,n*(360/24)]) translate([-off,tread_height/-2])
      rotate([0,90,0]) tread2(mh=tread_height,mw=tread_width);
}
module tread2(rd=7,mh=tread_height,mw=tread_width)
{
  segh = 11; //mh*2/3-1;
  segh2 = mh*2/3-1;
  flap=tread_flap;
  rotate([0,90]) translate([0,0,mw*-.5])
  {
    difference() { union() {
      cylong(d=rd,l=segh2+1,h=mw/3+1);
      translate([0,mh-segh2-4,mw/3+1]) cylong(d=rd,l=segh2+4,h=mw/3-2);
      translate([0,0,mw*2/3-1]) cylong(d=rd,l=segh2+1,h=mw/3);
      if(flap)
      {
        if(spike_type==5) {
          translate([-6,6,mw-12]) cube([4,2,10]);
          translate([-6,6,1]) cube([4,2,10]);
          translate([-6,15,mw/2-3]) cube([4,2,6]);
        } else {
          translate([-6,mh/2-1,1]) cube([4,2,mw-3]);
        }
      }
    }
      if(stamp!=""&&!flap)
        translate([-3,5,5]) rotate([0,-90]) linear_extrude(1) text(stamp,size=6,halign="center");
      for(y=[0,mh]) translate([0,y,-.01]) cylinder(d=3,h=mw+.02,$fn=20);
        translate([rd/-2-.01,mh*1/2+tread_hole_offset,mw/2]){
          //rotate([0,90]) scale([1,0.5,1]) cylinder(d1=14,d2=0,h=rd,$fn=4);
          translate([flap?7.1:0,0]) rotate(flap?[0,0,180]:[]) rotate([0,0,-90]) scale(1.2) spike(10);
        }
        if(flap)
        {
          translate([-4,-4,-.01]) cube([8,8,8]);
          translate([-4,-4,mw-8]) cube(8);
          translate([-4,-4,mw/2-(mw/3-2)/2]) cube([8,8,(mw/3-2)]);
        } else {
        translate([0,0,-.01]) cylcube(d=6,h=8,$fn=40);
        translate([0,0,mw-7.99]) cylcube(d=6,h=8,$fn=40);
        translate([0,0,mw/2-(mw/3-2)/2]) cylinder(d=9,h=(mw/3-2),$fn=40);
        }
        mirrorz(mw/2)
        translate([0,mh,-.01]) cylinder(d=9,h=segh+2.32,$fn=40);
      }
  }
}
module cylcube(d,h,t=1,l=1,$fn=30)
{
  union(){
  cylinder(d=d,h=h,$fn=$fn);
    if(t)
      translate([0,d/-2,0]) mirror([1,0]) cube([d,d,h]);
    if(l)
      translate([d/-2,0]) mirror([0,1]) cube([d,d,h]);
  }
}
module cylong(d,l,h)
{
  cylinder(d=d,h=h,$fn=30);
  translate([0,l]) cylinder(d=d,h=h,$fn=30);
  translate([d*-.5,0]) cube([d,l,h]);
}
module tread(rd=7,mh=16,mw=35)
{
  rr=rd/2;
  render() difference() {
    minkowski()
    {
    linear_extrude(0.01) 
      polygon([[rr,rr],[rr,mh-8],[mw/2-3,mh-8],
        [mw/2-3,mh-1],[mw/2+3,mh-1],[mw/2+3,mh-8],
        [mw-rr,mh-8],[mw-rr,rr],[mw/2+3.6,rr],
        [mw/2+3.6,7+rr],[mw/2-3.6,7+rr],[mw/2-3.6,rr]
      ]);
      rotate([0,90]) translate([0,0,-rr]) cylinder(d=rd,h=0.01,$fn=30);
    }
    for(y=[rr,mh-.5])
    translate([-1,y]) rotate([0,90]) {
      cylinder(d=3,h=40,$fn=20);
      translate([0,0,.99]) cylinder(d=10,h=8,$fn=30);
      translate([0,0,28.5]) cylinder(d=10,h=8.02,$fn=40);
    }
    translate([17.75,13,-2.01]) {
      scale([1,0.5,1]) rotate([0,0,0]) cylinder(d1=6,d2=12,h=6,$fn=4);
        *linear_extrude(8.02) polygon([[0,3],[5,6],[10,3],[5,0]]);
    }
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
module tank_stl()
{
  tdist=120;
  *translate([-141,27.7,31.44]) import("Tank_that_Prints_without_Support/files/tank_adapter.stl");
  color("gray") translate([50,0,62]) rotate([0,-90,0]) translate([-106.44,-59.57,-26.48]) import("Tank_that_Prints_without_Support/files/tank_cannon.stl");
  *translate([-43.07,-141,-41.98+22.3]) import("Tank_that_Prints_without_Support/files/tank_motorholder.stl");
  translate([0,0,-17]) rotate([0,0,90]) translate([59.54,65.52,-35.79+6.5]) import("Tank_that_Prints_without_Support/files/tank_batteryholder.stl");
  translate([-22,0,30]) rotate([0,0,90]) 
  translate([-59.57,-98.7,-76]) mirror([0,0,1]) mirror([1,0]) import("Tank_that_Prints_without_Support/files/tank_cover.stl");
  translate([-11,0,29]) rotate([180,0]) rotate([0,0,-90]) {
    translate([-59.35,88.17,76]) import("Tank_that_Prints_without_Support/files/tank_frame.stl");
  }
 for(front=[0,1],right=[0,1])
 {
   //translate([0,0]) rotate([0,0,180])
   translate([!front?-64:65,(right?-1:1)*(tdist/2+20),-18]) rotate([!right?90:-90,0]) color(front?(right?"green":"blue"):(right?"red":"purple"))
   translate(right?(front?[-141,27.7,139.27]:[-12,27.7,139.27]):(front?[141,27.7,-3.43+24]:[12,27.7,-2.18+22.7]))
    import(str("Tank_that_Prints_without_Support/files/tank_",right?"right":"left","_",front?"front":"back","_wheel.stl"));
 }
  rotate([-90,0]) translate([3.5,0,-22]) for(inner=[0,1],left=[0,1])
  {
    translate([left?-15:0,0,left?tdist-16:tdist/-2])
    rotate([0,left?180:0])
    translate([(left?0.5:-0.5)*(inner?0:1.5)+(left?-17:0),0,inner?44:0]) mirror([0,0,inner?1:0]) mirror([inner?1:0,0])
    translate(inner?(left?[-80.8,45.33,21.54]:[80.8,45.33,-108.37+11]):(left?[80.06,45.57,22.6]:[-80.06,45.57,141.38]))
      import(str("Tank_that_Prints_without_Support/files/tank_",(left?"left":"right"),"_",(inner?"inner":"outer"),"_rail.stl"));
  }
}

module battery(type="18650",neg=1,top=0)
{
  noff=neg?4:0;
  if(type=="18650") {
    cylinder(d=18+(neg?0.5:0),h=65+noff,$fn=40);
    translate([-9-(neg?0.25:0),-11]) cube([18+(neg?0.5:0),11,65+noff]);
    if(neg)
    {
      for(m=[0,1]) translate([0,0,m?65+noff:0]) mirror([0,0,m]) {
        translate([-5,-10.02,-1.7]) cube([10,17,1]);
        if(top)
          translate([-5.5,-6,-1.7]) cube([11.02,4,1]);
        translate([0,0,-.71]) {
          cylinder(d=8,h=2.02,$fn=30);
          translate([-4,-10.01]) cube([8,10,2.02]);
          translate([-5,-14.01]) cube([10,14,2.02]);
        }
        *translate([-2,1,-1.7]) cube([4,10,1]);
        *translate([-1,-5,-1.2]) cube([2,10,2]);
        *translate([-3,9.01,-3.01]) cube([6,1,2.3]);
      }
    } else
    translate([0,0,64.99+noff]) cylinder(d=6,h=1.4,$fn=20);
  }
}