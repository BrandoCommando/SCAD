hoseid=34;//2.5*25.4-4;
hoselip=10;
thick=4;
part="sarm"; // [all:Preview All,all2:Preview All (disected),top:Top Section,bottom:Bottom Section,bottom2:Bottom Port,tongue:Tongue,sarm:Servo Arm]
tyoff=10;
txoff=12;
addmount=1;
addservo=1;
anglemin=-31;
anglemax=31;
prevopen=0.5;

topy=hoseid*2+tyoff+20;
if(part=="all") {
  
  topgate();
  translate([0,prevopen*(hoseid+3.5),0]) tongue();
  bottomgate();
  bottomport();
}
else if(part=="all2")
{
  translate([0,0,12]) topgate();
  translate([0,prevopen*(hoseid+3.5),8]) tongue();
  translate([0,0,2]) bottomgate();
  translate([0,0,-2]) bottomport();
}
else if(part=="tongue")
  tongue();
else if(part=="top")
  topgate();
else if(part=="bottom")
  bottomgate();
else if(part=="bottom2") {
  mirror([0,0,1]) bottomport();
}
else if(part=="sarm")
  mirror([0,0,1]) servo_arm();
module tongue() {
  translate([hoseid/2+txoff,hoseid/2+tyoff,3.5])
  {
    cylinder(d=hoseid+7,h=3.5,$fn=hoseid);
    translate([hoseid/-2-3.5,0]) cube([hoseid+7,hoseid/2+12,3.5]);
    translate([hoseid/-2+1,hoseid/2,0]) {
      difference() {
        union(){
          cube([hoseid-2,hoseid+24,3.5]);
          if(addservo)
            translate([hoseid/2-1,hoseid+25]) cylinder(d=10,h=3.5,$fn=40);
        }
        if(addservo)
          translate([hoseid/2-1,hoseid+25,-1]) cylinder(d=3,h=5,$fn=20);
      }
      if(!addservo)
        translate([0,hoseid+21]) cube([hoseid-2,3,10]);
    }
  } 
}
module topgate() {
  intersection(){
    fullgate();
    translate([0,0,7]) cube([hoseid+txoff*2,hoseid*2+20+tyoff,hoselip+23]);
  }
}
module bottomgate() {
  intersection(){
    difference() {
      fullgate();
      *translate([hoseid/2+20,hoseid/2+20]) for(r=[0:45:360])
        rotate([0,0,r]) translate([hoseid/2+8,0,-.01]) cylinder(d=3,h=11,$fn=20);
    }
    translate([0,0,0]) cube([hoseid+40,hoseid*2+40,6.99]);
  }
  if(addservo)
  {
    translate([-23,topy-31+hoseid/2]) {  
        linear_extrude(7,convexity=5) polygon([[-8,20],[-8,40],[0,56],[0,0],[24,0],[24,-hoseid/2],[-2,0]]);
      translate([24,14,0]) cube([6,42,7]);
      difference() {
        cube([24,56,7]);
        translate([1.8,7.8,-1]) cube([20.4,40.4,9]);
        for(x=[6.5,17.5],y=[3.75,52.25])
          translate([x,y,-1]) cylinder(d=3,h=9,$fn=20);
      }
      if(part=="all"||part=="all2")
      {
        #translate([22,48,9.6])
          rotate([0,180,90]) servo();
        translate([12,38,10]) rotate([0,0,anglemin+prevopen*(anglemax-anglemin)]) servo_arm();
      }
    }
  }
}
module servo_arm() {
  difference() {
    linear_extrude(3,convexity=3) {
      difference() {
        hull() {
          circle(d=10,$fn=30);
          translate([hoseid/2+40,0]) circle(d=10,$fn=30);
        }
        hull() {
          translate([hoseid/2+20,0]) circle(d=4,$fn=24);
          translate([hoseid/2+40,0]) circle(d=4,$fn=24);
        }
      }
    }
    translate([0,0,-1]) {
      *cylinder(d=6,h=3,$fn=20);
      for(r=[0:15:360]) rotate([0,0,r]) translate([-2.2,-2.2]) cube([4.4,4.4,3]);
    }
    cylinder(d=2.5,h=4,$fn=20);
  }
}
module bottomport() {
  intersection(){
    fullgate();
    translate([0,0,-hoselip-44]) cube([hoseid+40,hoseid+40,hoselip+43.99]);
  }
}
module fullgate() {
difference() {
  union() {
    if(addmount)
    difference(){
      cube([hoseid+txoff*2,4,38]);
      for(x=[8,hoseid+txoff*2-8]) translate([x,-1,30]) rotate([-90,0]) cylinder(d=4,h=10,$fn=30);
    }
    cube([hoseid+txoff*2,hoseid*2+tyoff+20,10]);
    translate([hoseid/2+txoff,hoseid/2+tyoff,-30]) mirror([0,0,1]) rotate([180,0]) union() {
      translate([0,0,-18]) base_male(35.5);
      translate([0,0,2]) difference() {
        union() {
          cylinder(d=32.5,h=20,$fn=80);
          translate([0,0,20]) cylinder(d1=32.5,d2=40,h=6,$fn=80);
        }
        translate([0,0,-.01]) cylinder(d=27.5,h=20.02,$fn=80);
        translate([0,0,19.98]) cylinder(d1=27.5,d2=35,h=5.04,$fn=80);
      }
      *translate([0,0,20]) difference() {
        cylinder(d1=32,d2=54,h=30,$fn=80);
        translate([0,0,-.01]) cylinder(d1=28,d2=50,h=30.02,$fn=80);
      }
    }
    translate([hoseid/2+txoff,hoseid/2+tyoff,10]) cylinder(d=hoseid+thick,h=hoselip,$fn=100);
    translate([hoseid/2+txoff,hoseid/2+tyoff,-3]) cylinder(d=hoseid+10,h=3,$fn=100);
  }
    for(x=[4,hoseid+txoff*2-4],y=[8,hoseid+tyoff+4,hoseid*2+tyoff+14])
      translate([x,y,-1]) cylinder(d=3,h=12,$fn=20);
    translate([hoseid/2+txoff,hoseid/2+tyoff]) {
      translate([0,0,-3.01]) cylinder(d=hoseid,$fn=100,h=hoselip*2+17);
      translate([0,0,3]) cylinder(d=hoseid+8,h=4,$fn=hoseid);
    }
  translate([txoff-4,hoseid/2+tyoff,3]) cube([hoseid+8,hoseid*2+tyoff+10,4]);
}
  translate([hoseid/2+txoff,0]) for(m=[0,1]) mirror([m,0]) translate([-hoseid/2-txoff,0]) translate([0,hoseid*2+16+tyoff]) cube([txoff,4,10]);
}

module servo(rgstock=0) {
  *%import("Servo13.stl");
  translate([rgstock?-2.5:0,0]) {
  if(rgstock) {
    translate([10,10,-5]) cylinder(d=6,h=38,$fn=20);
    translate([10,10,37]) difference() {
      translate([0,0,-38.5]) cylinder(d=12,d2=11.75,h=40.1,$fn=50);
      translate([0,0,-.01]) cylinder(d=6,h=2,$fn=30);
    }
  }
  cube([40,20,37]);
  translate([10,10,-2]) cylinder(d=6,h=20,$fn=20);
  if(!rgstock) translate([-6.25,0,10]) difference() {
    cube([52.5,20,2.3]);
    for(x=[2,50.5],y=[4.5,15.5])
      translate([x,y,-.01]) cylinder(d=4.5,h=3,$fn=30);
  }
  if(rgstock) {
    difference() {
      mirror_zoffset(19.15) {
        difference() { union() {
            translate([40,-5,8.15]) cube([5,30,1.25]);
            mirror_yoffset(10) translate([40,-1,9.4]) cube([5,7,1.25]);
          }
          mirror_yoffset(10) translate([42.5,2.5,9.4]) { cylinder(d=4.5,h=2,$fn=6);
            translate([0,0,-5]) cylinder(d=2.1,h=10,$fn=30);
            translate([0,-2]) cube([2.51,4,3]);
          }
        }
        mirror_yoffset(10) 
        translate([0,-4.97,8.15]) difference() {
          union(){
            cube([40,5,1.25]);
            translate([0,0,1.25]) {
              cube([6,5,1.25]);
              translate([14.1,0])
                cube([11.85,5,1.25]);
              translate([34,0])
                cube([6.94,5,1.25]);
            }
          }
          for(x=[2.5,17.5,22.5,37.5])
            translate([x,2.5,1.25]) {
              rotate([0,0,90])
                cylinder(d=4.5,h=2,$fn=6);
              translate([-2,-2.51]) cube([4,2.5,3]);
              translate([0,0,-5]) cylinder(d=2.1,h=10,$fn=30);
            }
        }
      }
      mirror_yoffset(10) mirror_zoffset(20) mirror_xoffset(21) translate([-3,0,7]) rotate([0,0,-135]) cube(10);
    }
  }
  }
}

module mirrory(off=0)
{
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off*-.5]) children();
}



module ring(od,id,h)
{
  difference() {
    cylinder(d=od,h=h,$fn=od*2);
    translate([0,0,-.01]) cylinder(d=id,h=h+.02,$fn=id*2);
  }
}
module ring2(od1,od2,t,h)
{
  difference() {
    cylinder(d1=od1,d2=od2,h=h,$fn=od1*2);
    translate([0,0,-.01]) cylinder(d1=od1-t*2,d2=od2-t*2,h=h+.02,$fn=(od1-t*2)*2);
  }
}
module base_male(bd=35) {
  difference() {
    //ring2(bd,bd,4,20);
    //translate([0,0,-.01]) ring2(bd+.5,bd+2,1,1);
    //*
    cylinder(d=bd-.02,h=19.98,$fn=60);
    translate([0,0,-.01]) base_female(bd);
    translate([0,0,-.01]) cylinder(d=bd-8,h=20,$fn=56);
    translate([0,0,9.98]) ring(od=bd+2,id=bd-3,h=10.02);
    *translate([0,0,-.01]) ring2(bd-3,bd-1,1,2);
    //*/
  }
}
module base_female(bd=36.5) {
  difference() {
    cylinder(d=bd,h=10,$fn=60);
    translate([0,0,-.01]) cylinder(d=bd-3,h=3.02,$fn=50);
    translate([0,0,3]) cylinder(d1=bd-3,d2=bd-5,h=1.01,$fn=50);
    translate([0,0,4]) cylinder(d=bd-5,h=4.01,$fn=50);
    translate([0,0,8]) cylinder(d1=bd-5,d2=bd-3,h=1.01,$fn=50);
    translate([0,0,9]) cylinder(d=bd-3,h=1.01,$fn=50);
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