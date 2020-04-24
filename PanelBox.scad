boxw=80;
boxh=80;
boxd=4;
wallt=1.6;
rr=10;
take1();
module take2() {
difference() {
  cube([80,30,3]);
  translate([15,15,-.01]) encoder_cutout();
  translate([65,15,-.01]) encoder_cutout();
}
}
module take1(tw=boxw,th=boxh,td=boxd,wallt=wallt) {
 {
   difference() {
    translate([0,0,0.1]) cube2([tw,th,td],rr);
    linear_extrude(wallt) {
      *translate([tw/2,14]) slider_cutout();
      translate([22,th/4-2]) toggle_switch_cutout();
      translate([22,th/2]) key_switch_cutout();
      translate([22,th/4*3+2]) circle(d=13,$fn=30);
      *translate([14,52]) toggle_switch_cutout();
      //translate([tw-16,th-16]) encoder_cutout();
      translate([tw-27,th/2]) lightup_button_cutout();
    }
    translate([wallt,wallt,wallt-0.2]) cube2([tw-wallt*2,th-wallt*2,td+rr],rr-(boxd>20?2:1),boxd>20);
  }
    if(boxd<20)
      difference() {
    translate([wallt,wallt]) cube2([tw-wallt*2,th-wallt*2,td+4],rr-1,0);
    translate([wallt*2,wallt*2,-.01]) cube2([tw-wallt*4,th-wallt*4,td+5],rr-3,0);
        
      }
  /*
  cube([tw,wallt,td]);
  cube([wallt,th,td]);
  translate([0,th-wallt]) cube([tw,wallt,td]);
  translate([tw-wallt,0]) cube([wallt,th,td]);
  //*/
}
}
module encoder_cutout()
{
  cylinder(d=7.5,h=4,$fn=30);
  translate([-6.2,-6.2,2]) cube([12.4,12.4,2]);
  translate([-1.2,-7,2]) cube([2.4,2,2]);
}
module lightup_button_cutout()
{
  //circle(d=46,$fn=80);
  circle(d=24.6,$fn=50);
}
module toggle_switch_cutout()
{
  difference() {
    circle(d=13,$fn=30);
    translate([4.5,-.8]) square([2,1.6]);
  }
}

module key_switch_cutout()
{
  intersection(){
    circle(d=13,$fn=30);
    translate([-5.5,-6.5]) square([11,13]);
  }
}
module slider_cutout()
{
  translate([-32.5,0]) circle(d=3,$fn=20);
  translate([32.5,0]) circle(d=3,$fn=20);
  translate([-28,-2]) square([56,4]);
}
module cube2(dims,r=5,all=0)
{
  if(!all) {
    linear_extrude(dims[2]) {
      for(x=[r,dims[0]-r],y=[r,dims[1]-r])
        translate([x,y]) circle(r=r,$fn=r*4);
      translate([0,r]) square([dims[0],dims[1]-r*2]);
      translate([r,0]) square([dims[0]-r*2,dims[1]]);
    }
  } else {
    translate([r,r,r]) minkowski() {
      cube([dims[0]-r*2, dims[1]-r*2, dims[2]-r*2]);
      sphere(r=r,$fn=r*5);
    }
  }
}