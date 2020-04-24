legs=30;
legshape="1";
//*
difference(){
  union(){
    for(r=[0:120:240]) rotate([0,0,r]) translate([0,0,4]) {
      if(legshape=="2")
        rotate([0,0,60]) translate([0,0,-2]) linear_extrude(3.98) polygon([[-8,0],[-4,legs],[4,legs],[8,0]]);
      else if(legshape=="3")
        rotate([0,0,60]) translate([20,0]) translate([0,0,-4]) //minkowski()
      { linear_extrude(7.98) difference(){ circle(d=26,$fn=50); translate([-2,-20,0]) circle(d=30,$fn=60);}
       // sphere(2,$fn=30);
        }
     rotate([90,0]) {
      if(legshape=="1")
      {
        difference(){
        cylinder(d=7.98,h=legs,$fn=20);
          translate([0,0,-.01]) cylinder(d=3,h=legs+.02,$fn=20);
        }
      }
      translate([0,0,legs+3]) rotate([-90,0]) translate([0,0,-2]) rotate([0,0,90]) difference() {
        *minkowski(){
         cylinder(d=14,h=4,$fn=56);
          sphere(2,$fn=30);
        }
        *translate([0,0,-1]) cylinder(d=12.8,h=8,$fn=6);
      }
    }
  }
    minkowski(){
      translate([0,0,2]) cylinder(d=25,h=4,$fn=100);
      sphere(2,$fn=20);
  }
}
  translate([0,0,-.01]) cylinder(d=22.4,h=8,$fn=50);
  *for(r=[0:120:240]) rotate([0,0,r+30]) translate([legs+3,0,1]) rotate([0,0,60]) cylinder(d=12.8,h=20,$fn=6);
}
*!for(r=[90])
  rotate([0,0,r]) translate([26,0]) {
    cylinder(d=12,h=1,$fn=6);
    screw(d=6,h=6,pitch=25.4/20,thread=25.4/40,$fn=20);
  }
/*/

screw(25.4*(7/16),6,pitch=1);
/**/
module screw(d,h,pitch=0.5,thread=false,type=1,$fn=30)
{
  threadd=thread?thread:pitch;
  id=d-threadd*2;
  turns = h/pitch;
  intersection()
  {
    cylinder(d=d,h=h,$fn=100);
  if(type==1) {
    lh=0.1;
    rpz=(360/pitch);
    echo(str("RPZ:",rpz));
    cylinder(d=id,h=h,$fn=30);
    for(z=[0:lh:h]) translate([0,0,z]) rotate([0,0,rpz*z]) translate([threadd/2,0]) cylinder(d=d-threadd,h=lh,$fn=$fn);
  } else {
      union(){
        segang=180;
        cork=id/(pitch*4);
        segs=turns*2;
        segh=pitch;
        cylinder(d=d-threadd*2,h=h,$fn=30);
        *rotate([0,0,90]) mirror([1,0]) linear_extrude(height=h,center=false,twist=360*turns,scale=[1,1,2],$fn=30)
          translate([d/2-threadd,0]) circle(r=threadd);
        z=0;side=0;
        for(z=[0:turns-1],side=[0:360/segang])
        {
          translate([0,0,((side)*pitch/(360/segang))+(pitch/4+(z*segh))]) rotate([0,0,(side)*segang]) rotate([0,cork]) rotate([0,0,0]) rotate_extrude(angle=segang,$fn=30) {
            translate([d/2-threadd,0]) polygon([[0,pitch/2],[threadd,0],[0,pitch/-2]]);
          }
        }
      }
    }
  }
}