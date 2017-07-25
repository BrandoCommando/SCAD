part="head"; // [all:Preview Bot,head:Head,body:Body,leg:Leg,foot_left:Left Foot,foot_right:Right Foot]
body_width=67; // Stock=67
body_depth=68; // Stock=68
body_height=38; // Stock=38
shell_thickness=2;
part_clearance=0.1;
brain_type="uno_shield"; // [nano_shield:Stock (Arduino Nano + Servo Shield),uno_shield:Arduino Uno + Servo Shield]

warnings()
  draw_part();

module draw_part() {
  if(part=="head")
    head();
  else if(part=="body")
    body();
  else if(part=="leg")
    leg();
  else if(part=="foot_left")
    foot();
  else if(part=="foot_right")
    mirrorx() foot();
  else if(part=="all")
    otto();
}
module otto() {
  head(move=1);
  body(move=1);
  mirrory() {
    foot(move=1);
    leg(move=1);
  }
}
module warnings() {
  if(brain_type=="uno_shield"||brain_type=="uno")
  {
    if(body_width<90)
      error("If Arduino Uno is used, body width MUST be greater than 90!");
    else children();
  } else children();
}
module error(s) {
  echo(str("***ERROR*** ",s));
  rotate([0,0,45])
        rotate([80,0,0]) color("red") text(s);
}
module leg(move=0) {
  translate(move?[0,24,-40]:[]) rotate([0,0,0])
  //#import("Otto_DIY/files/OTTO_leg_v4.stl");
  difference() {
    translate([-14.5,-8.25,0]) {
      intersection() {
        cube([29,16.5,38.5]);
        union(){
          box_chamfer([29,16.5,20],2);
          translate([0,0,38.6]) mirror([0,0,1]) box_chamfer([29,16.5,20],1.25,chvx=2,chvy=2);
          *translate([1,1,30])
            box_chamfer2([29-2,16.5-2,7],2);
        }
      }
    }
    translate([-12.5,-6.25,4.25]) cube([25,12.5,50]);
    translate([12,-3,5]) cube([6,6,7.5]);
    translate([0.5,0,2.6]) rotate([0,0,90]) {
      linear_extrude(3.4) 
        polygon([[-3.1,0],[-2,20],[2,20],[2.8,0]]); 
      translate([0,0,-3.01]) cylinder(d=7.4,h=5,$fn=30);

    }
    translate([-14.5-.01,0,28.5]) rotate([0,90,0]) {  cylinder(d=4,h=5,$fn=30);
      rotate([0,0,90]) translate([0,0,5]) {
        cylinder(d=12,h=30,$fn=30);
        translate([0,-5.5]) cylinder(d=6.5,h=30,$fn=20);
        translate([-6,0]) cube([12,30,30]);
      }
    }
    mirrory() translate([-11.525,-8.3,4.9]) mirror([0,1,0]) rotate([90,0]) linear_extrude(5) {
      //square([21.565,12.93]);
      polygon([[0,0],[0,5.7],[6.1,12.93],[21.565-5.7,12.93],[21.565,5.7],[21.565,0]]);
    }
    translate([-15,0,9]) rotate([0,90,0]) cylinder(d=2.5,h=5,$fn=20);
  }
  bo=1.6;
  difference() {
    translate([8.55-bo,-3.8,4]) cube([4+bo,7.6,7.5]);
    translate([10-bo,-3,5]) cube([4+bo,6,8]);
    translate([8.5-bo,0,9]) rotate([0,90,0]) cylinder(d=2.2,h=2,$fn=20);
  }
}
module foot(move=0) {
  translate(move?[0,34.5,-48]:[])
  //*translate([0,44,0]) import("Otto_DIY/files/OTTO_footL_v4.stl");
  difference(){
    union(){
      translate([-31,-20,0]) {
        intersection() {
          cube([62,40,5]);
          translate([0,0,-3]) box_chamfer3([62,40,8.01],2);
          *translate([2.8,2.8,0]) box_chamfer2([56.3,34.4,2.5],4);
        }
      }
      translate([15.8,-9.5,15.75]) sphere(d=4,$fn=30);
      for(m=[0,1]) mirror([m,0])
      translate([-21.15,-20,0]) difference() {
        intersection(){
          cube([4+(m?1.1:1.5),21,24.5+(m?0:2)]);
          box_chamfer3([41.8,21,25+(m?0:2)],2);
          *translate([2.8,2.8,0]) box_chamfer2([36.2,15.4,22.5],4);
        }
        translate([5.5,-.01,-.01]) cube([31.3,21.02,25.02]);
        if(m==0)
        translate([-.01,10.5,15.5]) rotate([0,90]) {
            cylinder(d=7.3,h=6,$fn=30);
            translate([-8,0]) cylinder(d=1,h=6,$fn=10);
            rotate([0,0,90]) linear_extrude(2) {
            polygon([[-3.5,0],[-2,10+(m?0:2)],[2,10+(m?0:2)],[3.5,0]]);
          }
        }
      }
    }
    translate([-15.7,-21.01,1]) {
      translate([0,-1,0]) box_chamfer3([31.8,26.02,10],2);
      *intersection(){
        cube([31.8,25.02,10]);
        translate([2,0,2.8]) box_chamfer2([27.3,22,8],4);
      }
    }
  }
}
module body(dims=[body_depth,body_width,body_height]) {
  left=dims[0]/-2; // -33.5
  botm=dims[1]/-2; // -33.5
  right=dims[0]/2; // 33.5
  //#import("Otto_DIY/files/OTTO_body_v3.stl");
  difference() {
      translate([left,botm,0]) box_chamfer(dims,ch=2,chvx=5,chvy=5);
    translate([left+1.75,botm+1.75,2]) box_chamfer([dims[0]-3.5,dims[1]-3.5,dims[2]],ch=1,chvx=4,chvy=4,inside=1);
      translate([0,0,-.01]) linear_extrude(2.5) {
        mirrory() {
          translate([.1,-25]) circle(d=12,$fn=30);
          translate([6,-25]) circle(d=6.5,$fn=20);
          offset(-1) offset(1)
          translate([-14.5,-15]) square([29,4]);
        }
        translate([-24,20]) square([5.2,5.2]);
        translate([-20.3,-25.15]) {
          circle(d=2,$fn=20);
          for(r=[2:360/7:359]) rotate([0,0,r]) translate([4.1,0]) circle(d=2,$fn=20);
        }
      }
  }
}
module head(dims=[63,64.5,32],move=0) {
  left=dims[0]/-2; // -31.5
  botm=dims[1]/-2; // -32.25
  right=dims[0]/2; // 31.5
  translate(move?[0,0,66]:[]) rotate(move?[180,0,-90]:[]) {
    //#import("Otto_DIY/files/OTTO_head_v3.stl");
    difference(){
      translate([left,botm,0]) box_chamfer(dims,ch=2,chy1=3.5,chvx=5.5,chvy=4);
      translate([left+2,botm+3.501,2]) box_chamfer([dims[0]-4,dims[1]-5.5,dims[2]],ch=1,chvx=2.75,chvy=2.75,inside=1);
      translate([left,botm-.01,dims[2]-3.8]) cube([dims[0],1.5,10]);
      for(x=[-13.25,13.25])
        translate([x,-32.26,15]) rotate([-90,0]) cylinder(d=16.5,h=4,$fn=50);
      translate([left*-1+.01,18.163,12.875]) rotate([0,-90]) cylinder(d=8,h=4,$fn=24);
      translate([right-2.76,12.5,4.815]) cube([2.06,10.5,14.2]);
      translate([right-2.76,-2.4,19.5]) rotate([0,90]) rotate([0,0,90]) usb_mini();
      translate([-5.6,-29.555,3.75]) {
        translate([11.25,0]) rotate([-90,0]) rotate([0,0,180]) intersection() {
          box_chamfer([11.3,7.6,2],ch=0,chvx=1.6,chvy=1.6);
          translate([0,0,-.8]) box_chamfer([11.3,7.6,4],ch=1.6,chvx=0,chvy=0);
          
        }
      }
    }
    mirrorx() translate([-left-2,-9.25,32]) rotate([-90,0]) mirror([0,1,0]) linear_extrude(21) polygon([[0,0],[0,8.4],[1.98,8.4],[4.1,6.3],[4.1,4.2],[2,2.5],[2,0],]);
    mirrory(0.75) mirrorx(0) translate([left+4.5,botm+1.5,32]) rotate([90,0]) mirror([0,0,1]) linear_extrude(2) polygon([[0,0],[0,6],[2,8],[12,8],[14,6],[14,1.5],[15.5,0]]);
  }
  translate([-25.4,-30,2]) cube([2,4.9,3.9]);
  translate([-29.6,-8,2]) cube([1.5,2,3]);
  translate([-29.6,20,2]) cube([1.5,1.98,3]);
  translate([-25.375,29.075,2]) cube([2,1.5,3.9]);
  translate([23.626,29.075,2]) cube([2,1.5,3.9]);
  translate([27,25,2]) cube([4,2,3]);
  translate([22.877,-30,2]) {
    cube([2,4.875,3.9]);
    cube([2,6,3]);
  }
  translate([0,0,2]) for(pos=[[-27,-7],[-27,20.9],[25.2,26.1],[23.825,-22.25]])
    translate(pos) difference() {
      union(){
        cylinder(d=4.3,h=3,$fn=30);
        cylinder(d1=6,d2=4.3,h=1,$fn=30);
      }
      translate([0,0,-.01]) cylinder(d=2,h=4.02,$fn=20);
    }
}
module usb_mini() {
  linear_extrude(3,convexity=10) {
    translate([0.6,0]) union() {
      translate([0,0.1]) square([8-1.202,4]);
      for(x=[0.1,6.7]) translate([x,0.1]) circle(r=0.1,$fn=20);
      translate([0.1,0]) square([6.6,4]);
    }
    mirrorx(3.999) translate([0.4,1.81]) difference() {
      square([0.2,0.2]);
      circle(r=0.2,$fn=20);
    }
    translate([0,2.008]) union() {
      translate([0.1,0.2]) square([7.8,1.9]);
      translate([0.2,0]) square([7.6,2.1]);
      translate([0,0.1]) square([8,1.9]);
      for(x=[0.2,7.8])
        translate([x,0.2]) circle(r=0.2,$fn=20);
      for(x=[0.1,7.9])
        translate([x,2]) circle(r=0.1,$fn=20);
    }
  }
}

module box_chamfer3(dims,ch=1,bot=1)
{
  render() intersection() {
    cube(dims);
    minkowski()
    {
      translate([ch,ch,ch]) cube([dims[0]-ch*2,dims[1]-ch*2,dims[2]-ch*2]);
      *sphere(r=ch/sin(60),$fn=10);
      for(m=[0,1]) mirror([0,0,m]) 
        cylinder(r1=ch,r2=m?(bot?0:ch):0,h=ch,$fn=4);
    }
  }
}
module box_chamfer2(dims,ch=1)
{
  render() minkowski()
  {
    cube(dims);
    intersection()
    {
      rotate([45,0,45]) cube(ch,center=true);
      rotate([45,0,-45]) cube(ch,center=true);
    }
  }
}
module box_chamfer(dims,ch=1,chx1="auto",chx2="auto",chy1="auto",chy2="auto",chvx="auto",chvy="auto",inside=0) {
  x1=chx1=="auto"?ch:chx1;
  x2=chx2=="auto"?ch:chx2;
  y1=chy1=="auto"?ch:chy1;
  y2=chy2=="auto"?ch:chy2;
  vx=chvx=="auto"?ch:chvx;
  vy=chvy=="auto"?ch:chvy;
  difference(){
    cube(dims);
    if(x1)
    {
      translate([x1,-.01]) rotate([0,-45]) mirror([1,0]) cube([x1*2,dims[1]+.02,x1*2]);
      *if(vx)
      translate([9.9,0]) rotate([0,0,45]) translate([-5+x1,0]) translate([x1,-.01]) rotate([0,-45]) mirror([1,0])  cube([x1*2,dims[1]+.02,x1*2]);
    }
    if(x2)
      translate([dims[0]-x2,-.01]) rotate([0,45]) cube([x2*2,dims[1]+.02,x2*2]);
    if(y1)
      translate([-.01,y1]) rotate([45,0]) mirror([0,1,0]) cube([dims[0]+.02,y1*2,y1*2]);
    if(y2)
      translate([-.01,dims[1]-y2]) rotate([-45,0]) cube([dims[0]+.02,y2*2,y2*2]);
    if(vx)
    {
      mirrorx(dims[0]/2) {
        translate([vx,0,-.01]) rotate([0,0,45]) mirror([1,0]) cube([vx*2,vx*2,dims[2]+.02]);
        translate([inside?-1.4:-1.5,inside?0:-1.1]) rotate([0,0,45])
        mirror([1,0,0]) rotate([0,45,0])
        translate([-vx,-vx]) translate([0,0,vx/-.75]) cube([10,vx*2,vx*2]);
      }
    }
    if(vy)
      mirrorx(dims[0]/2) {
        translate([0,dims[1]-vy,-.01]) rotate([0,0,-45]) mirror([1,0]) cube([vy*2,vy*2,dims[2]+.02]);
        translate([0,dims[1]+(inside?-0.25:0.5),-.01])
          rotate([0,0,-45]) mirror([1,0,0])
          rotate([0,-45,0])
          translate([-vx,-vx]) translate([0,0,vx/-.75]) 
          cube([10,vx*2,vx*2]);
      }
  }
}
module mirrory(offset=0)
{
  translate([0,offset,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-1,0]) children();
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}
module otto_stl() {
  translate([0,0,66]) rotate([180,0,-90]) import("Otto_DIY/files/OTTO_head_v3.stl");
  import("Otto_DIY/files/OTTO_body_v3.stl");
  translate([0,-34.5,-48]) import("Otto_DIY/files/OTTO_footR_v4.stl");
  translate([0,34.5,-48]) import("Otto_DIY/files/OTTO_footL_v4.stl");
  for(y=[-25,25])
    translate([0,y,-40]) rotate([0,0,0]) import("Otto_DIY/files/OTTO_leg_v4.stl");
}