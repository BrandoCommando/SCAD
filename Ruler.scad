kerf=0.1;
tw=inches(11);
th=inches(8);
small_spacing=inches(1/4);
big_spacing=inches(1);
factor = 16;
spaces = 16;
hspaces = 1;
boltd=3;
pencild=1.6;
roundr=inches(1/2);
smallr=inches(1/8);
thick=inches(1/8);
preview=0;

!union() {
  tsquare_extension(inches(3),dove1=0);
  translate([inches(3)+6.2,0]) tsquare_extension(inches(3),dove2=0);
  translate([0,-inches(1.5)-4]) tsquare_connection();
}
*rsquare();
translate([0,preview?0:inches(4)+2]) tsquare();
module tsquare() {
  color("red") lexif() tsquare_main();
  color("purple") translate(preview?[0,inches(5),-thick]:[0,inches(2)+1]) rotate(preview?[0,0,-90]:[]) lexif()
    tsquare_top();
  color("yellow") lexif() translate(preview?[0,inches(3)]:[inches(10)+1,inches(2)+2]) rotate(preview?[]:[0,0,90])
    tsquare_shoulder();
  color("teal") translate(preview?[0,inches(-1)]:[inches(10)+2,inches(2)+2]) rotate(preview?[]:[0,0,90]) mirror([0,1])
    tsquare_shoulder();
  color("green") lexif() translate(preview?[inches(10),0]:[0,inches(-2)-1]) tsquare_extension(inches(8));
  color("blue") lexif() translate(preview?[inches(18),0]:[0,inches(-4)-2])
    tsquare_extension(inches(8),dove2=0);
  if(preview) {
    for(x=[inches(8),inches(16)])
    translate([x,0,thick]) lexif() tsquare_connection();
  } else {
    translate([inches(9.25)+6,inches(-4)-1]) tsquare_connection(1);
    translate([inches(8.25)+1,inches(-4)-1]) tsquare_connection(1);
  }
}
module lexif() {
  if(preview) linear_extrude(thick) children();
  else children();
}
module tsquare_main() {
  tsquare_extension(inches(10),inches(2),dove1=0);
}
module tsquare_extension(nomw=inches(12),exo=0,dove1=1,dove2=1) {
  exw=nomw+kerf*2;
  //translate(dove==1?[6,0]:[0,0])
  difference() {
    translate([-kerf,-kerf]) square([exw,inches(2)+kerf*2]);
    for(x=dove1&&dove2?[inches(0),exw-inches(2)]:(dove1?[0]:(dove2?[nomw-inches(2)]:[])))
      translate([x,inches(1)]) tsquare_connector(0);
    translate([exo,0])
    for(x=[0:floor((exw-exo+1)/small_spacing)])
        translate([x*small_spacing,inches(1)+(1*(x%2==0?-1:1))]) circle(d=pencild,$fn=20);
    if(dove1>0)
      for(y=[inches(1/2),inches(1.5)]) translate([0,y]) dovetail(-kerf);
  }
  if(dove2>0)
    translate([nomw/2,0]) mirror([0,0]) translate([nomw/2,inches(1)]) for(y=[inches(1/2),-inches(1/2)]) translate([0,y]) dovetail(kerf);
}
module dovetail(offset=0) {
  offset(1,$fn=20) polygon([[0,3+offset],[4+offset,6+offset],[4+offset,-6-offset],[0,-3-offset]]);
}
module tsquare_shoulder() {
  difference() { union() {
    square([inches(2.125)-roundr,inches(2)-roundr]);
    translate([roundr,0]) square([inches(2.125)-roundr-smallr,inches(2)-smallr]);
    translate([inches(2.125)-smallr,inches(2)-smallr]) circle(r=smallr,$fn=30);
    translate([roundr,inches(2)-smallr]) square([inches(2.125)-roundr-smallr,smallr]);
    translate([inches(2.125)-smallr,smallr]) square([smallr,inches(2)-smallr*2]);
    translate([inches(2),smallr]) circle(r=smallr,$fn=30);
    translate([roundr,inches(2)-roundr]) circle(r=roundr,$fn=80);
  }
  translate([0,inches(1)]) tsquare_connector(0);
}
}
module tsquare_top() {
  difference() {
    union() {
      translate([roundr,0]) square([inches(8)-roundr*2,inches(2)]);
      translate([0,roundr]) square([inches(8),inches(2)-roundr]);
      translate([roundr,roundr]) circle(r=roundr,$fn=80);
      translate([inches(8)-roundr,roundr]) circle(r=roundr,$fn=80);
    }
    for(x=[inches(1),inches(4),inches(7)])
      translate([x,0])
        tsquare_connector();
  }
}
module tsquare_connection(vert=0) {
  difference(){
    translate([0,vert?0:inches(.5)-2]) square([vert?4+inches(1):inches(4),vert?inches(4):4+inches(1)]);
    hull() {
      for(x=[inches(.5),inches(3.5)])
      translate(!vert?[x,inches(1)]:[inches(.5)+2,x]) circle(d=inches(1/2));
    }
    translate([vert?inches(-.5)+2:0,0])
    for(x=[0,inches(2)]) translate([vert?inches(1):x,vert?x:inches(1)])
      tsquare_connector(vert);
  }
}
module tsquare_connector(vert=1) {
  for(x=[-10,10],y=[10:10:40])
        translate(vert?[x,y]:[y,x]) circle(d=boltd-kerf*2,$fn=20);
}
module rsquare() {
  body();
  guide();
  translate([0,inches(1)+1]) guide();
}
module guide() {
  translate([inches(2)+1,inches(2)+1]) difference() {
    square([th,big_spacing]);
    for(x=[big_spacing/2:big_spacing:th-big_spacing/2])
      translate([x,big_spacing/2]) circle(d=boltd-kerf*2,$fn=20);
  }
}
module body() {
difference() {
  union() {
    square([tw,inches(2)]);
    square([inches(2),th]);
  }
  %translate([0,inches(-2)])rotate([0,0,90]) translate([inches(-2)-1+big_spacing*2,inches(-2)-1-big_spacing]) guide();
  for(y=[big_spacing/2:big_spacing:th]) translate([big_spacing/2,y]) circle(d=boltd-kerf*2,$fn=20);
  translate([inches(1),0]) for(x=[1:floor((tw-1)/small_spacing)])
    translate([(x*small_spacing)-kerf,-.01]) {
      square([kerf*2,x>0&&x%spaces==0?big_spacing:(x%(spaces/2)==0?big_spacing*3/4:(spaces==16&&x%(spaces/4)==0?big_spacing*(1/2):big_spacing/4))]);
      if(x%spaces==0)
        translate([0,big_spacing+1]) text(str(x/factor),valign="bottom",halign="center",size=3);
    if(x%hspaces==0)
      translate([kerf,big_spacing+10+(x%spaces==0?10:(x%(spaces/2)==0?7.5:4-(x%4)*2))]) circle(d=pencild,$fn=20);
    }
}
}

function inches(in) = 25.4*in;