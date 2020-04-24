trim=.2;
tw=32;
th=36;
td=25.4*.21;
sr=5;
sr2=0;
wings=0;
bspace=0;
try3=1;
jlap=4; //(th-tw)/2;
jbolt=2.5;
jlock=0;
jbex=jlock?6-td:0; //6-td;
olap=0; //jlap;
olap2=0; //olap;
bot=3;//25.4/4;
bit=bot;
xo=(tw-(sr*2)-(td+jbex))/3;

run=tw/2;
topy=th-tw/2;
dist1=sqrt(pow(topy-jlap*2,2)+pow(run,2));
ang1=atan((topy-jlap*2)-run);
dist2=sqrt(pow(bit/2-4,2)+pow(dist1,2));
boty=-bit/2-dist2/2;
rise=topy-(boty+jlap*2);
h=sqrt(pow(rise,2)+pow(run,2));
cutang=atan(rise/run);
echo(str("TD:",td,",XO:",xo,",Cut:",rise,"/",run,"~",cutang));
bblock();
#translate([0,boty]) rotate([0,0,cutang]) cube(h);
*!bblock_profile();
*!union(){
  xc=5;
  yc=8;
  xx=10;
  xy=th-tw-4;
  for(x=[0:tw+xx:(tw+xx)*(xc-1)+.01],y=[0:th+xy:(th+xy)*(yc-1)+.01])
    translate([x,y]) {
      bblock(0);
      translate([tw/2+xx/2,7]) rotate([0,0,180]) bblock(1);
    }
  if(bit!=bot) for(x=[0,tw+10]) translate([x,th]) cap();
}
*!for(s=[5,4,3]) translate([s*20-60,0]) spacer(s);
*!bblock(0);
*!preview(0);

*!union() {
  preview(0,40);
  translate([0,(th-jlap*2),tw/2])
  rotate([40,0]) translate([0,th-xo,tw/-2]) preview(-40,0);
}
module preview(ang1=0,ang2=0) {
  rotate([0,0,ang1]) {
    if(try3) translate([0,0,sr+xo]) copyz(xo*2) bblock(1);
    else translate([0,0,sr]) mirrorz(tw-sr*2) bblock(1);
    mirrorx3(0,xo*-2) translate([tw/2-sr-xo,th*2-tw-jlap*2,tw/2]) rotate([0,0,180]) rotate([0,90]) bblock(0);
  }
  rotate([0,0,ang2]) {
    translate([0,0,sr]) rotate([0,0,180]) {
      if(try3)
        copyz(xo*2) bblock(0);
      else
        mirrorz(tw-sr*2-xo*2)
        bblock(0);
    }
    translate([xo,0]) mirrorx3(0,xo*2) translate([tw/-2+sr,-(th*2-tw-jlap*2),tw/2]) rotate([0,90]) mirror([try3,0]) bblock(try3?0:1);
  }
}
module preview2(ang1=0,ang2=0) {
rotate([0,0,ang1]) for(y=[0]) translate([0,y]) {
  z=xo;
  translate([0,0,xo+jbex+1])
  mirrorz(xo+jbex*2)
  rotate([0,0,180])
  //translate([0,0,td]) mirror([0,0,1])
     bblock(1);
  mirrorx() translate([5+z-tw/2,-th,24]) rotate([0,90]) bblock(1);
rotate([0,0,ang2-ang1]) for(z=[0]) mirrorz(tw) {
  translate([0,0,z]) bblock();
  translate([z,0]) translate([-24,th,24]) rotate([0,90,0]) rotate([0,0,180]) bblock();
}
}
  cylinder(d=bit,h=50,$fn=40);
}
module bblock_profile(inner=0) {
  if(wings) mirrorx() rotate([0,0,inner?-10:-25]) hull() {
    circle(d=20,$fn=50);
    translate([tw/2-(inner?0:2),0]) circle(d=10,$fn=40);
  }
  difference() {
    union(){
      polygon([[tw/-2,topy-jlap*2],[tw/-2,topy],
      [tw/2,topy],[tw/2,topy-jlap*2],
      [0,boty]]);
      hull()
      {
        circle(d=bit+8,$fn=100);
        if(sr2>0)
          for(y=[0,-jlap*2]) translate([0,y]) mirrorx() translate([tw/2-sr2,th-tw/2-sr2]) circle(r=sr2,$fn=30);
        else
          translate([tw/-2,th-tw/2-jlap*2]) square([tw,jlap*2]);
      }
    }
    circle(d=bot==bit?bot:bot-2,$fn=40);
    mirrorx3(0,xo*2) translate([tw/-2+sr-trim,th-tw]) {
      for(x=(try3?[0]:[0,xo]))
      {
        small=0; //(inner==0)==(x==0)?0:2;
        tlap=(small==0||inner)?olap:olap2;
        translate([x-small/2,small>0?tw/2-tlap:tw/2-jlap])
        {
          square([td+trim*2,small>0?tlap:tw/2]);
        }
      }
    }
  }
}
module bblock(inner=0) {
  difference() {
    union() {
      linear_extrude(td,convexity=5) bblock_profile(inner);
      if(jbex>0&&jlock==1)
      {
        translate([tw/2,(th-tw)+tw/2-jlap+jbolt-trim,td/2+jbex/2]) rotate([0,-90,0]) cylinder(d=td+jbex,h=tw,$fn=30);
      }
      if(bspace&&bit==bot) translate([0,0,td]) cylinder(d1=bit+8,d2=bit+4,h=td+xo-td*2-trim*2,$fn=50);
    }
    mirrorx3(0,xo*2) translate([tw/-2+sr-trim,th-tw]) {
      for(x=(try3?[0]:[0,xo]))
      {
        small=0; //(inner==0)==(x==0)?0:2;
        tlap=(small==0||inner)?olap:olap2;
        translate([x-small/2,small>0?tw/2-tlap:tw/2-jlap,-.01])
        {
          cube([td+trim*2,small>0?tlap:tw/2,td+jbex+.02]);
          if(!inner&&jbex>0) translate([0,0,td]) cube([td+trim*2+small+jbex,small>0?tlap:tw/2,jbex+.02]);
        }
      }
    }
    if(bit!=bot) for(r=[0:120:359]) rotate([0,0,r-30]) translate([15,0,-.01]) cylinder(d=3,h=td+.02,$fn=20);
    mirrorx() {
        translate([tw/-2+sr+td/2,0]) translate([!inner?0:xo,(th-tw)+tw/2-jlap-jbolt+trim,-.01]) {
          if(jlock==1)
            translate([jbex*.5,0]) cylinder(d=3,h=10+td+.02,$fn=20);
          else if(jlock==2)
            for(z=[0,td+.01]) translate([td*-.5-.6,0,z]) rotate([0,90,0]) cylinder(d=2+trim*2,h=td+1.2,$fn=20);
        }
    }
    if(jlock==1)
      translate([tw/2+.01,(th-tw)+tw/2-jlap+jbolt-trim,td/2+jbex/2]) rotate([0,-90,0]) cylinder(d=3,h=tw+.02,$fn=20);
    if(bot!=bit)
      translate([0,0,-.01]) cylinder(d=bot-2,h=1.02,$fn=40);
    else
      translate([0,0,-.01]) cylinder(d=bit+trim*2,h=td+xo+.02,$fn=40);
    translate([0,0,1]) cylinder(d=bot+trim*2,h=td,$fn=40);
  }
  if(jlock==2)
      mirrorx() mirrorx(inner?xo:td+trim*2) translate([(!inner?(tw/2-sr-td/2):xo/2)+td/2+trim,(th-tw)+tw/2-jlap+jbolt-trim,-.01])
        cylinder(d=2,h=td,$fn=30);

  if(bit!=bot) {
    %translate([0,0,1]) linear_extrude(7,convexity=3) difference() {
      circle(d=bot,$fn=40);
      circle(d=bit,$fn=30);
    }
    translate([0,0,8]) %spacer();
    *color("blue") %translate([0,0,9.03]) mirror([0,0,1])
      cap();
  }
  
}
module spacer(h=0) {
  linear_extrude(h==0?xo-7:h,convexity=3) difference() {
      circle(d=12,$fn=36);
      circle(d=bit+.8,$fn=30);
  }
}

module cap()
{
  difference() {
    hull() {
      cylinder(d=40,h=9-td,$fn=50);
      for(r=[0:120:359]) rotate([0,0,r-30]) translate([15,0])
        cylinder(d=7,h=9-td,$fn=30);
    }
    for(r=[0:120:359]) rotate([0,0,r-30]) translate([15,0,-.01]) cylinder(d=3,h=9-td+.02,$fn=20);
    translate([0,0,1]) cylinder(d=bot+trim*2,h=8-td+.02,$fn=40);
    if(bot!=bit)
    translate([0,0,-.02]) cylinder(d=bot-2,h=td,$fn=40);
    else
      translate([0,0,-.02]) cylinder(d=bit,h=td,$fn=30);
  }
}

module mirrorx3(off=0,offc=0)
{
  if(try3) copyx(offc) children();
  else mirrorx(off) children();
}
module mirrorx(off=0)
{
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrorz(off=0)
{
  *copyz(off) children();
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/-2]) children();
}
module copyx(off=0)
{
  for(c=[0,1]) translate([off*c,0]) children();
}
module copyz(off=0)
{
  for(c=[0,1]) translate([0,0,off*c]) children();
}