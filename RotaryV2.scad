part="preview";
maxh=28;
rod_dist=inches(3);//+19.6;
vplateh=inches(2.5);
vscrewd=4;
finger_thick=5;
belt_mode=2; // [1:Connect motor to closest rod,2:Wrap both rods]
belt_size=300;
preview_tubed=inches(3.56);
preview_tubed=85;
//vpos=0;
maxv=vplateh-maxh-vscrewd;
vpos=0;

belt_left=(belt_size-32-14)/2-(belt_mode==2?rod_dist:0);
slidex=belt_left-(10*((vpos)/(vplateh-maxh-vscrewd)));
rise=vpos-7.65;
run=slidex-1;
ang=atan(run/rise)-(rise<0?-90:90);
echo(str("belt left:",belt_left," atan(",rise,"/",run,")=",ang));

if(part=="preview")
{
  preview();
} else {
  endcap2d(1);
  translate([0,-1]) mirror([0,1,0]) endcap2d(2);
  translate([0,maxh+36]) vplate(2);
  translate([inches(-5.5)-5,maxh+1]) connector_2d(inches(11));
  translate([0,-maxh-2]) mirror([0,1]) vplate();
}

module preview()
{
  connector();
  translate([0,0,inches(6)]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,inches(-6)]) {
    
      if(m==0)
        translate([slidex,0]) translate([rod_dist/2,21.65,6]) {
          nema17();
          belt();
        }
    linear_extrude(6) vplate(2-m);
    translate([0,vpos]) {
      translate([0,0,6]) linear_extrude(3) endcap2d(2);
      translate([0,0,9]) {
        linear_extrude(7) endcap2d();
        mirrorx() translate([rod_dist/2,maxh-14]) bearing608();
        translate([0,0,6]) linear_extrude(3) endcap2d(2);
      }
    }
  }
  translate([0,vpos+preview_tubed/2,20]) cylinder(d=preview_tubed,h=inches(11)-40,$fn=80);
  translate([0,vpos]) {
  mirrorx() translate([rod_dist/2,14,-20]) cylinder(d=8,h=inches(13),$fn=40);
  mirrorx() translate([rod_dist/2,14,-18]) import("2GT-Belt_pulley-for-rotary.stl");
  }
}
module belt() {
  translate([0,0,-9]) mirror([0,0,1]) linear_extrude(6) {
    rotate([0,0,ang]) difference() {
      hull() {
        circle(d=16,$fn=50);
        translate([-belt_left,0]) {
          circle(d=26,$fn=80);
          rotate([0,0,180-ang])translate([rod_dist,0]) circle(d=26,$fn=50);
        }
      }
      hull() {
        circle(d=14,$fn=50);
        translate([-belt_left,0]) {
          circle(d=24,$fn=80);
          rotate([0,0,180-ang]) translate([rod_dist,0]) circle(d=24,$fn=50);
        }
      }
    }
  }
}
module connector() {
  translate([rod_dist/2+20,0,0]) rotate([0,-90]) linear_extrude(finger_thick) connector_2d();
}
module connector_2d(length=inches(11),center=false) {
  difference() {
    union() {
      square([length,34]);
      mirrorx(length) for(y=[0,20])
        translate([-finger_thick,y+2]) square([finger_thick,10]);
    }
    hull() {
      translate([30,8]) circle(r=4,$fn=40);
      translate([length-30,8]) circle(r=4,$fn=40);
      translate([10,20]) square([length-20,20]);
    }
  }
}
module vplate(which=1)
{
  difference() {
    union() {
      if(which==2)
      {
        translate([rod_dist*.5,0]) rsquare([belt_left+26,44]);
      }
      translate([rod_dist/-2-25,0]) square([50+rod_dist,36]);
      translate([rod_dist*-.5-30,0]) square([rod_dist+60,9]);
      translate([rod_dist*-.5-10,0]) rsquare([rod_dist+20,vplateh],r=10);
    }
    mirrorx()
    for(y=[0,20])
     translate([rod_dist/2+15.1,y+2]) square([finger_thick-.2,10-.2]);
    mirrorx() translate([rod_dist/2-18,0]) hull() for(vy=[5,vplateh-10]) translate([0,vy]) circle(d=5,$fn=30);
    mirrorx() translate([rod_dist/2,14]) hull() for(vy=[0,maxv]) translate([0,vy]) circle(d=10,$fn=40);
    translate([(rod_dist-50)/2,0]) if(which==2)
    {
      for(hx=[0,31],hy=[0,31]) translate([hx,hy]) hull() for(x=[belt_left-2,belt_left+13])
        translate([x,6.15]) circle(d=3,$fn=20);
      hull() for(x=[belt_left+13,belt_left+28]) translate([x,21.65]) circle(d=23,$fn=60);
    }
    hull()
      for(y=[vscrewd+2,vplateh-vscrewd*2])
        translate([0,y]) circle(d=vscrewd,$fn=30);
  }
}
module endcap2d(which=1)
{
  difference() {
    hull() {
      *translate([rod_dist*-.5-20,0]) square([rod_dist+40,10]);
      mirrorx() translate([rod_dist/2,maxh-14]) circle(d=28,$fn=60);
    }
    mirrorx() {
      translate([rod_dist/2,maxh-14]) circle(d=which==1?22:10,$fn=60);
      for(y=[5,maxh-5]) translate([rod_dist/2-18,y]) circle(d=5,$fn=30);
      translate([rod_dist/2+15,5]) circle(d=3,$fn=20);
    }
    for(y=[vscrewd+2,maxh-vscrewd]) translate([0,y]) circle(d=which!=1?nut_size(vscrewd):vscrewd,$fn=which!=1?6:vscrewd*6);
  }
  if(which!=1) for(y=[vscrewd+2,maxh-vscrewd]) translate([0,y]) circle(d=vscrewd,$fn=30);
}

module nema17()
{
    color("silver") mirror([0,0,1]) {
      cylinder(d=5,h=20,$fn=30);
      cylinder(d=22,h=2,$fn=40);
    }
    difference() {
      translate([-21.65,-21.65]) cube([42.3,42.3,35]);
      mirrorx() mirrory() translate([15.5,15.5,-.01]) cylinder(d=3.4,h=10,$fn=20);
    }
}
module bearing608() {
  %linear_extrude(7) difference() { circle(d=22,$fn=50); circle(d=8,$fn=40); }
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
module rsquare(dims,r=5,center=false)
{
  translate(center?[dims[0]*-.5,dims[1]*-.5]:[0,0])
  hull() for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=r*4);
}
function nut_size(bolt_d) = (bolt_d==3?6.7:(bolt_d==4?7.8:bolt_d*1.5/cos(30)));

function inches(in) = 25.4 * in;