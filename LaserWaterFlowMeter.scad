part="therm";
arms=6;
kerf=0.1;

$fn=60;
th=inches(2.2);
tw=inches(2.2);
mirrorout=1;
inletx=[inches(1/8)];
spinoffy=0;

if(part=="washer") !linear_extrude(1.2) difference() { circle(d=6,$fn=36); circle(d=3.3,$fn=22); }


cutoutx=[
  inches(1/8)//,inches(11/16)
  //,inches(2)-inches(3/4)
  ];
if(part=="ends")
  union() {
    part2d("bottom");
    translate([th+.2,0]) part2d("top");
  }
else if(part=="ends2")
  linear_extrude(1.2)
    part2d("ends2");
else if(part=="spinner3d")
{
  linear_extrude(6)
    part2d("spinner");
  for(r=[0:360/arms:359]) rotate([0,0,r]) translate([inches(1.5)/2-3,0]) difference() {
      cylinder(d=4.8,h=3);
      translate([0,0,3]) sphere(d=3.2,$fn=24);
    }
  translate([0,0,6]) linear_extrude(.4) difference() { circle(d=6); circle(d=3.4); }
}
else if(part=="therm")
{
  thermister();
}
else if(part!="3d")
  part2d(part);
else
union() {
  linear_extrude(inches(1/8)) part2d("bottom");
  translate([0,0,inches(1/8)]) linear_extrude(inches(1/4)) part2d("middle");
  #translate([0,0,inches(3/8)]) linear_extrude(inches(1/8)) part2d("top");
}

module thermister() {
  difference() {
    union() {
      translate([-10,-16]) rsquare([20,32]);
      translate([-20,-5]) square([40,10]);
    }
    for(x=[-7,7],y=[-13,13]) translate([x,y])
      circle(d=3,$fn=20);
    translate([-2.5,-13]) square([5,26]);
    hull() {
      translate([-2.5,-8]) square([5,16]);
      translate([-6,-3]) rsquare([12,6]);
    }
  }
}

module part2d(part="middle") {
if(part!="spinner") difference() {
  union() {
    square([tw,th]);
    if(part=="middle")
      translate([tw/2,0]) for(ym=[0]) mirror([ym,0]) translate([tw/-2,0])
      translate([0,th/2]) for(m=mirrorout?[0,1]:[0]) mirror([0,m]) translate([0,inches(-1)])
    for(x=inletx,y=[inches(-1/4)]) translate([x,y]) {
    translate([inches(5/32),inches(-1/4)]) {
      square([inches(7/16),inches(1/2)]);
    }
  //  translate([inches(4/16),0]) square([inches(1/8),th/2]);
    }
  }
  if(part=="middle")
  {
    *translate([tw/2,0]) for(ym=[0,1]) mirror([ym,0]) translate([tw/-2,0])
  translate([0,th/2]) for(m=mirrorout?[0,1]:[0]) mirror([0,m]) translate([0,th*-.5])
    for(x=inletx,y=[inches(-1/4)])
    translate([x+inches(3/16)+inches(1/16),10]) square([inches(1/4),20]);
  }
  if(part=="ends2")
    translate([tw/2,th/2]) circle(d=inches(1.5)+.4,$fn=100);
  else {
    translate([tw/2,th/2]) circle(d=part=="middle"?inches(1.5)-.1:3,$fn=100);
  }
  for(pos=[[4,4],[4,th/2-8],[4,th/2+8],[4,th-4],
      [tw-4,4],[tw-4,th/2-8],[tw-4,th/2+8],[tw-4,th-4],
      [tw/2-8,4],[tw/2+8,4],
      [tw/2-8,th-4],[tw/2+8,th-4],
    ]
    ) translate(pos) circle(d=3,$fn=20);
  //for(x=cutoutx,y=[th-inches(1/4)+.02]) translate([x,y]) cutpath(0,part);
  if(part=="middle")
  {
    if(mirrorout)
      translate([-.01,th/2-2.4]) {
        square([3,4.8]);
        *translate([5,0]) square([5,4.8]);
      }
    else
      translate([tw/2-2.6,th-.1]) square([5.2,th/2]);
  }
}
if(part=="middle")
{
  translate([tw/2,th/2]) spinner2d();
  *translate([4,-20])
  difference() {
    for(x=[cutoutx[0]],y=[th-(inches(1/4))+.02]) translate([x,y]) cutpath(kerf,part);
    translate([tw,th]) circle(d=inches(1.5)+.2,$fn=100);
  }
  if(len(cutoutx)>1)
  translate([-4,-20])
  difference() {
    for(x=[cutoutx[1]],y=[th-(inches(1/4))+.02]) translate([x,y]) cutpath(kerf,part);
    translate([tw,th]) circle(d=inches(1.5)+.2,$fn=100);
  }

}
if(part=="spinner")
  //translate([tw,th]) rotate([0,0,360/arms/2])
  {
    *circle(d=3);
    spinner2d();
  }
}


module spinner2d() {
  difference() {
    union() {
      circle(d=18,$fn=60);
      for(r=[0:360/arms:359]) {
        //hull()
        {
          for(r2=[-10:10])
            rotate([0,0,r+r2]) translate([inches(1.5)/2-1.2,0]) circle(d=2);
        }
        rotate([0,0,r]) {
          union() {
            hull() {
              translate([3,spinoffy]) circle(d=2.9);
              translate([inches(1.5)/2-3,0]) circle(d=5.6);
            }
            translate([inches(1.5)/2-3,0]) 
              circle(d=4.8);
          }
        }      
      }
    }
    for(r=[0:360/arms:359]) rotate([0,0,r]) translate([inches(1.5)/2-3,0]) circle(d=3);
    circle(d=3.4,$fn=40);
  }
}

module cutpath(kerf=0,part=part) {
  difference() {
    if(part=="middle")
    union() {
    translate([inches(3/16)-kerf,-kerf-.01])
      square([inches(1/4)+kerf*2,inches(1/4)+kerf*2]);
    translate([inches(4/16)-kerf,inches(-1/4)]) square([inches(1/8)+kerf*2,inches(1/4)+10.01]);
    }
    if(kerf>0 || part!="middle")
        translate([inches(3/16)-kerf,-.01]) translate([inches(1/8)+kerf,inches(1/8)]) circle(d=3);
  }
}

module rsquare(dims,r=2)
{
  for(x=[r,dims[0]-r],y=[r,dims[1]-r])
    translate([x,y]) circle(r=r);
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
}

function inches(in) = 25.4 * in;