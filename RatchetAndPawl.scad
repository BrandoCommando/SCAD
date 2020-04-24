part="yermom";
include <GT2Pulley.scad>;
//difference(){
translate([10,49,92]) !union() {
  %stepper();
  %translate([0,0,8]) gt2_pulley(14,1,1);
  *translate([0,0,15]) tensioner_plate();
  tensioner_plate(t=5,rods=12);
}
*!linear_extrude(12) { difference() { circle(d=8,$fn=30); circle(d=3,$fn=20); } }
*!servo_mount();
*!pawl(10);
*rotate([-90,0]) rotate([0,0,42]) servo_mount();
*rotate([0,0,70]) translate([1.9,-6.1]) mirror([1,0]) translate([22.03,-18.78]) import("Ratchet_and_pawl/pawl.stl");
%translate([-1*25.4*2.75,1*25.4*2.75]) cube([25.4*5.5,25.4*3/4,200]);
rotate([0,0,-20])
union(){
rotate([0,0,0]) difference() {
  union() {
    color("blue") linear_extrude(8,convexity=2) ratchet();
    translate([0,0,8]) cylinder(d=60,h=8,$fn=90);
  }
  *translate([14,0,-.01]) cylinder(d=3,h=4.02,$fn=20);
  translate([0,0,-.01]) cylinder(d=22.4,h=7.02,$fn=40);
  translate([0,0,-.01]) cylinder(d=9,h=30,$fn=20);
  translate([0,0,7]) cylinder(d1=22.4,d2=9,h=8,$fn=40);
}
*rotate([-90,0]) difference() {
  cylinder(d=7.7,h=10,$fn=30);
  translate([0,0,5]) rotate([-90,0]) translate([0,0,-4]) {
    cylinder(d=3,h=30,$fn=20);
    cylinder(d=6,h=5,$fn=30);
    translate([0,0,7]) cylinder(d=40,h=4,$fn=10);
  }
}
*difference() { sphere(d=7.8,$fn=30); translate([0,0,-2]) cylinder(d=3,h=10,$fn=20); translate([-4,-4,-4]) cube([8,8,1]); }
phase=0;
rotate([0,0,0]) translate([-32,40]) color("green") rotate([0,0,phase*12]) pawl(10);
translate([-33,40,6]) rotate([0,0,12]) translate([46,-4]) {
  color("gray") servo_horn(rot=90-(phase*90));
  rotate([0,0,50]) translate([-8,-10,5]) servo_mount();
}
*difference() {
  translate([-60,-60,-4]) cube([120,120,3.8]);
  translate([0,0,-4.01]) cylinder(d=8,h=4,$fn=30);
  rotate([0,0,atan(32/40)+90]) translate([sqrt(pow(32,2)+pow(40,2)),0,-4.01]) cylinder(d=3,h=4,$fn=20);
}
difference() { union() {
  translate([0,0,48]) {
    difference() {
      translate([0,0,18]) cylinder(d1=14,d2=60,h=28,$fn=50);
      translate([0,0,-.01]) cylinder(d=9,h=46.02,$fn=30);
    }
    //mirror([0,0,1]) reel_gripper();
  }
  translate([0,0,94]) top_reel();
  }
  for(r=[0:90:359]) rotate([0,0,r]) 
  translate([16,0,40]) cylinder(d=3,h=80,$fn=20);
}
*translate([0,0,12]) bottom_reel();
translate([0,0,15]) difference() {
  union(){
    *cylinder(d=34,h=4,$fn=40);
    *cylinder(d1=30,d2=14,h=10,$fn=40);
    cylinder(d=15,h=80,$fn=30);
    
  }
  translate([14,0,-.01]) cylinder(d=3,h=4.02,$fn=20);
  translate([0,0,-.01]) cylinder(d=9,h=130.02,$fn=20);
  translate([0,0,122]) cylinder(d=22.4,h=8.02,$fn=30);
}
}
  translate([0,0,114]) rotate([180,0]) pinch_wheel();

module tensioner_plate(t=3,rods=0) {
  difference() {
    union() {
      translate([-15.5,-15.5,1]) linear_extrude(t) hull() {
        for(x=[0,31],y=[0,31])
          translate([x,y]) circle(d=12,$fn=30);
        translate([-16,-10]) circle(d=12,$fn=30);
        translate([-16,41]) circle(d=12,$fn=30);
      }
      if(rods) {
        mirrory() translate([15.5,-15.5,t+1]) cylinder(d=12,h=rods,$fn=30);
        mirrory() translate([-15.5,-15.5,t+1]) cylinder(d=8,h=rods,$fn=26);
        translate([15.5,-15.5,t+1]) cube([6,31,rods]);
      }
    }
    if(rods) {
      mirrory() translate([15.49,-6,t+(rods/2)+1]) rotate([0,90,0]) cylinder(d=3,h=100,$fn=20);
    }
    translate([0,0,-.01]) cylinder(d=26,h=t+2,$fn=50);
    for(x=[-15.5,15.5],y=[-15.5,15.5]) translate([x,y,.99]) cylinder(d=3,h=t+.02+rods,$fn=20);
    mirrory() translate([-31.5,-25.5,.99]) linear_extrude(t+.02) hull() {
      circle(d=3,$fn=24);
      translate([0,20]) circle(d=3,$fn=24);
    }
  }
}
module pinch_wheel() {
  %translate([0,9]) difference(){
    union() {
      translate([0,25,-4]) cylinder(d=8,h=4,$fn=20);
      translate([0,25]) cylinder(d=8,h=30,$fn=20);
      translate([0,25,7.5]) cylinder(d=22,h=7,$fn=20);
    }
  }
  difference(){
    union(){
      linear_extrude(6) hull() {
      circle(d=12,h=8,$fn=50);
      translate([-6,58,0]) square([12,12]);
      }
      translate([-6,66,0]) cube([12,4,22]);
      *translate([0,25,6]) cylinder(d1=12,d2=9,h=4,$fn=30);
    }
    translate([0,0,-.01]) cylinder(d=9,h=8.02,$fn=30);
    translate([0,25,-.01]) linear_extrude(6.02) hull() {
      circle(d=5,$fn=30);
      translate([0,15,0]) circle(d=5,$fn=30);
    }
    *translate([0,25,4.99]) {
      cylinder(d1=8,d2=5,h=3,$fn=30);
      translate([0,0,2.99]) cylinder(d=5,h=5,$fn=20);
    }
    translate([0,65.99,15]) rotate([-90,0]) cylinder(d=4,h=5,$fn=30);
    for(y=[50,60])
    translate([0,y,-.01]) cylinder(d=3.1,h=8.02,$fn=20);
  }
}
module servo_mount() {
  difference() {
    union(){
      *translate([0,-1]) cube([30,59,5.5]);
      linear_extrude(5.5) {polygon([[0,-1],[0,20],[-10,35],[-20,40],[-25,50],[-20,60],[-10,65],[0,55],[10,55],[30,35],[16,-1],[14,-10],[1,-10]]);
        translate([-18,47]) circle(d=22,h=5.5,$fn=40);
        translate([-18,63]) circle(d=14,$fn=30);
        translate([8,-8]) circle(d=14,$fn=30);
      }
      translate([0,50,5]) rotate([0,0,-42]) {
        translate([-15,-3]) rotate([-45,0]) cube([45,6,10]);
        translate([-18,1,-5]) cube([50,6,25]);
      }
    }
    translate([8,-8,-.01]) cylinder(d=3,h=6,$fn=20);
    translate([-18,63,-.01]) cylinder(d=3,h=6,$fn=20);
    translate([-18,47,-.01]) cylinder(d=3,h=6,$fn=20);
    translate([0,50,5]) rotate([0,0,-42]) translate([0,2.99]) {
      rotate([-90,0]) translate([-2,0,-2]){
        for(pt=[[-9,-10],[-2,-15],[5,-10],[12,-15],[20,-10],[27,-15]])
          translate(pt) cylinder(d=4,h=8,$fn=20);
      }
    }
    translate([8,1.5,-.01]) cylinder(d=2,h=6,$fn=20);
    translate([8,29,-.01]) cylinder(d=2,h=60,$fn=20);
    translate([8,51,-.01]) rotate([0,0,-42]) translate([-34,0]) cube([70,20,30]);
    translate([1,3.5,1]) cube([14,23.5,5]);
    translate([8,10,-.01]) linear_extrude(5) {
      translate([-2.6,0]) square([5.2,6.5]);
      //hull()
      {
        circle(d=12,h=5,$fn=30);
        translate([0,6.5]) circle(d=5.2,h=5,$fn=20);
      }
    }
  }
}
module bottom_reel() {
  difference(){
  union(){
    translate([0,0,1]) cylinder(d=100,h=4,$fn=100);
    
  }
  translate([0,0,-.01]) cylinder(d=60,h=4.2,$fn=90);
  translate([0,0,-.01]) cylinder(d=14.4,h=20,$fn=30);
}
}
module reel_gripper() {
  mirror([0,0,1]) difference(){
    union(){
      translate([0,0,-4]) cylinder(d=40,h=4,$fn=50);
      translate([0,0,-12]) cylinder(d=20,h=8,$fn=30);
    }
    *for(r=[0:45:359]) rotate([0,0,r])
      translate([16,0,-4.01]) cylinder(d=3,h=20,$fn=20);
    *for(r=[0:90:359]) rotate([0,0,r+22.5])
      translate([7,0,-8]) rotate([0,90,0]) cylinder(d=3,h=6,$fn=20);
    translate([0,0,-20.01]) {
      cylinder(d=14.4,h=20.02,$fn=30);
    }
  }
}
module top_reel() {
  difference() {
    union(){
      cylinder(d=60,h=4,$fn=90);
      *translate([0,0,2]) cylinder(d=40,h=8,$fn=100);
      translate([0,0,4]) gt2_pulley(72,1,1);
    }
    *translate([0,0,-.01]) cylinder(d=14.4,h=5,$fn=30);
    translate([0,0,4.98]) cylinder(d=22.4,h=8.04,$fn=50);
    translate([0,0,-.01]) cylinder(d=9,h=20,$fn=20);
    *for(r=[0:45:359]) rotate([0,0,r]) translate([16,0,-.01]) cylinder(d=3,h=20,$fn=20);
  }
}
module ratchet() {
difference(){
  circle(d=80,$fn=80);
  for(r=[0:30:359])
    rotate([0,0,r]) translate([-32,40]) pawl();
}
}

module pawl(t=0)
{
  if(t>0)
  {
    union(){
    difference(){
      linear_extrude(t,convexity=2) {
        pawl();
        translate([5,0]) rotate([0,0,10]) {
          square([20,10]);
          translate([19,6]) rotate([0,0,-10]) {
            translate([0,-10]) difference()
            {
              union() {
                square([26,14]);
                rotate([0,0,13]) square([22,14]);
                translate([20,9]) circle(angle=180,r=10);
              }
              hull() {
              translate([21,-.5]) wedge(angle=180,r=12,$fn=30);
              translate([18,-1]) wedge(angle=180,r=12,$fn=30);
              }
              *translate([20,0]) square([10,11]);
            }
            *polygon([[0,0],[6,0],[26,1],[26,4],[6,4],[0,4]]);
          }
        }
      }
        translate([0,0,-.01]) cylinder(d=6,h=10,$fn=30);
        translate([0,0,t-4]) {
          
          translate([0,0,0.99]) cylinder(d=8.1,h=3.2,$fn=30);
        }
      
      translate([18,4]) {
        translate([0,0,-1]) cylinder(d=9,h=t+2,$fn=40);
        translate([0,0,t/2]) for(r=[0:20]) rotate([0,0,r])  rotate([-90,0]) {
         translate([0,0,-10]) cylinder(d=4,h=30,$fn=12);
         translate([0,0,-10]) cylinder(d=6,h=9,$fn=20);
         *translate([0,0,12+((t-2)/2)]) sphere(d=t-2,$fn=30);
      }
    }
    }
  }
  } else {
  difference(){
    union(){
      //circle(d=20,$fn=40);
      wedge(r=10,a1=90,a2=270,$fn=20);
      
    intersection() {
      translate([5,-29.5]) {
        //circle(d=80,$fn=80);
        wedge(r=40,a1=20,a2=100,$fn=30,sp=[-7,10]);
      }
      translate([0,-10]) square([40,40]);
    }
    //polygon([[0,10],[20,8],[25,7],[30,5],[40,0],[30,-5],[20,0],[0,-10]]);
  }
    //hull()
    {
      translate([20,-23]) {
        //circle(d=40,$fn=60);
        wedge(r=20,$fn=20,a1=50,a2=140);
      }
      *translate([0,-27]) wedge(r=20,$fn=20,a1=50,a2=140);
    }
    polygon([[5,-9],[10,-5.7],[10,-11],[0,-11]]);
    translate([31,-15]) rotate([0,0,9]) square([50,50]);
    circle(d=3.2,$fn=12);
  }
}
}

module servo_horn(d=6,servo_body=1,rot=0)
{
  rotate([0,0,rot]) {
    cylinder(d=7.3,h=d,$fn=30);
      linear_extrude(d-4)
      hull() {
        circle(d=7.3,$fn=30);
        translate([0,12]) circle(d=4,$fn=20);
      }
    *translate([0,12,0]) cylinder(d=4,h=d-4,$fn=30);
    *linear_extrude(d-4) {
      polygon([[-3.5,0],[-2,10+(m?0:2)],[2,10+(m?0:2)],[3.5,0]]);
    }
  }
  if(servo_body)
  {
    rotate([0,0,50]) translate([-6,-6,d]) {
      difference() {
        union() {
          cube([12,22.5,25]);
          translate([0,-4.7,4.3]) cube([12,31.4,2.5]); 
        }
        mirrory(11.25) {
        translate([5,-4.71,4.29]) cube([2,3,3]);
        translate([6,-2.5,4.29]) cylinder(d=3,h=3,$fn=20);
        }
      }
    }
  }
}
module stepper(h=40) {
  difference(){
    translate([-21,-21,-h]) cube([42,42,h]);
    mirrorx() mirrory() translate([-15.5,-15.5,-5]) cylinder(d=3,h=10,$fn=20);
  }
  cylinder(d=5,h=15,$fn=20);
}
module wedge(angle=0,r=1,a1=0,a2=0,sp=[0,0],$fn=20)
{
  //echo(str("arc: ", arc(0,angle,radius,$fn)));
  astart=a1>0?a1:0;
  aend=a2>0?a2:angle;
  $fn=abs(astart-aend)/$fn;
  //echo(str("Angle: ", astart, "-", aend, " $fn=",$fn));
  wpoints=arc(astart,aend,r,$fn);
  //echo(str("arc: ", wpoints));
  polygon(concat([sp],wpoints));
}

function arc(a1,a2,r,$fn) =
  (a1+((a2-a1)/$fn)>=a2?
    [arcpoint(a2,r)] :
    concat([arcpoint(a1,r)],arc(a1+$fn, a2, r, $fn)));
function arcpoint(angle,r) = [r*cos(angle),r*sin(angle)];

module gt2_pulley(teeth,idler=0,retainer=0,base=0)
{
  pulley("GT2 2mm", tooth_spacing (2,0.254,teeth=teeth) , 0.764 , 1.494, 12, idler = idler, retainer = retainer, motor_shaft = 3.2, draw_base = base, teeth=teeth );
}

module mirrory(offset=0)
{
  translate([0,offset,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-1,0]) children();
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}