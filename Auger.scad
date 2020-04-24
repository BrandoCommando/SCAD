part="halves"; // [all:Full Assembly,auger:Auger (Twisted Linear),auger2:Auger (Manual Twist),Cap:Pipe Cap,bplug:Bearing Plug,connector:Motor Connector,bridge:Connector Bridge]
turns=2;
th=25.4*4;
boff=0;
toff=10;
wt=1.6*2;
pid=28;
pod=34;
layh=.3;
slices=0; //floor(th/layh);
arms=2;
hopsex=1;
hops=2; // hop support
hopd2=152.4;
hoph2=100;
hopd3=hopd2;
hoph3=40;
if(part=="all")
{
  translate([0,0,-20]) connector();
  
//  pipe();
  auger2();
  *translate([0,0,-7]) linear_extrude(7) difference() { circle(d=22,$fn=50); circle(d=8,$fn=40); }
} else if(part=="bplug")
{
  difference() {
    union() {
      cylinder(d=8.2,h=8,$fn=40);
      cylinder(d=10,h=2,$fn=40);
      cylinder(d=21.8,h=1,$fn=60);
    }
    translate([0,0,-.1]) cylinder(d=3,h=10.2,$fn=20);
  }
} else if(part=="connector")
{
  connector();
  %color("blue") translate([-10.4,-30]) connector_bridge();
} else if(part=="bridge")
{
  connector_bridge();
} else if(part=="cap")
{
  difference() {
    union() {
      difference() {
        cylinder(d=pod+wt,h=25,$fn=50);
        translate([0,0,wt/2]) cylinder(d=pod,h=50,$fn=50);
      }
      translate([0,0,wt/2]) {
        difference() {
          cylinder(d=pid-.4,h=20,$fn=50);
          translate([0,0,-.1]) cylinder(d=22.2,h=20.2,$fn=50);
        }
        difference() {
          cylinder(d=22.2+wt,h=4,$fn=50);
          translate([0,0,10.8]) cylinder(d=20,h=3.22,$fn=50);
        }
      }
    }
    translate([0,0,-.1]) cylinder(d=20,h=50.2,$fn=50);
  }
} else if(part=="pipe")
{
  pipe();
} else if(part=="mold")
{
      mwt=2;
  intersection(){
    translate([pid*-1,-mwt,pid*-1]) cube([pid*2,th+mwt*4,pid]);
    difference() {
      translate([pid*-.5-mwt,-mwt,pid*-.5-mwt]) cube([pid+mwt*2,th+mwt*4,pid+mwt*2]);
      rotate([-90,0]) {
        auger();
        translate([0,0,-5]) cylinder(d=4,h=th+20,$fn=25);
      }
      for(y=[(th-toff)/8:(th-toff)/4:th-toff],x=[-10,10])
        translate([x,y,-30]) cylinder(d=3,h=60,$fn=20);
    }
  }
} else if(part=="auger2") {
  auger2();
} else if(part=="mold2") {
  difference() {
    translate([pid*-.5-2,-2,pid*-.5-2]) cube([pid+4,th+4,pid/2+2]);
    rotate([-90,0]) auger2(0);
    translate([0,-2.1,0]) rotate([-90,0]) cylinder(d=3,h=th+4.2,$fn=20);
  }
} else if(part=="auger") {
  auger();
} else {
  
  mirror([0,0,1]) halves();
}
module connector_bridge() {
  translate([0,9.7,4]) {
    cube([20.8,2,5.6]);
    cube([2,4.5,5.6]);
    translate([18.8,0]) cube([2,4.5,5.6]);
  }
  translate([0,-3]) cube([20.8,2.8,9.6]);
  difference() {
    translate([0,-3]) cube([20.8,23,4.7]);
    translate([10.4-1,10.1,-.1]) cube([2,12,2]);
    for(x=[5.4,15.4])
    {
      translate([x,4,-.01]) cylinder(d=3,h=5,$fn=20);
      translate([x,16,-.01]) cylinder(d=4,h=5,$fn=20);
    }
  }
}
module connector() {
  difference() {
    union() {
      translate([0,0,22]) cylinder(d=pod+wt,h=60,$fn=80);
      translate([(pod+wt)/-2-1,(pod+wt)/-2+.5]) cube([pod/2,pod+wt-1,82]);
      translate([0,0,40]) {
        *rotate([0,0,90]) cylinder(d=pod+wt,h=30,$fn=80);
        hull() {
          rotate([0,90]) cylinder(d=pod+wt,h=30,$fn=70);
          translate([0,0,pod/-1]) cylinder(d=pod+wt,h=pod*1.5+3,$fn=80);
        }
      }
      translate([-10.5-wt/2,-30]) difference() {
        cube([21+wt,10,10]);
        for(xo=[5,-5]) translate([(21+wt)/2+xo,4,-.01]) cylinder(d=3,h=20,$fn=20);
      }
      hull()
      {
        cylinder(d=36+wt,h=12,$fn=80);
        translate([0,0,12]) cylinder(d1=36+wt,d2=pod+wt,h=10,$fn=80);
        translate([-10.5-wt/2,-10.5-wt/2]) difference() {
          translate([0,46.5+wt]) mirror([0,1]) linear_extrude(9.7) hull() {
            square([21+wt,20]);
            translate([10.5+wt/2,34+wt]) circle(d=36+wt,$fn=80);
            translate([0,40]) square([21+wt,20]);
          }
          *cube([21+wt,46.5+wt,9.7]);
          *translate([wt/2,38,wt/2]) cube([21,18.5,9]);
        }
      }
    }
    translate([0,0,72]) cylinder(d=pod,h=11,$fn=70);
    translate([0,0,40]) rotate([0,90]) {
      cylinder(d=pid,h=31,$fn=60);
      translate([0,0,20]) cylinder(d=pod,h=11,$fn=70);
      translate([0,0,29]) cylinder(d=pod+wt*2,h=5,$fn=80);
    }
    translate([0,0,wt/2]) cylinder(d=36,h=12.1,$fn=70);
    translate([0,0,wt/2+12]) cylinder(d1=36,d2=pid+1,h=8.1,$fn=70);
    translate([0,0,wt/2+20]) cylinder(d1=pid+1,d2=pid,h=2.1,$fn=70);
    translate([0,0,wt/2+22]) cylinder(d=pid,h=90.1,$fn=70);
    translate([-10.5,-10.5,-.2]) 
      difference() {
        union() {
          linear_extrude(10) hull() {
          //cube([21,41,10]);
            translate([0,-10]) square([21,51]);
            translate([10.5,10.5]) circle(d=36,$fn=70);
          }
          translate([0,-20]) cube([21,20,5]);
        }
        *translate([0,pid*-.5+5]) cube([21,11,10]);
      
    }
    intersection() {
      translate([-20,-10,-.1]) cube([40,30,4]);
      translate([0,0,-.1]) cylinder(d=36,h=4,$fn=50);
    }
    for(y=[-20,30]) translate([-1,y,-.1]) cube([2,11,2]);
    for(x=[-5,5],y=[-14,34])
      translate([x,y,-.1]) {
        cylinder(d=4,h=4,$fn=28);
        translate([0,0,wt/2+.1]) cylinder(d=6,h=y>0?20:12,$fn=38);
        *translate([0,0,wt/2+12]) cylinder(d1=6,d2=0,h=10,$fn=38);
      }
  }
}
module halves() {
  for(side=[0,1]) translate([40*side,0]) rotate([0,0,90]) rotate([side*180,0]) intersection() {
      translate([-15,-15,side*-15]) cube([th+15,30,15]);
  *!rotate([0,180]) hopper();
  *hopper();
  //translate([-20,0])
  {
    *difference() {
    rotate([0,90])
        linear_extrude(th,convexity=8) { difference() { circle(d=34,h=th,$fn=60); circle(d=29.4,$fn=60); } }

        translate([20,0]) cylinder(d=24,h=20,$fn=80);
      }
    rotate([0,90])
      {
      auger();
    *#for(z=[0,th-7]) translate([0,0,z]) linear_extrude(7) difference() { circle(d=22,$fn=50); circle(d=8,$fn=24); }
    }
  }
  }
}
module pipe() {
  difference() {
    linear_extrude(th,convexity=5) {
      difference() {
        circle(d=pod,$fn=60);
        circle(d=pid,$fn=60);
      }
    }
    translate([0,0,th-pid/2-5]) rotate([90,0]) cylinder(d=pid-10,h=pid,$fn=50);
  }
}
module hopper() {
  difference() {
    translate([0,0,10]) cylinder(d=34,h=41,$fn=80);
    cylinder(d1=22,d2=29.4,h=52,$fn=60);
    translate([-20,0]) rotate([0,90]) cylinder(d=34,h=60,$fn=80);
  }
  if(hopsex>1)
  translate([0,0,51]) difference() {
    union() {
      cylinder(d1=34,d2=hopd2,h=hoph2,$fn=100);
      if(hops>0)
      for(r=[18:360/5:359]) if(r!=270) rotate([0,0,r]) translate([0,hopd2/2-20,hoph2]) mirror([0,0,1]) {
        if(hops==1)
          cylinder(d=8,h=hoph2+68,$fn=40);
        else if(hops==2)
          difference(){
            cylinder(d=12,h=50,$fn=40);
            translate([0,0,40]) cylinder(d=8,h=50,$fn=40);
          }
      }
    }
    translate([0,0,-.1]) cylinder(d1=29.4,d2=hopd2-4.6,h=hoph2+.2,$fn=100);
  }
  if(hopsex>2)
  translate([0,0,51+hoph2]) difference() {
    cylinder(d1=hopd2,d2=hopd3,h=hoph3,$fn=100);
    translate([0,0,-.1]) cylinder(d1=hopd2-4.6,d2=hopd3-4.6,h=hoph3+.2,$fn=100);
  }
}
module auger_base() {
  translate([0,0,-5]) cylinder(d=30,h=1,$fn=80);
  translate([0,0,-4]) cylinder(d1=30,d2=pid,h=3,$fn=80);
  translate([0,0,-1]) cylinder(d=pid,h=1,$fn=80);
  cylinder(d1=16,d2=8,h=4,$fn=50);
}
module auger_base_holes() {
    for(r=[0:90:359],x=[13]) rotate([0,0,r]) translate([x,0,-5.1]) cylinder(d=2,h=5,$fn=20);
    translate([0,0,-5.1]) cylinder(d1=6,d2=5.5,h=3,$fn=30);
    translate([0,0,-2.2]) cylinder(d1=5.5,d2=3,h=4,$fn=30);
    *translate([0,0,-5.01]) for(z=[0:layh:4-layh]) translate([0,0,z]) linear_extrude(layh-.8) difference() { offset((4-z)/2) auger_profile(); auger_profile(); }
  }
module auger2(rod=1) {
  c=floor(th/layh);
  lr=(360*turns)/c;
  echo(str("Layers: ",c," Height: ",layh," Rotate: ",lr));
  difference() {
    union() {
      auger_base();
      for(i=[0:c-1])
      {
        scale=1;
        if(scale!=1) echo(str("Scale: ",scale));
          translate([0,0,i*layh])
            rotate([0,0,-i*lr])
              linear_extrude(layh+.01)
                auger_profile(d1=8*scale,d2=4*scale,fdist=(i>=c-80?((c-i)/80)*(pid/2):pid/2));
      }
    }
    if(rod)
      translate([0,0,-.1]) cylinder(d=3,h=th+.2,$fn=20);
    auger_base_holes();
  }
}
module auger_profile(d1=8,d2=4,fdist=pid/2) {
  dist=fdist-d2/2;
  for(r=[0:360/arms:359]) {
    hull2() {
      circle(d=d1,$fn=16);
      rotate([0,0,r])
        translate([dist*(1/3),0]) circle(d=d1/2+d2/2,$fn=16);
      rotate([0,0,r])
        translate([dist,0])
          circle(d=d2,$fn=16);
   }
  }
}
module hull2() {
  for(i=[0:$children-2])
    hull()
      children([i:i+1]);
}
module auger(scale=[],slices=slices) {
  difference() {
    union() { auger_base();
  for(r=[-30:360/arms:359]) rotate([0,0,r]) 
    intersection(){
      cylinder(d=pid,h=th,$fn=100);
      union(){
        cylinder(r=4,h=th,$fn=50);
        translate([0,0,boff]) linear_extrude(th-boff-toff,convexity=10,twist=turns*360,slices=slices,scale=scale,$fn=200)
          translate([0,-3]) polygon([[0,0],[6,5],[9,7],[12,9],[14,12],[10,11],[5,8],[0,6]]);//square([15,4]);
      }
    }
  }
  rotate([0,0,45]) auger_base_holes();
    *translate([0,0,-.01]) cylinder(d=3,h=th+.02,$fn=20);
  }
}