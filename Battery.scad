if(!part) {
part="pack";
battery_type="AA";
cols=4;

size_18650=[18,65];
size_aa=[14.5,50.5];
size_aaa=[10.5,44.5];
batsize=battery_type=="aaa"?size_aaa:(battery_type=="AA"?size_aa:size_18650);

if(part=="pack"||part=="all")
  pack(cols,battery_type);
if(part=="cap"||part=="all")
  rotate([part=="cap"?180:0,0]) cap(cols,battery_type);
if(part=="both")
{
  mirror([0,1]) mirror([1,0]) translate([5,0,battery_width(battery_type)+4]) rotate([180,0]) cap(cols,battery_type);
  translate([0,0]) pack(cols,battery_type);
}
}

module cap(cols,battery_type="18650") {
  dx=battery_width(battery_type)+1;
  dy=battery_length(battery_type)+10;
  dz=battery_width(battery_type)+2;
  difference(){
    intersection() {
      translate([-4,-4,dz-5.5]) cube([10+cols*dx,dy+8,10]);
      union() {
        translate([0,0,dz+.4]) cube([2+cols*dx,dy,1.6]);
        *mirrory(dy/2) translate([1,-2,dz-8]) cube([6+cols*dx,1.2,10]);
        mirrorx((cols*dx+2)/2) {
          translate([2,3.5,dz-8]) cube([dx*cols/2,dy-7,10]);
          mirrory(dy/2) translate([2.5,10.4,dz-4.5]) rotate([-90,0]) cylinder(d=3.8,h=8.4,$fn=30);
        }
        translate([2,1.5,dz-3.2]) cube([dx*cols-2,dy-3,4.5]);
        *for(x=[0:cols-1])
  translate([1+dx/2+dx*x,3,dz/2]) {
    rotate([-90,0]) translate([-4,dx/-2-2,-1.5]) cube([8,5,dy-3]);
  }
      }
    }
  for(x=[0:cols-1])
  translate([1+dx/2+dx*x,3,dz/2]) {
    rotate([-90,0]) cylinder(d=dx,h=dy-6,$fn=40);
  }
  }
}
module pack(cols=4,battery_type="18650") {
dx=battery_width(battery_type)+1;
dy=battery_length(battery_type)+10;
dz=battery_width(battery_type)+2;
difference(){
  cube([2+cols*dx,dy,dz]);
  for(x=[0:cols-1])
  translate([1+dx/2+dx*x,3,dz/2]) {
    rotate([-90,0]) battery(battery_type);
  }
  mirrorx((2+cols*dx)/2) mirrory(dy/2) translate([2.5,10,dz-4]) rotate([-90,0]) cylinder(d=4,h=10,$fn=30);
  translate([2,3,10]) cube([dx*cols-2,dy-6,dz]);
  translate([1.3,1.3,dz-5.99]) cube([dx*cols-.55,dy-2.6,6]);
}
}

function battery_length(type="18650") = (type=="18650"?65:(type=="AA"?50.5:(type=="AAA"?44.5:0)));
function battery_width(type="18650") = (type=="18650"?18:(type=="AA"?14.5:(type=="AAA"?10.5:0)));
module battery(type="18650",neg=1,top=0,side=0)
{
  noff=neg?4:0;
  dia=battery_width(type);
  length=battery_length(type);
  //if(type=="18650")
    {
    difference() {
      union() {
        cylinder(d=dia+(neg?0.5:0),h=length+noff,$fn=40);
        translate([dia*-.5-(neg?0.25:0),-11]) cube([dia+(neg?0.5:0),11,length+noff]);
        if(neg)
        {
          for(m=[0,1]) translate([0,0,m?length+noff:0]) mirror([0,0,m]) {
            rotate([0,0,m&&side?90*side:0])
              terminal_slot(top);
          }
        } else
        translate([0,0,length-.01+noff]) cylinder(d=dia/3,h=1.4,$fn=20);
      }
      mirrorz((length+noff)/2) translate([0,0,-3]) scale([1,1,0.5]) sphere(d=dia*.5,$fn=30);
    }
  }
}
module terminal_slot(top=0)
{
  translate([-5,-10.02,-1.7]) cube([10,17,1]);
  if(top)
    translate([-5.5,-6,-1.7]) cube([11.02,4,1]);
  translate([0,0,-.71]) {
    cylinder(d=8,h=2.02,$fn=30);
    translate([-4,-10.01]) cube([8,10,2.02]);
    translate([-5,-14.01]) cube([10,14,2.02]);
    translate([-8,-18,-1]) cube([16,14,2.02]);
  }
  translate([-3,1,-1.7]) cube([6,10,1]);
  translate([-1,-5,-1.2]) cube([2,10,2]);
  *translate([-3,8.01,-3.01]) cube([6,2,37.52]);
}

module mirrorz(offset=0)
{
  translate([0,0,offset]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,offset*-1]) children();
}
module mirrory(offset=0)
{
  translate([0,offset,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-1,0]) children();
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}