part="plates";
num_spokes=10;
outer_diameter=80;
wheel_width=25;
spoke_diameter=3;

nut_radius=5.5 /2 / cos(30) + 0.5;

spoke_length=sqrt(2*pow(wheel_width,2));
echo(str("Spoke Length: ",spoke_length," Nut Radius: ",nut_radius));

if(part=="plates")
  inside_plate();
if(part=="bones")
for(x=[0:10:50]) translate([x,0]) linear_extrude(23) difference() {
  circle(d=3.2+2.38*2,$fn=40);
  circle(d=3.2,$fn=20);
}

if(part=="yermom")
  difference() {
    for(x=[0:22:88],y=[0,22]) translate([x,y]) circle(d=23.98,h=6,$fn=60);
    for(x=[0:22:88],y=[0,22]) translate([x,y]) difference() {
      translate([0,0]) circle(d=20.2,h=6.02,$fn=50);
      translate([0,0]) circle(d=3.2,h=10,$fn=20);
    }
  }
if(part=="biggin")
union() {
  difference() {
    translate([0,0,0]) cylinder(d=20,h=spoke_length,$fn=50);
    translate([0,0,-.01]) scale(1.01) spoke_skin();
    translate([0,0,-.01]) cylinder(d=3.2,h=spoke_length+2.02,$fn=20);
    translate([0,0,-2.01]) cylinder(d1=20-2.38*2,d2=12,h=2.02,$fn=50);
  }
  translate([0,20]) {
    difference() {
      cylinder(d1=9.4,d2=5,h=4,$fn=80);
      translate([0,0,-.01]) cylinder(d=3.2,h=20,$fn=20);
    }
    difference(){
      cylinder(d=20,h=5,$fn=50);
      translate([0,0,-.01]) cylinder(d1=12,d2=20-2.38*2,h=4.02,$fn=50);
      translate([0,0,-.01]) cylinder(d=3.2,h=20,$fn=20);
      translate([5,0,4]) cylinder(d=5,h=6,$fn=30);
    }
  }
  translate([44,0]) linear_extrude(1) difference() {
    circle(d=20,$fn=50);
    circle(d=3.2,$fn=20);
  }
  translate([22,0]) difference() {
    translate([0,0,-2]) {
      cylinder(d2=20-2.38*2,d1=12,h=2,$fn=50);
      translate([0,0,2]) cylinder(d=20,h=6,$fn=50);
    }
    translate([0,0,-2.01]) cylinder(d=3.2,h=4.02,$fn=20);
    translate([0,0,2]) cylinder(d=6,h=5.02,$fn=40);
  }
}

module spoke_bone(extra=0)
{
  boned=12;
  *%import("MecanumWheel_FullNub.stl");
  difference() {
    translate([0,0,-extra]) union() {
      scale([0.75,0.75,1]) import("MecanumWheel_FullNub.stl");
      *cylinder(d=boned,h=spoke_length+extra*2,$fn=40);
      *translate([0,-1.22]) cube([4.5,1.22*2,spoke_length+extra*2]);
    }
    for(r=[0:45:360]) rotate([0,0,r]) translate([boned/2,0,-.01]) cylinder(d=2,h=spoke_length+.02+extra*2,$fn=20);
    translate([0,0,-.01]) cylinder(d=3,h=spoke_length+.02+extra*2,$fn=20);
  }
}
module spoke_skin()
{
  difference() {
    import("MecanumWheel_FullNub.stl");
    translate([0,0,-.01]) spoke_bone(.1);
  }
}
module inside_plate()
{
  //%spokes() translate([0,0,5]) import("MecanumWheel_FullNub.stl");
  difference() {
    union() {
      mirrorz(8)
        translate([0,0,wheel_width*-.5-3]) rotate_extrude($fn=100) {
          square([outer_diameter/2,6]);
          intersection(){
            square([outer_diameter/2+6,10]);
            translate([outer_diameter/2,3]) circle(r=5,$fn=40);
          }
        }
        *translate([0,0,wheel_width*.5]) cylinder(d=18,h=6.03,$fn=40);
      //translate([0,0,wheel_width*-.5+4.99]) cylinder(d=outer_diameter-wheel_width,h=
    }
    translate([0,0,wheel_width*-.5-5.01]) cylinder(d=8,h=wheel_width+11.9,$fn=40);
    translate([0,0,wheel_width*-.5]) cylinder(d=14.8,h=6,$fn=6);
    translate([0,0,wheel_width*.5+4]) {
      *cylinder(d1=8,d2=14.8,h=3.02,$fn=6);
      translate([0,0,3]) cylinder(d=14.8,h=6,$fn=6);
    }
    for(r=[0:5]) rotate([0,0,r*(360/6)+30]) translate([12,0,-wheel_width/2-5.01]) cylinder(d=3,h=140,$fn=20);
    spokes() {
      //translate([0,0,5]) scale([1.2,1.2,1]) import("MecanumWheel_FullNub.stl");
      
      mirrorz(spoke_length+10) translate([0,0,5]) cylinder(d1=16,d2=18,h=4,$fn=40);
      mirrorz(spoke_length+10) translate([0,0,8.99]) cylinder(d1=18,d2=22,h=10,$fn=40);
      translate([0,0,-6]) cylinder(d=spoke_diameter+.02,h=spoke_length+18,$fn=20);
      //*mirrorz(spoke_length+10) translate([0,0,-10]) cylinder(d=6,h=8,$fn=30);
      //*translate([0,0,spoke_length+10]) cylinder(d=7.1, h=20,$fn=6);
    }
  }
  spokes() {
    mirrorz(spoke_length+10) translate([0,0,-2]) difference() {
      union(){
        cylinder(d1=spoke_diameter+0.84,d2=spoke_diameter+1.61*2,h=2,$fn=30);
        translate([0,0,2]) cylinder(d=spoke_diameter+1.61*2,h=5.4,$fn=30);
      }
      translate([0,0,-.01]) cylinder(d=spoke_diameter+.01,h=8.02,$fn=20);
    }
  }
}
module spokes() {
  for(spoke_num=[0:num_spokes-1])
  {
    rotate([0,0,spoke_num*(360/num_spokes)])
      translate([outer_diameter/2,0]) rotate([0,0,-5.5]) rotate([45,0]) translate([0,0,spoke_length*-.5]) {
        
        if($children>0)
          children();
        else
          cylinder(d=spoke_diameter,h=spoke_length,$fn=20);
      }
  }
}

module mirrorx(off=0)
{
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off=0)
{
  translate([0,off/2,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,off/-2,0]) children();
}
module mirrorz(off=0)
{
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/-2]) children();
}
module rsquare(dims,r=5,center=false,$fn=30)
{
  translate(center?[dims[0]/-2,dims[1]/-2]:[0,0])
  hull() for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=$fn);
}
module rcube(dims,r=5,$fn=30)
{
  linear_extrude(dims[2],convexity=3) {
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=$fn);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
  }
}
module cube2(dims,r=5,$fn=30)
{
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r,$fn=$fn);
  }
}

function inches(in) = 25.4 * in;