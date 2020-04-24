rotate([0,90])
{
  bottom();
  *top();
}
module top() {
  intersection() {
    shelf_bracket();
    translate([-1,0,41]) {
      cube([21,80,27]);
    }
  }
}
module bottom() {
  intersection() {
    shelf_bracket();
    translate([-1,0,0]) cube([21,80,27]);
  }
}
module shelf_bracket(place=0) {
  wings=0;
  mid_bearings=2;
  bw=80;
  bh=60;
  tq=25.4*(3/4);
  ddist=22+tq;
  //echo(str("3/4: ", tq));
  mt=35-ddist/2+.5;
  mb=35+ddist/2;
  difference() {
    union(){
      translate([4,0]) cube3([18,bw,20],2);
      translate([7,15,12]) cube([16,50,12]);
      if(wings) translate([0,-30]) cube([25,bw+60,6]);
      translate([0,0,bh-65]) for(z=[mt,mb],y=[10,bw-10])
        translate([-.99,y,z]) rotate([0,90]) {
          cylinder(d1=10,d2=12,h=1,$fn=40);
          %translate([0,0,-7]) cylinder(d=22,h=7,$fn=60);
          translate([0,0,2]) rotate_extrude() union() {
            translate([7,0]) circle(r=1,$fn=50);
            translate([0,-1]) square([7,4]);
            tangle=atan(3/1)+270;
            echo(str("Tangle: ",tangle));
            polygon([[8,3],[8,3],[7+cos(tangle),sin(tangle)]]);
            square([8,3]);
          }
        }
      if(wings) mirrory(25) translate([0,-10,16]) rotate([0,90,0]) linear_extrude(25) difference() {
        square([10,10]);
        circle(r=10,$fn=50);
      }
    }
    for(x=[8,16],y=[3.5,40,76.5])
      translate([x,y,-.01]) cylinder(d=3,h=80,$fn=20);
    translate([0,0,bh-65]) translate([-.01,-.01,mt+10]) cube([4,bw+.02,tq+2]);
    if(mid_bearings==1)
    translate([0,0,bh-65]) translate([-.01,bw/2-11,35-4.5]) difference() {
      translate([0,-2]) cube([25.02,26,9]);
      difference() {
        mirrorz(4.5) translate([14,11,-.01]) cylinder(d1=12,d2=10,h=1,$fn=30);
        translate([14,11,-.02]) cylinder(d=8.1,h=8.02,$fn=40);
      }
    }
    else {
      mbs=bw/2+4-32*(mid_bearings-1);
      translate([0,mbs,bh-65]) for(mbi=[0:mid_bearings-1]) translate([-.01,mbi*34,25]) {
        translate([14,11,-20.01]) {
          cylinder(d=8.1,h=100,$fn=40);
          translate([0,0,11]) rotate([0,90,0]) cylinder(d=3,h=10,$fn=20);
          rotate([0,0,30]) cylinder(d=14.5,h=4.5,$fn=6);
          #mirror([1,0]) translate([0,0,21]) cube(15);
          %translate([0,0,21]) cylinder(d=22,h=7,$fn=60);
          %translate([0,0,29]) cylinder(d=22,h=7,$fn=60);
        }
        difference() {
          translate([0,-14]) cube([25.02,50,9]);
          difference() {
            mirrorz(4.5) translate([14,11,-.01]) cylinder(d1=12,d2=10,h=1,$fn=30);
            translate([14,11,-.02]) cylinder(d=8.1,h=8.02,$fn=40);
          }
        }
      }
    }
    translate([0,0,bh-65]) for(z=[mt,mb],y=[10,bw-10]) translate([-1.01,y,z]) rotate([0,90]) cylinder(d=8.2,h=26.02,$fn=30);
    *translate([14,bw/2,-.01]) cylinder(d=8.1,h=bh+.02,$fn=30);
    if(wings) for(y=[-20,bw+20])
    translate([12.5,y,-.01]) {
      translate([0,0,3]) cylinder(d1=4,d2=8,h=3.02,$fn=20);
      cylinder(d=4,h=8,$fn=20);
    }
  }
  if(place) {
    %for(z=[mt,mb],y=[10,40]) translate([-8,y,z]) rotate([0,90]) linear_extrude(7) difference() { circle(d=22,$fn=50); circle(d=8.1,$fn=30); }
    %translate([-100,-100,mt+11]) cube([102,200,tq]);
    %translate([14,25,35-3.5]) linear_extrude(7) difference() { circle(d=22,$fn=50); circle(d=8.1,$fn=30); }
  }
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

module cube3(dims,r=1)
{
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r,$fn=20);
  }
}
module cube2(dims,r=1)
{
  linear_extrude(dims[2]) {
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=20);
  }
}