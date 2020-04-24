teeth=60;
circ=2*teeth;
id=7.9;
od=(2*teeth)/PI;
rint=360/teeth;
littled=2.9;
loff=max(id-.25,(od/2)-4);
echo(str("OD:",od," loff:",loff));
holepos=[0:120:359];
shaftnotch=0;
mountholes=3;
shaftslot=0;

*for(x=[0,od+1]) translate([0,x]) rotate([0,0,-60]) gear2d(0);
*for(x=[0,od+1]) translate([0,-x-od-1]) rotate([0,0,60]) gear2d(1);
translate([0,0,7]) linear_extrude(7) gear2d();
*translate([0,0,3]) gear_mid();
*gear_top2();
translate([0,0,18]) mirror([0,0,1]) gear_top2();
!translate([0,0,10]) rotate([0,0,30]) gear_bottom();
module gear_bottom() {
  difference() {
    union() {
      cylinder(d=od+4,h=2,$fn=80);
      cylinder(d=26,h=9,$fn=80);
      translate([0,0,2]) cylinder(d=16,h=7,$fn=60);
      rotate([0,0,60]) for(r=[0:120:359])
          rotate([0,0,r]) translate([4,-6,2])
          *translate([0,1]) cube([10,10,7]);
      *translate([0,0,4]) cylinder(d=14,h=6,$fn=50);
    }
    rotate([0,0,60]) for(r=[0:120:359])
        rotate([0,0,r]) translate([4,-6,3])
          translate([-.01,6,3]) rotate([0,90,0]) {
            translate([0,0,-2]) cylinder(d=3,h=20,$fn=20);
            translate([-3.01,-3.01,3]) cube([6.02,6.02,3]);
          }

    for(r=[0:120:359])
      rotate([0,0,r]) translate([loff,0,0]) rotate([0,0,-30]) { 
        *cylinder(d=7.2,h=4,$fn=6);
        translate([0,0,1.99]) cylinder(d=10,h=20,$fn=30);
      }
    translate([0,0,-.01]) {
      cylinder(d=id,h=20,$fn=40);
      linear_extrude(20.02,convexity=3) holes();
    }
  }
}
module gear_mid() {
  color("blue") linear_extrude(3) gear2d(shaftslot=0);
  color("red") translate([0,0,3]) linear_extrude(3,convexity=3) gear2d(shaftslot=1);
  color("blue") translate([0,0,6]) linear_extrude(6) gear2d(shaftslot=0);
}
module gear_top2()
{
  difference() {
    union() {
      cylinder(d=od+4,h=3,$fn=80);
      translate([0,0,3]) cylinder(d1=od+4,d2=od+2,h=1,$fn=80);
    }
    *for(r=holepos)
      rotate([0,0,r+30]) translate([loff,0,-.01]) translate([-2.7,-2.7]) {
        cube([5.4,5.4,2.1]);
        difference() {
          cube([5.4,5.4,2.4]);
          mirrorx(5.4) cube([1.4,5.4,2.4]); //cylinder(d=6,h=2.4,$fn=30);
        }
      }

    *translate([0,0,3]) cylinder(d=od+.6,h=2,$fn=80);
    translate([0,0,-.01]) linear_extrude(20,convexity=3) rotate([0,0,30]) holes(extra=0.2);
  }
}
module gear_top()
{
  rotate([0,0,30]) difference() {
    union() {
    cylinder(d1=od+4,d2=od+4,h=1.4,$fn=80);
      translate([0,0,1.4]) cylinder(d1=od+4,d2=od+3,h=1,$fn=80);
    }
    translate([0,0,-.01]) {
      for(r=holepos) rotate([0,0,r]) translate([loff,0]) {
        cylinder(d1=7,d2=3,h=2,$fn=30);
        translate([0,0,1.99]) cylinder(d=3,h=1,$fn=30);
      }
      cylinder(d=id,h=3,$fn=40);
    }
    *cylinder(d=id,h=5.02,$fn=40);
    *for(r=[0:120:359])
      rotate([0,0,r]) translate([loff,0,4]) cylinder(d1=5.2,d2=3,h=1.02,$fn=20);
  }
  *rotate([0,0,-30]) translate([0,6,2]) linear_extrude(1) text(str(teeth),size=8,halign="center");
  translate([0,0,1.9]) linear_extrude(1) gear2d();
}
module gear_top_2d()
{
  rotate([0,0,30]) difference() {
    circle(d=od+4,d2=od+4,h=2,$fn=80);
    holes();
    rotate([0,0,-30]) translate([0,6]) text(str(teeth),size=8,halign="center");
  }
}
module gear2d(shaftslot=0) {
  *difference() { circle(d=od+3,$fn=80); circle(d=od+2,$fn=80); }
  rotate([0,0,30]) difference()
  {
    union() {
      circle(d=od-1.4,$fn=80);
      for(tooth=[0:teeth-1]) rotate([0,0,tooth*rint])
      translate([od/2-.8,-.5]) {
        //hull()
        {
          polygon([[0,0],[1,0.2],[1,0.8],[0,1]]);
          //translate([0,0]) square([1,1]);
        }
      }
    }
    holes(shaftslot);
    *rotate([0,0,-30]) translate([0,5]) text(str(teeth),size=8,halign="center");
  }
}
module holes(shaftslot=shaftslot,extra=0) {
    if(mountholes)
    for(r=holepos)
      rotate([0,0,r]) translate([loff,0]) circle(d=littled,$fn=20);
    difference() {
      circle(d=id+extra,$fn=40);
      if(shaftnotch) rotate([0,0,30]) translate([id*-.5-.01,id*-.5-.01]) square([id+.02,.6]);
    }
    if(shaftslot)
      for(r=[0:shaftslot])
      rotate([0,0,-60-120*r]) translate([0,-1.5,0]) {
        if(shaftslot==1&&r==0||(r==1&&shaftslot==2))
          square([od,3]);
        translate([4,-1.5]) square([2.8,6]);
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