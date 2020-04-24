// ball joint diameter
bjd=25.4*(3/4);
// ball joint height
bjh=25.4*(9/16);
// ball joint thickness
bjt=1.8;
// ball clearance
bcl=0.2;
// claw split
csp=6;
dips=2;
neck=1;

bjnd=bjd-10;
ncone=6; //bjd<30?10:20;

/*
mirror([0,0,1])
balljoint(bjd,bjh,bjt,1);
/*/
!balljoint(bjd,bjh,bjt,hole=1,part1="base");
translate([0,0,bjh]) rotate([20,0]) balljoint(bjd,bjh,bjt);
translate([0,0,bjh]) rotate([20,0]) translate([0,0,bjh]) rotate([20,0]) balljoint(bjd,bjh-10,bjt,hole=0,part1="female",part2="clip");
*mirror([0,0,1]) balljoint(bjd,bjh,bjt,hole=0);
//*/


module balljoint(bd=30,h=30,thick=3,hole=1,part1="female",part2="male",bjnd=bjnd,ncone=ncone,dips=dips)
{
  echo(str(part1,"/",part2," BD:",bd," H:",h," Neck:",bjnd," Cone:",ncone));
  difference() {
    union() {
      if(part1=="female")
        difference() {
          union() {
            sphere(d=bd,$fn=50);
            translate([0,0,-neck]) cylinder(d=bd,$fn=50,h=neck);
            translate([0,0,-neck]) sphere(d=bd,$fn=50);
          }
          translate([bd*-.5,bd*-.5,bd*-.9-neck]) cube([bd,bd,bd*.75]);
          *mirror([0,0,1]) translate([0,0,neck]) cylinder(d1=bd-thick*2-2,d2=bd-thick*2+3,h=8,$fn=50);
        }
      else if(part1=="base")
      {
        translate([bd*-1.2,bd*-.45,0]) cube([bd*2.4,bd*.9,bd*.4]);
      }
      cylinder(d=bjnd,h=h,$fn=40);
      translate([0,0,bd*.25]) cylinder(d2=bjnd,d1=bd*.86,h=ncone,$fn=50);
      if(part2=="male") {
        intersection() {
          union() {
      translate([0,0,h]) sphere(d=bd-thick*2-bcl*0,$fn=50);
        translate([0,0,h]) sphere(d=bd-thick*2-bcl*-2,$fn=12);
          }
          translate([bd*-.5,bd*-.5,h-bd*.5]) cube([bd,bd,bd-4]);
        }
      } else if(part2=="clip") {
        translate([0,0,h]) difference() {
          union() {
            cylinder(d=bjnd,h=8,$fn=50);
            translate([0,0,8]) cylinder(d1=bjnd,d2=8,h=2,$fn=30);
          }
        }
        *translate([-2,-2,h]) cube([4,4,20]);
      }
    }
    if(part2=="male") {
    for(r=[15:360/12:360],z=[0,bd*-.2]) rotate([0,0,r]) translate([bd/2-thick-abs(z)/4,0,h+z]) sphere(d=dips,$fn=10);
    }
    if(part1=="female")
    {
      difference() {
        union(){
          sphere(d=bd-thick*2+.4,$fn=50);
          translate([0,0,-neck-4]) cylinder(d=bd-thick*2+.4,$fn=50,h=neck+4);
          translate([0,0,-neck]) sphere(d=bd-thick*2+.4,$fn=50);
        }
        for(r=[360/csp/2:360/csp:360],z=[-1.8-neck]) rotate([0,0,r]) translate([bd/2-thick+.25,0,z]) sphere(d=dips,$fn=10);
      }
      for(r=[0:360/csp:360]) rotate([0,0,r]) translate([0,-.5,-neck+1]) mirror([0,0,1]) cube([bd/2-1,1,3+neck]);
      } else if(part1=="base") {
        for(x=[bd*-.85,bd*.85]) translate([x,0,-1]) {
          cylinder(d=4,h=bd*.5,$fn=40);
          translate([0,0,bd*.3+1.01]) cylinder(d1=4,d2=8,h=bd*.1,$fn=40);
        }
      }
    if(hole) {
     cylinder(d=bjnd-thick*2,h=h+bd,$fn=40);
      translate([0,0,h+bd*.1]) cylinder(d1=bjnd-thick*2,d2=bjnd-2,h=bd*.2+.1,$fn=30);
    }
    if(part2=="clip") {
      translate([bd*-.5,0,h+5]) rotate([0,90,0]) cylinder(d=3,h=bd/2,$fn=20);
      translate([0,0,h-10]) cylinder(d=5,h=20.02,$fn=40);
      translate([0,0,0]) cylinder(d1=bd-bjt*2,d2=5,h=(bd/2)+1,$fn=40);
    }
    if(part1!="base"&&part2=="male")
      translate([bd*-.5,bd*-.5,h+bd*.35+(part1=="base"?1:-1)]) cube([bd,bd,bd*.15]);
  }
}