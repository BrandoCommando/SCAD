count=6;
bottom_rack=0;
spacex=25;
th=35;
height=6;
bigd=16;
smalld=12;
walld=25.4;
thinnest=7;
thindist=walld-6;
tw=spacex*(count-1)+bigd;
holes=3;
echo(str("Total Width: ",tw));

rotate([0,0,90]) difference(){union(){
  translate([tw/-2,walld-3]) {
    difference() {
      translate([0,3,0]) rotate([90,0]) linear_extrude(3) {
        translate([5,0]) square([tw-10,th]);
        square([tw,th-5]);
        translate([5,th-5]) circle(r=5,$fn=30);
        translate([tw-5,th-5]) circle(r=5,$fn=30);
      }
      for(x=[0:holes-1]) translate([10+(x*((tw-20)/(holes-1))),-.01,th-10]) rotate([-90,0]) {
        cylinder(d=4,h=5,$fn=20);
        translate([0,0,-.01]) cylinder(d1=8,d2=4,h=2,$fn=40);
      }
    }
    if(bottom_rack) {
    translate([0,walld*-1+bigd/2-1,th-3]) cube([tw,walld-bigd/2+1,3]);
    translate([bigd/2,walld*-1+2-bigd/2,th-3]) cube([tw-bigd,bigd,3]);
    }
  }
  translate([tw/-2+bigd/2,0])
  for(x=[0:count-1]) translate([spacex*x,0]) {
    intersection(){
      union(){
        translate([0,-3]) grabber(height*4);
        *translate([-6,walld]) difference() {
          translate([0,-4]) rounded_cube([12,12,50]);
          for(z=[4,45])
          translate([-1,1,z]) rotate([0,90,0]) linear_extrude(13.02) translate([0,1]) {
            //hull() {
              circle(d=6.8,$fn=20);
              //rotate([0,0,180]) translate([2,0]) circle(d=4,$fn=20);
            //}
          }
        }
      }
      union(){
        *translate([-6,walld-4]) cube([12,12,50]);
        translate([-10,-10]) cube([20,40,height]);
        translate([-10,6]) rotate([25,0]) translate([0,0,height]) mirror([0,0,1]) cube([20,40,20]);
      }
    }
  if(bottom_rack)
    translate([0,0,th-4]) {
      cylinder(d1=bigd,d2=bigd+2,h=1,$fn=40);
      translate([0,0,1])
        cylinder(d=bigd+2,h=3,$fn=40);
    }
  }
}
  *translate([tw/-2+6.5,0])
  for(x=[0:count-1]) translate([spacex*x,0,-.01]) {
    cylinder(d=smalld,h=th-2.99,$fn=20);
    translate([0,0,th-3]) cylinder(d1=smalld,d2=1,h=2,$fn=20);
  }
}


module grabber(height=height,walld=walld){
  difference() { union() {
difference(){
  union(){
    rotate([0,0,30-90]) rotate_extrude(angle=300,$fn=40) square([bigd/2,height]);
    *cylinder(d=bigd,h=height,$fn=40);
    intersection() {
      linear_extrude(height,convexity=3) hull() {
        translate([0,thindist]) circle(d=thinnest);
        translate([0,walld]) circle(d=bigd);
      }
      translate([bigd/-2,0]) cube([bigd,walld,height]);
      
    }
    intersection() {
      linear_extrude(height,convexity=3) hull() {
        circle(d=bigd);
        translate([0,thindist]) circle(d=thinnest);
      }
      translate([bigd/-2,0]) cube([bigd,walld,height]);
    }
  }
  for(m=[0:1]) mirror([m,0])
  translate([thinnest/2+2.5,thindist]) cylinder(d=5,h=height+.02,$fn=20);
  translate([0,0,-.01]) cylinder(d=smalld,h=height+.02,$fn=20);
  translate([smalld*-.25,-6,-.01]) cube([smalld/2,6,height+.02]);
  translate([smalld*-.1,0,-.01]) cube([smalld*.2,walld-3.5,height+.02]);
}
for(m=[0,1]) mirror([m,0])
translate([4.5,-3.55]) rotate([0,0,45+90]) rotate_extrude(angle=130,$fn=30) {
  translate([2,0]) square([(bigd-smalld)/2-.5,height]);
}
}
  translate([0,0,-.01]) cylinder(d=smalld,h=height+.02,$fn=smalld*3);
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