din1=5;
din2=5;
unit_type="mm";
t1="";//str(din1);
t2="";//str(din2);
dist=55;
type1="open";
type2="closed";
p2=2;
dmm1=hex_head_diameter(din1);
dmm2=hex_head_diameter(din2);
echo(str("Sizes(mm): ",dmm1," : ",dmm2));
!for(h=[3:5],x=[0:4],y=[0:3])
  translate([x*10+(h-3)*50,y*10]) difference() {
    union(){
    circle(d=hex_head_diameter(h)+.1,$fn=6);
    if(x>3)
      rotate([0,0,30]) circle(d=hex_head_diameter(h)+.1,$fn=6);
  }
    circle(d=h,$fn=10+h*5);
  }
!difference()
{
  standard_wrench(d1=dmm1,d2=dmm2,l=dist);
  //*
  translate([t2!=""?12:dist/2,0]) rotate([0,0,0]) text(t1,size=3,halign="left",valign="center");
  if(t2!="")
    translate([dist-12,0]) rotate([0,0,180]) text(t2,size=3,halign="left",valign="center");
  //*/ 
}

module standard_wrench(d1=15,d2=20,l=60)
{
  %circle(d=dmm1-.2,$fn=6);
  difference() {
    union() {
        translate([d1/6,0]) circle(d=d1*1.5,$fn=36);
      hullkids() {
        translate([d1/2,0]) circle(d=max(d1,d2,10)*.5,$fn=36);
        translate([l-d2/2,0]) circle(d=max(d1,d2,10)*.5,$fn=36);
      }
        translate([l-(type2=="closed"?0:d2/6),0]) circle(d=d2*1.5,$fn=36);
      
    }
    y1=sin(60)*d1;
    circle(d=d1,$fn=6);
    translate([-d1,-y1/2]) square([d1,y1]);
    translate([sin(30)*d1*-.5-1,d1*-1]) mirror([1,0]) square([20,d1*2]);
    y2=sin(60)*d2;
    translate([l,0]) mirror([1,0]) {
      for(r=[0:p2-1]) rotate([0,0,30*r])
        circle(d=d2,$fn=6);
    if(type2!="closed") {
      translate([-d2,-y2/2]) square([d2,y2]);
      translate([sin(30)*d2*-.5-1,d2*-1]) mirror([1,0]) square([20,d2*2]);
    }
    }
  }
}
*translate([20,-3]) cube([6,6,40]);
*translate([15,-3,8]) rotate([-90,0]) difference() {
  cube([5,5,6]);
  translate([0,0,-.1]) cylinder(r=5,h=6.2,$fn=30);
}
translate([24,-6]) 
//translate([12.5,-6,-.5]) translate([5,0,4]) rotate([0,-0]) translate([-5,0,-4])
difference() {
  cube([50,12,8]);
  translate([-.1,2.8,-.1]) cube([10,6.4,10]);
  translate([5,-.1,4]) rotate([-90,0]) cylinder(d=3,h=13,$fn=20);
}
translate([14,-3]) difference() {
  hull() {
    cube([5,6,8]);
    cube([8,6,5]);
    translate([-4,0]) cube([3,6,3]);
  }
  translate([3,-.1,4]) rotate([-90,0]) cylinder(d=3,h=8,$fn=20);
}
difference() {
linear_extrude(3,convexity=3) {
  intersection(){
    *translate([-2,-10]) square([100,20]);
  difference() {
  union() {
    rotate([0,0,30]) circle(d=15+3.6,$fn=12);
    translate([0,-3]) square([14,6]);
    *translate([50,0]) rotate([0,0,0]) intersection() {
      hex(21.6,0);
      *translate([-10,-10]) square([13.6,20]);
    }
  }
  hex();
  translate([50,0]) hex(15,0);
}
}
}
  translate([-10,-10,3]) rotate([0,-15]) cube(20);
}
module hullkids() {
  for(a=[0:$children-2])
    hull() {
      children(a);
      children(a+1);
    }
}
module hex(d=15,x2=0)
{
  circle(d=d,$fn=6);
  if(x2)
  rotate([0,0,30]) circle(d=d,$fn=6);
}
function mm2in(mm) = mm / 25.4;
function in2mm(in) = 25.4*in;
function flat_to_across(dflat) = dflat/2/sin(30);
function wrench_size(bolt_size) = bolt_size + 3/16;
function inches(in) = in2mm(in);

function hex_head_diameter(bolt_diameter) = bolt_diameter==3?6.4:(bolt_diameter==4?8:((bolt_diameter==5?9.1:((bolt_diameter*(bolt_diameter<inches(5/16)?1.75:(bolt_diameter<inches(3/8)?1.6:1.5)))/cos(30)))));
