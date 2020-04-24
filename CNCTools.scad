// preview[view:south west, tilt:diagonal]
/* [General] */

part="grip"; // [cfoot:Clamp Foot,cfoot_base:Clamp Foot Base,cfoot_boost:Clamp Foot Base Booster,clamp_tray:Clamp Tray,rod_tray:Rod Dray,dual_tray:Dual Tray,hclamp:Flat(H) Clamp,vclamp:V-Clamp,tvclamp:Tall V-Clamp,vclamp_rod:V-Clamp Rod,nuthelper:Nut Helper,presser:Presser,grip:Grip,bplug:Bolt Plug,preview:Preview All]

/* [Clamp Foot] */

// Clamp Foot Step Size
cfss=3;
// Clamp Foot Width
cfw=20;
// Clamp Foot Thickness
cft=12;
// Clamp Foot Length
cfl=100;
// Clamp Foot Hole Offset
cfho=10;
// Clamp Foot Base Step Count
cfbsteps=8;
// Clamp Foot Boost Height
cfboh=30;

/* [Flat Clamp] */

// Flat Clamp Width (X)
hcw=150; // [40:120]
// Flat Clamp Height (Y)
hch=20; // [10:40]
// Flat Clamp Depth (Z)
hcd=5; // [4:0.1:20]
// Flat Clamp Extra Notch
hnotch=3; // [1:Yes,0:No,2:Round,3:Flat]
// Flat Clamp Nut Holder
hnut=0; // [1:Yes,0:No]
// Flat Clamp bar notch width
hbnotch=39;

/* [V-Clamp] */

// V-Clamp Width (X)
vcw=76; // [40:120]
// V-Clamp Height (Y)
vch=20; // [10:40]
// V-Clamp Depth
vcd=16; // [10:0.1:40]
// V-Clamp Rod diameter
vcrd=12; // [10:20]

/* [Bolt/Nut Info] */

// Bolt/Nut Diameter
boltd=inches(5/16); // [3:M3,4:M4,5:M5,6:M6,7:M7,8:M8,3.175:1/8",4.7625:3/16",6.35:1/4",7.9375:5/16",9.525:3/8",11.1125:7/16",12.7:1/2"]
// Bolt Clearance
holec=.1; // [0:.1:1]
// Nut Height
nuth=12; // [2:0.2:10]
// Nut Clearance
nutc=.1; // [0:.1:1]
// Bolt Plug Height
bplugh=14;
// Nut Diameter Override
nutdo=0;
echo(str("Nut D: ", nutd(boltd), "(", mm2in(nutd(boltd)), ") for ", boltd));

/* [Grip Info] */

// Grip Big Diameter
gripd=31; // [20:60]
// Grip Knob Count
gripknobs=6;
// Grip Knob Diameter
gripknobdia=8;
// Grip Knob Distance
gripknobdist=18;
// Grip Extra Neck Height
gripneck=0;
// Grip Height;
griph=10;//nuth+(gripneck?ns:0);
// Grip Cutout Distance
gripcd=17;
// Grip nut Z
gripnz=1.2;
// Grip Cutout X-Factor
gripxf=gripd/gripknobs-1;
// Grip Cutout Polygon
grippoly=[[[0,0],[gripxf+2,0],[gripxf,2],[gripxf,nuth-3.98],
  [gripxf+2,nuth-2],[gripxf+3,nuth+8.02],[0,nuth+4.02]],[]]; // [draw_polygon:20x20]

/* [Others] */

// Clamp Tray Count
ctray_count=12; // [1:20]

if(part=="clamp_tray")
    clamp_tray();
else if(part=="dual_tray")
{
  clamp_tray();
  translate([ctray_count*9,0])
    m4_tray(left=0);
} else if(part=="rod_tray") {
  m4_tray();
} else if(part=="vclamp_rod") {
  vclamp_rod();
} else if(part=="hclamp")
{
  translate([0,0,hcd]) mirror([0,0,1]) hclamp();
} else if(part=="cfoot") {
  cfoot();
} else if(part=="cfoot_base") {
  cfoot_base();
} else if(part=="cfoot_boost") {
  cfoot_boost();
} else if(part=="bplug")
{
  mirror([0,0,1]) translate([hcw-8,hch/2,1]) rotate([0,0,30]) {
    cylinder(d=nutd(boltd)-nutc*2,h=nuth+bplugh,$fn=6);
    *translate([0,0,nuth]) cylinder(d1=nutd(boltd)-nutc,d2=boltd,h=boltd,$fn=6);
    translate([0,0,-2]) cylinder(d=boltd-holec,h=bplugh+nuth+2,$fn=30);
  }
  %translate([0,0,hcd]) mirror([0,0,1]) hclamp();
} else if(part=="vclamp")
{
  translate([0,0,vch]) rotate([-90,0])
  vclamp();
} else if(part=="tvclamp") {
   rotate([90,0]) tvclamp();
} else if(part=="nuthelper") {
  nuthelper();
} else if(part=="presser") {
  mirror([0,0,1]) presser();
} else if(part=="grip")
{
  grip(gripd);
} else if(part=="preview")
{
  color("lightblue") clamp_tray();
  color("lightgreen") translate([ctray_count*9,0]) m4_tray(left=0);
  color("yellow") for(x=[0:(ctray_count-1)/2-2]) {
    translate([8.5+x*9,2.5,hcw+2]) rotate([0,-90,0]) mirror([1,0]) hclamp();
  }
  color("red") for(x=[0:2]) {
    translate([((ctray_count-1)/2-2)*9+20+x*18,2.5,2.5]) rotate([0,-78]) vclamp();
  }
  for(x=[0:1:4],y=[0:1]) {
    if(x%2!=y%2)
    translate([ctray_count*9+6+x*10,6+y*12])
    {
      color("silver") cylinder(d=4,h=50,$fn=20);
      translate([0,0,25+x*5+y*10-(x==4?5:0)])
      {
        color("gray") mirror([0,0,1]) rotate([0,0,30]) grip();
        if(x>2)
          color("pink") translate([(vcrd-1)*-.5,vch*-.5,-15]) mirror([0,0,1]) vclamp_rod();
      }
    }
  }
}
module cfoot(rotate=1) {
  rotate([rotate?90:0,0]) difference() {
    translate([-cfl,0]) rounded_cube([cfl,cfw,cft]);
    translate([-cfl-.01,-.01,2]) rotate([0,-30,0]) cube([30,cfw+.02,cft]);
    translate([-cfl/2+cfho,cfw/2,-.01]) cylinder(d=boltd,h=cfw+.02,$fn=30);
    translate([cfss*-3,-.01]) for(step=[0:cfbsteps]) translate([step*cfss,0,(cfss-.01)*step-.01]) cube([10,cfw+.02,cfss]);
  }
}
module cfoot_base() {
  %cfoot(0);
  %cfoot_boost(0);
  cube([cfbsteps*cfss+5,cfw,cfss]);
  translate([cfbsteps*cfss,0,cfss]) intersection() {
    cube([5,cfw,10]);
    translate([8,0]) mirror([1,0]) rotate([0,45,0]) cube([10,cfw,20]);
  }
  for(step=[1:cfbsteps])
    translate([step*cfss,0,(cfss-.01)*step]) cube([(cfbsteps*cfss)-(step*cfss),cfw,cfss]);
}
module cfoot_boost(rotate=1) {
  translate([cfbsteps*cfss+5,-3.5]) rotate([0,0,90]) rotate([rotate?0:-90,0]) linear_extrude(cfbsteps*cfss+5)  boost_profile();

}
module boost_profile() {
  difference() {
      square([cfw+7,cfboh]);
      translate([5,6]) rounded_square([cfw-3,cfboh-10]);
      translate([10,cfboh-5]) square([cfw-13,5]);
  }
  translate([0,-2]) square([3,2]);
  translate([1.5,-2]) circle(d=3,$fn=30);
  translate([cfw+4,-2]) square([3,2]);
  translate([cfw+5.5,-2]) circle(d=3,$fn=30);
  mirrorx(-(cfw+7)) translate([-5,cfboh-8]) polygon([[0,6],[5,0],[5,8],[0,8]]);
}
module mirrorx(dist=0)
{
  translate([dist/-2, 0]) for(m=[0,1]) mirror([m,0]) translate([dist/2, 0]) children();
}
module rounded_square(dims,r=2)
{
  translate([0,r]) square([dims[0],dims[1]-r*2]);
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([r,r]) circle(r=r,$fn=20);
  translate([dims[0]-r,r]) circle(r=r,$fn=20);
  translate([r,dims[1]-r]) circle(r=r,$fn=20);
  translate([dims[0]-r,dims[1]-r]) circle(r=r,$fn=20);
}
module clamp_tray() {
  difference() {
    box([2+ctray_count*9,25,20],bottom=0,r=2);
    for(x=[0:ctray_count-1]) {
      translate([2+x*9,2,2]) cube([7,21,20]);
    }
  }
}  
module m4_tray(left=1) {
  difference(){
    union(){
      translate([0,0]) box([52,25,18],left=left,bottom=0,r=2);
      *translate([115,0,4]) {
        for(x=[0:6],y=[0:1]){
          translate([x*10,6+y*12]) cylinder(d=7,h=16,$fn=20);
        }
      }
    }
    translate([6,0,4]) {
      for(x=[0:4],y=[0:1]){
        translate([x*10,6+y*12]) cylinder(d=boltd+holec,h=20,$fn=20);
      }
    }
  }
}
module presser() {
  difference(){
    union() {
      sphere(d=13+boltd,$fn=50);
    }
    translate([0,0,boltd>5?-2:0])
      cylinder(d=boltd+.2,h=20,$fn=20);
    translate([0,0,boltd>5?1:3])
      cylinder(d=nutd(boltd)+nutc,h=30,$fn=6);
    translate([-10,-10,5])
      cube(20);
  }
}
module tvclamp() {
  tvh=48;
  difference(){
    union() {
      box([vcw-20,vcd,4],front=0);
      translate([vcw-24,0]) box([4,vcd,tvh],front=0);
      translate([vcw-24,0,tvh-5]) box([24,vcd,5],front=0);
      translate([vcw-24,0,tvh-24]) intersection() {
        rotate([0,-45]) box([40,2,40],r=1,front=0);
          box([24,2,24],r=1,front=0);
      }
      translate([vcw-60,0,0]) intersection() {
        rotate([0,45]) box([60,2,60],r=1,front=0);
          box([40,2,40],r=1,front=0);
      }
    }
    *translate([vcw-20,-.01,tvh-4])
      rotate([0,90,0]) cube([80,vcd+.02,30]);
    *translate([-.01,-.01,4]) cube([50,vcd+.02,80]);
    translate([vcw-vcd/2,vcd/2,0]) {
      cylinder(d=4,h=tvh+.02,$fn=20);
      translate([0,0,tvh-5]) rotate([0,0,30]) cylinder(d=8.2,h=3,$fn=6);
    }
    for(x=[vcd/2:16:44]) {
      translate([x,vcd/2,-.01]) cylinder(d=4,h=5,$fn=20);
    }
  }
  %translate([vcw-vcd/2,vcd/2,tvh-15]) presser();
}
module box(size,r=1,top=1,bottom=1,left=1,right=1,front=1,back=1)
{
  w=size[0];
  d=size[1];
  h=size[2];
  intersection(){
    cube([w,d,h]);
    minkowski(){
      translate([left?r:0,front?r:0,bottom?r:0]) cube([w-(left?r:0)-(right?r:0),d-(front?r:0)-(back?r:0),h-(top?r:0)-(bottom?r:0)]);
      sphere(r,$fn=30);
    }
  }
}
module rounded_rect(w,h,r) {
  translate([r,r]) circle(d=r*2,$fn=30);
  translate([r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,r]) circle(d=r*2,$fn=30);
  translate([r,0]) square([w-r*2,h]);
  translate([0,r]) square([r,h-r*2]);
  translate([w-r,r]) square([r,h-r*2]);
}
module rounded_cube(dims,rsides=2,rvert=0)
{
  w=dims[0];
  h=dims[1];
  d=dims[2];
  if(rvert==0)
  {
    linear_extrude(d) rounded_rect(w,h,rsides);
  } else {
    translate([rsides,rsides,rvert]) scale([1,1,rvert/rsides]) minkowski() {
      cube([w-rsides*2,h-rsides*2,(d-rvert*2)/(rvert/rsides)]);
      sphere(rsides,$fn=30);
    }
  }
}
module hclamp() {
  difference(){
    union(){
      rounded_cube([hcw,hch,hcd],8);
      if(hnut)
        translate([hcw-8,hch/2,hcd-nuth-.99]) rotate([0,0,30]) cylinder(d1=nutd(boltd)+2,d2=nutd(boltd)+4,h=2,$fn=6);
    }
    *translate([2+boltd,-.01]) mirror([1,0]) rotate([0,65]) cube([10,hch+.02,20]);
    if(hnotch==2)
      translate([1,-.01,-2]) rotate([-90,0]) cylinder(d=10,h=hch+.02,$fn=30);
    else if(hnotch==3)
    {
      translate([10,-1,-4]) mirror([1,0]) rotate([0,-15,0]) cube([20,30,4]);
      if(hcw>100)
        translate([hcw-10,-1,-4]) rotate([0,-15,0]) cube([20,30,4]);
    }
    if(hnotch==1)
      translate([-.01,-.01,hcd-2]) mirror([0,0,1]) cube([boltd*.75,hch,hcd]);
    translate([0,3,-.01]) mirror([0,1,0]) rotate([0,0,10]) cube(20);
    translate([0,hch-3,-.01]) rotate([0,0,10]) cube(20);
    if(hcw>100) {
      for(x=[0,hcw-64]) translate([5+boltd+x, hch/2-boltd/2-holec,-.01]) rounded_cube([40,boltd+holec*2,hcd+.02],boltd/2);
        if(hbnotch>0)
          translate([hcw/2-hbnotch/2,-.01,-0.01]) cube([hbnotch,hch+.02,hcd/2]);
      translate([hcw/2,hch/2,-.01]) cylinder(d=boltd+holec*2,h=8.02,$fn=20);
    } else {
        translate([5+boltd,hch/2-boltd/2-holec,-.01]) rounded_cube([hcw-16-boltd*2,boltd+holec*2,hcd+.02],boltd/2);
      translate([hcw-8,hch/2,-.01]) cylinder(d=boltd+holec*2,h=8.02,$fn=20);
      if(hnut)
        translate([hcw-8,hch/2,hcd-nuth-1]) rotate([0,0,30])
      cylinder(d=boltd*2+nutc,h=nuth,$fn=6);
    }
  }
}
module vclamp() {
  difference(){
    translate([0,vch]) rotate([90,0]) rounded_cube([vcw,vcd,vch],rsides=2,rvert=0);
    
    translate([0,-.01,1]) rotate([0,-18,0]) cube([vcw,vch+.02,vcd]);
    translate([vcw*2/3,0,0]) {
      translate([vcrd/2-.5,-.01,vcd]) rotate([0,35]) cube([vcw,vch+.02,vcd]);
      translate([0,-.01,vcd]) rotate([-90,0]) cylinder(d=vcrd,h=vch+.02,$fn=30);
      translate([0,-.01,vcd-vcrd/2-4]) mirror([0,0,1]) rotate([0,-15,0]) cube([vcw,vch+.02,vcd]);
      translate([0,-.01,vcd-vcrd/2-4]) mirror([0,0,1]) mirror([1,0]) rotate([0,-7,0]) cube([vcw,vch+.02,vcd]);
      for(r=[-35:5:50])
        translate([0,vch/2,vcd-.01]) rotate([0,r]) translate([0,0,vcd*-2]) cylinder(d=boltd+holec*2,h=vch+vcd,$fn=20);
    }
  }
}
module vclamp_rod() {
  difference(){
    intersection(){
      cube([vcrd-1,vch,(vcrd-1)/2]);
      translate([(vcrd-1)/2,0]) rotate([-90,0]) cylinder(d=vcrd-1,h=vch,$fn=30);
    }
    translate([(vcrd-1)/2,vch/2,-.01]) cylinder(d=boltd+holec*2,h=vch,$fn=20);
  }
}
module nuthelper()
{
  difference(){
    cylinder(d=gripd/2,h=nuth+1,$fn=6);
    translate([0,0,-.01]) cylinder(d=boltd*2+nutc,h=nuth,$fn=6);
  }
  translate([gripd/4-5,0,nuth+1]) {
    cylinder(d1=6,d2=3,h=2,$fn=20);
    cylinder(d=3,h=10,$fn=20);
  }
}
module grip(od=gripd)
{
  ns=((boltd*2+nutc)-(boltd+holec*2))/2; // nut slope
  //gripknobdia=(gripd-gripcd)/2-gripknobdist/10;
  echo(str("Grip Dia: ",gripd," Knob Dist: ",gripknobdist," Cutout Dist: ",gripcd," Knob Dia: ",gripknobdia));
  difference(){
    union(){
      cylinder(d=gripd,h=griph,$fn=gripknobs);
      if(gripneck>0) {
        translate([0,0,nuth+ns]) cylinder(d1=18,d2=12,h=3,$fn=30);
        translate([0,0,nuth+2+ns]) cylinder(d=12,h=gripneck,$fn=30);
      }
      linear_extrude(griph,convexity=3)
      for(d=[1:gripknobs])
        hull() {
          circle(d=boltd+8,h=griph,$fn=20);
        rotate([0,0,(360/gripknobs)*d]) translate([gripknobdist,0]) circle(d=gripknobdia,h=griph,$fn=30);
        }
    }
    for(d=[1:gripknobs])
      rotate([0,0,(360/gripknobs)*d]) translate([gripknobdist+1,0,-.01]) cylinder(d=3,h=griph+.02,$fn=20);
    translate([0,0,gripnz-.01]) {
      cylinder(d=nutd(boltd)+nutc,h=nuth,$fn=6);
      translate([0,0,nuth-.01]) cylinder(d1=nutd(boltd)+nutc,d2=boltd+holec*2,h=ns,$fn=6);
    }
    translate([0,0,-.01]) cylinder(d=boltd+holec*2,h=40.02,$fn=20);
    degs=360/gripknobs;
    for(d=[degs/2:degs:360])
      rotate([0,0,d]) translate([gripcd,0,-.01]) {
        rotate_extrude($fn=50) { translate([0,0,0]) polygon(points=grippoly[0],paths=grippoly[1]); }
        *cylinder(d=gripd/3,h=nuth+ns+.02,$fn=30);
      }
  }
}
function inches(in) = 25.4 * in;
function nutd(boltd) = nutdo?nutdo:wrench_us(boltd)/sin(60);
function mm2in(mm) = mm / 25.4;
function wrench_us(boltd) =
  boltd < inches(1/4)-1 ? boltd * 2 : (
  boltd < inches(1/4)+1 ? inches(7/16) : (
  boltd < inches(5/16)+1 ? inches(1/2) : (
  boltd < inches(3/8)+ 1 ? inches(9/16) : boltd * 1.5
)));