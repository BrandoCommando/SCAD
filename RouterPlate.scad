part="all"; // [all:Preview all parts,mount:Router Mount,plate:Table Plate]
tw=86;
hd=42;
mount_h1=6;
plate_offset=40;
ledge=7.6;
platethick=2.6;
plate_inset=1;
neckthick=6;
neckd=26;
mount_nut=0; // [0:None,1:Hex 3mm nut,2:Square 3mm nut]
mount_nut_h=2.4;

*plate_profile();
if(part=="plate"||part=="all")
  translate([0,0,-1]) plate();
if(part=="mount"||part=="all")
  mount();
module plate_profile() {
  difference() {
  union() {
    //difference() {
    *for(r=[0:90:359]) rotate([0,0,r]) translate([tw/-2,tw/-2]) square([ledge,tw]);
    difference(){
      translate([tw/-2,tw/-2-15]) rsquare([tw,tw+15],r=5);
      translate([tw/-2+ledge-.2,tw/-2+ledge]) rsquare([tw-ledge*2,tw-ledge*2],r=5);
      translate([tw/-2-ledge+15,tw/-2-ledge]) {
        rsquare([tw-ledge*2,40],r=15,$fn=45);
      }
    }
    //}
    translate([tw/-2,tw/-2-25]) difference() {
      union(){
        translate([0,10]) square([tw,5],10,$fn=40);
        translate([10,0]) square([tw-20,10]);
        for(x=[10,tw-10]) translate([x,10])  circle(r=10,$fn=30);
      translate([0,10]) square([tw,5]);
      }
    }
    circle(d=hd,$fn=48);
    for(r=[45:90:359]) rotate([0,0,r]) translate([45,0]) circle(d=3,$fn=20);
  }
        translate([tw/-2,tw/-2-25]) for(x=[10,tw/2,tw-10]) translate([x,10]) circle(d=3,$fn=20);
        }
}
module plate() {
  for(r=[0]) rotate([0,0,r]) translate([tw/-2,tw/-2-plate_offset,-platethick-neckthick])
  {
    translate([0,0,0])
    difference() {
      cube2([tw,1+plate_offset,platethick],5,c2=0,c3=0);
      for(x=[tw/2]) translate([x,5,-.01]) {
        cylinder(d=3,h=platethick+1,$fn=20);
        cylinder(d1=6,d2=3,h=2,$fn=20);
      }
    }
  }
  difference() {
    translate([tw/-2+ledge,tw/-2-ledge,-platethick-neckthick]) 
    {
      translate([0,8+ledge,platethick-.01]) cube2([tw-ledge*2,tw-15,neckthick+.02],r=5,c1=0,c4=0);
      translate([0,-1*(plate_offset-20),platethick-.01]) cube2([tw-ledge*2,10+plate_offset,neckthick],r=15,c2=0,c3=0,$fn=50);
      translate([-ledge,0]) cube2([tw,tw+15,platethick+.02],r=5,c1=0,c4=0);
    }
    *for(r=[0:90:359]) rotate([0,0,r]) translate([tw/-2-.1,tw/-2-.1,-5]) cube([7.6,tw+.2,6]);
    translate([0,0,-1-platethick-neckthick]) cylinder(d=neckd,h=platethick+neckthick+2,$fn=80);
    for(r=[45:90:359]) rotate([0,0,r]) translate([45,0,-.01-platethick-neckthick]) {
      cylinder(d=6,h=plate_inset,$fn=30);
      translate([0,0,plate_inset]) cylinder(d1=6,d2=3.6,h=3,$fn=30);
      cylinder(d=3.6,h=platethick+neckthick+2,$fn=20);
    }
  }
}
module rsquare(dims,r=1,c1=1,c2=1,c3=1,c4=1,$fn=20)
{
  hull() {
    translate([r,r]) {
      if(c1) circle(r=r,$fn=$fn);
      else rotate([0,0,180]) square([r,r]);
    }
    translate([r,dims[1]-r]) {
      if(c2) circle(r=r,$fn=$fn);
      else rotate([0,0,90]) square([r,r]);
    }
    translate([dims[0]-r,dims[1]-r]) {
      if(c3) circle(r=r,$fn=$fn);
      else square([r,r]);
    }
    translate([dims[0]-r,r]) {
      if(c4) circle(r=r,$fn=$fn);
      else rotate([0,0,-90]) square([r,r]);
    }
  }
}

module mount(h1=mount_h1) {
difference() {
  union() {
    translate([-36,-36]) cube2([72,72,h1],r=5);
    *translate([-43,-43]) cube([tw,tw,25.4/16]);
    translate([-8,-36,20]) cube([16,72,20]);
    for(m=[0,1]) mirror([0,m]) intersection(){
      translate([-8,-32,12]) rotate([30,0]) cube([16,20,20]);
      translate([-8,-36,12]) cube(20);
    }
    translate([0,0,h1]) {
      cylinder(d=67,h=40-h1,$fn=120);
      difference(){
        cylinder(d=72,h=10,$fn=120);
        rotate_extrude($fn=120) {
          translate([38,10]) circle(r=5,$fn=30);
        }
      }
      scale([.9,1]) {
      translate([0,0,5]) cylinder(d1=72,d2=66,h=10,$fn=100);
      }
    }
    translate([0,0,h1-2]) intersection() {
      translate([-36,-36]) cube([72,72,6]);
      rotate_extrude($fn=80) {
      translate([40,6]) difference() {
        translate([-4,-4]) square([4,4]);
        circle(r=4,$fn=28);
      }
    }
    }
  }
  *for(r=[0]) rotate([0,0,r])
  translate([0,-18,-.01]) cube([40,36,20.01]);
  for(r=[45:90:359]) rotate([0,0,r]) translate([45,0,-1])
  {
    cylinder(d=3,h=h1+1.1,$fn=20);
    translate([0,0,h1+1.01-mount_nut_h])
      if(mount_nut==1)
        rotate([0,0,30]) cylinder(d=7.2,h=mount_nut_h,$fn=6);
      else if(mount_nut==2)
        rotate([0,0,45]) translate([-3.1,-3.1]) cube([6.2,6.2,mount_nut_h]);
  }
  translate([0,-36.01,30]) rotate([-90,0]) {
    cylinder(d=3,h=72.02,$fn=20);
    *translate([0,0,2]) rotate([0,0,30]) cylinder(d=7.1,h=68,$fn=6);
  }
  translate([0,0,-.01]) cylinder(d=54,h=22.02,$fn=80);
  difference() {
    translate([0,0,22]) linear_extrude(50) intersection() {
      circle(d=64.6,$fn=100);
      translate([-32.3,-30.9]) square([64.6,61.8]);
    }
    translate([0,0,25.01])
      rotate_extrude($fn=80) {
        translate([29.5,0]) intersection() {
          translate([0,-3]) square([3,3]);
          difference() {
            translate([-3,-3]) square([6,6]);
            circle(d=6,$fn=30);
          }
        }
      }
  }
}
}
module cube2(dims,r=1,c1=1,c2=2,c3=3,c4=4,$fn=20)
{
  echo(str("dims:",dims));
  linear_extrude(dims[2],convexity=5) rsquare([dims[0],dims[1]],r=r,c1=c1,c2=c2,c3=c3,c4=c4,$fn=$fn);
}