part="fclamp";
diag_flat=1;
fclamp_guide=0;
fclamp_gh=1.5;
fclamp_mh=12;
fclamp_lip=6;
fclamp_recess=3;
fclamp_lh=3;
fclamp_grip=1;

if(part=="corner_90"||part=="all")
  corner_90();
if(part=="corner_straight")
  corner_straight();
if(part=="outer_flat_connector")
{
  outer_flat_connector();
  translate([-7.5,10.4]) cube([35,60,20]);
}
if(part=="sclamp")
{
  sclamp();
}
if(part=="fclamp")
{
  fclamp(fclamp_mh,fclamp_lip);
}
module sclamp(width=5,dist=10)
{
  
}
module fclamp(mh=3,lip=6,guide=fclamp_guide,gh=fclamp_gh)
{
  difference(){
    union(){
      cube([20,20,mh+2]);
      if(guide)
        translate([0,7.2,mh+2]) translate([10,2.8]) rotate([0,0,90*guide]) translate([-10,-2.8]) cube([20,5.6,gh]);
    }
    translate([10,10,-.01]) {
      if(fclamp_recess)
      {
        translate([0,0,-.01]) cylinder(d=7,h=fclamp_recess,$fn=30);
        translate([0,0,fclamp_recess-.02]) cylinder(d1=7,d2=3.6,h=2,$fn=30);
      }
      cylinder(d=3.6,h=mh+gh+5.02,$fn=20);
    }
    translate([-.1,-.1,fclamp_lh]) cube([20.2,lip+.1,mh+gh+5]);
    translate([10,20.01,fclamp_lh/2+mh/2]) rotate([90,0]) linear_extrude(0.81) {
      mirror([1,0]) rotate([0,0,180]) text(str(mh),size=mh>8?10:mh,valign="center",halign="center");
    }
  }
  if(fclamp_grip)
    for(x=[0:19/4:19])
      translate([x,0,fclamp_lh-.01]) cube([1,lip,1]);
}
module outer_flat_connector(rows=[1,0,0,0,1],cols=[0,0]) {
  posx=[0:20:len(cols)*20-1];
  posy=[0:20:len(rows)*20-1];
  difference() {
    union() {
      for(i=[0:len(rows)-1])
        if(rows[i])
        translate([0,0,3]) linear_extrude(1.98) hull() {
          translate([0,i*20]) circle(d=5.6,$fn=24);
          translate([(len(cols)-1)*20,i*20]) circle(d=5.6,$fn=24);
        }
      *for(i=[0:rows-1])
        translate([0,0,3]) linear_extrude(2) hull() {
          translate([i*20,0]) circle(d=5.6,$fn=24);
          translate([i*20,(cols-1)*20]) circle(d=5.6,$fn=24);
        }
      linear_extrude(3,convexity=3) hull()
      {
        for(x=posx,y=posy)
          translate([x,y]) circle(d=15,$fn=40);
      }
      linear_extrude(3) for(x=posx,y=posy)
        if(rows[y/20])
        translate([x,y]) circle(d=18,$fn=40);
    }
    translate([0,0,-.1]) linear_extrude(8,convexity=3)
      for(x=posx,y=posy)
          if(rows[y/20])
        translate([x,y]) circle(d=3.6,$fn=20);
    for(x=posx,y=posy) translate([x,y,3]) cylinder(d1=12,d2=16,h=2,$fn=30);
  }
}
module corner_straight(flat_diag=diag_flat) {
  intersection() {
    rotate([flat_diag==1?225:(flat_diag==2?45:0),0,0])
    difference() {
      union() {
        cube([20,20+(flat_diag?3:0),20+(flat_diag?3:0)]);
        translate([7.2,-1,0]) difference() {
          cube([5.6,2,20]);
          translate([-.1,-.1,7.5]) cube([6,3,8]);
        }
        if(flat_diag)
        translate([7.2,-1,-1]) difference() {
          cube([5.6,21,2]);
          translate([-.1,9.5,-.1]) cube([6,6,3]);
        }
      }
      translate([-.1,20,3]) cube([20.2,4.2,5]);
      translate([3,3,3]) cube([14,18,18]);
      translate([-.1,23,0]) rotate([45,0]) cube([23,23,35]);
      for(y=[11.5])
        translate([10,y,-2.1]) cylinder(d=3.6,h=5.2,$fn=20);
      translate([10,-2.1,11.5]) rotate([-90,0]) cylinder(d=3.6,h=5.2,$fn=20);
        if(flat_diag)
        {
          translate([-.1,20,0]) rotate([-45,0]) translate([0,0,-5]) cube([20.2,5,10]);
          translate([-.1,0,20]) rotate([45,0,0]) translate([0,-5]) cube([20.2,15,5]);
        }
    }
    if(flat_diag==1)
      translate([-.1,-20,-20]) cube([20.2,40,19]);
    if(flat_diag==2)
      translate([-.1,-20,5]) cube([20.2,40,20]);
  }
}
module corner_90(flat_diag=diag_flat, flat_bottom=!diag_flat) {
  rotate(flat_diag?[225,0,0]:[])
    difference() {
      union() {
        cube([20,20+(flat_diag?0:0),20+(flat_diag?3:0)]);
        translate([7.2,-1,0]) difference() {
          cube([5.6,2,20]);
          translate([-.1,-.1,7.5]) cube([6,3,8]);
        }
        if(!flat_bottom)
        translate([0,7.2,-1]) difference() {
          cube([20,5.6,2]);
          translate([6,-.1,-.1]) cube([8,6,3]);
        }
      }
      translate([-.1,20,3]) cube([20.2,4.2,5]);
      translate([3,3,3]) cube([14,18,18]);
      translate([-.1,23,0]) rotate([45,0]) translate([0,0,0]) cube([23,23,35]);
      for(y=[10])
        translate([10,y,-2.1]) cylinder(d=3.6,h=5.2,$fn=20);
      translate([10,-2.1,11.5]) rotate([-90,0]) cylinder(d=3.6,h=5.2,$fn=20);
      if(flat_diag)
      {
        translate([-.1,20,-.1]) rotate([-45,0]) //translate([0,-2,-2])
          cube([20.2,15,5]);
        translate([-.1,0,20]) rotate([45,0,0]) translate([0,-5]) cube([20.2,15,5]);
      }
    }
}