part="setup"; // [all:All parts & in place,setup:All parts setup preview,base:Bottom Half,base_nub1:Bottom Nub (without chamfer),base_nub2:Bottom Nub (with chamfer),prop:Top Half,prop_nub:Top Nub (print 2)]
thickness=6;
one_way=1;
hinge_clearance=0;
screwd=3;
extra_prop=20;
*translate([-568.26,-190.04]) import("Switch_Folding_Stand_2.1.stl");
if(part=="all") {
half_prop();
mirrory() translate([-62.75-extra_prop,-25.6]) nub_prop();
half_base(notch=2);
translate([24.2,0,2.5]) base_nubs();
} else if (part=="setup") {
  rotate([0,180]) {
    rotate([0,-135]) translate([9.75,0,-2.5]) {
      half_prop();
      mirrory() translate([-62.75-extra_prop,-25.6]) translate([2.5,0,2.5]) rotate([0,180]) translate([-2.5,0,-2.5]) nub_prop();
    }
    translate([9.75,0,-2.5]) {
      half_base(notch=2);
      translate([21.7,0]) translate([2.5,0,2.5]) rotate([0,135,0]) {
        base_nubs();
        translate([27,0]) console();
      }
    }
  }
} else if (part=="prop") half_prop();
else if (part=="prop_nub") nub_prop();
else if (part=="base") half_base();
else if (part=="base_nub1") nub_base(0);
else if (part=="base_nub2") mirror([0,1]) nub_base(1);
else if (part=="base_nubs") base_nubs();
module console() {
  %translate([0,-4.7*25.4,1]) cube([0.55*25.4,9.4*25.4,4*25.4]);
}
module base_nubs() {
  for(m=[0,1]) mirror([0,m,0])
    translate([-2.5,-25.6]) translate([2.5,0]) translate([-2.5,0,-2.5]) nub_base(!m,notch=0);
  translate([17.8,-12,thickness/-2]) cube([4.2,24,2]);
}
module nub_base(noslant=0,notch=1) {
  difference() {
    union() {
      translate([2.5,0,2.5-thickness/2]) {
        if(notch)
          linear_extrude(thickness,convexity=3) polygon([[0,0],[36.5+thickness-.01,0],[36.5+thickness-.01,15.6],[22,15.6],[22,20],[16,18],[16,15.6],[0,15.6]]);
        else
          cube([36.5+thickness-.01,15.6,thickness]);
      }
      translate([2.5,0,2.5]) rotate([-90,0]) cylinder(d=thickness,h=11.4,$fn=40);
    }
    translate([7.7+thickness/2,11.4,-1]) rotate([0,hinge_clearance?0:-45,0]) mirror([1,0]) cube([20,4.6,20]);
    translate([2.5,-.01,2.5]) rotate([-90,0]) cylinder(d=screwd,h=61,$fn=30);
    if(noslant)
      translate([24+thickness,-.01,3]) rotate([0,-45]) cube([6,20,6]);
    translate([24+thickness,-.01,3]) difference() {
      cube([16,20,2.8]);

      translate([7,5.7,0]) cylinder(d1=4,d2=2,h=2,$fn=8);
    }
    if(one_way)
        translate([10.8,-.01,3.6]) cube([4.8,20,2]);
  }
  translate([38+thickness,0,4]) rotate([-90,0]) cylinder(d=2,h=15.6,$fn=20);
  translate([37+thickness,0,3]) cube([2,15.6,1]);
}
module half_base(notch=1) {
  difference() {
    translate([-9.75,-30]) {
      translate([0,0,2.5-thickness/2]) cube2([74+thickness,60,thickness],0,4);
      translate([.1,-.01,2.5]) rotate([-90,0]) {
        for(z=[4.4,24.4,44.4]) 
          translate([0,0,z]) 
            cylinder(d=thickness,h=11.2,$fn=50);
      }
    }
    translate([-9.65,-30.01,2.5]) rotate([-90,0]) cylinder(d=screwd,h=61,$fn=30);
    mirrory() translate([-3.4+(thickness-5)*1.5-(hinge_clearance?0:0),-30.01,2.5-thickness/2-.01]) rotate([0,hinge_clearance?0:-45,0]) mirror([1,0]) {
      cube([20,4.4,20]);
      translate([0,15.6]) cube([20,8.8,20]);
    }
    if(notch==2) {
      translate([41.5,-10,-.6]) cube([5,20,2.5]);
    }
    mirrory() translate([22.9,-26.1,-.01]) {
      difference() {
        translate([0,0,2.5-thickness/2]) {
          if(notch==1)
            linear_extrude(thickness+.02,convexity=3) polygon([[0,0],[38.2+thickness,0],[38.2+thickness-.01,16.5],[23.8,16.5],[23.8,21],[17,18.9],[17,16.5],[0,16.5]]);
          else
            cube([38.2+thickness,16.5,thickness+.02]);
        }
        translate([1.25,12,2.5]) rotate([-90,0]) cylinder(d=thickness,h=10,$fn=40);
        translate([0,12,2.5-thickness/2]) cube([1.25,10,thickness]);
        if(one_way)
          translate([10,0,4]) cube([4,20,2]);
      }
      if(hinge_clearance)
        translate([-5,0,thickness/-2]) cube([12,12.2,12]);
      else
        translate([-thickness-1,0,5-thickness]) rotate([0,45]) cube([12,12.2,12]);
      translate([1.25,-4.01,2.5]) rotate([-90,0]) cylinder(d=screwd,h=61,$fn=30);
    }
  }
}
module half_prop(notch=2) {
  extra=extra_prop;
translate([-68,-30]) difference() {
  union() {
    translate([0,0,2.5-thickness/2]) linear_extrude(thickness) {
      translate([4-extra,0]) square([54.5+extra,60]);
      translate([-extra,4]) square([4,52]);
      translate([4-extra,4]) circle(r=4,$fn=30);
      translate([4-extra,56]) circle(r=4,$fn=30);
    }
    translate([58.5,0,2.5]) rotate([-90,0]) cylinder(d=thickness,h=60,$fn=30);
  }
  translate([58.5,-.01,2.5]) rotate([-90,0]) {
    cylinder(d=screwd,h=61,$fn=20);
    for(z=[4,24,44])
    {
      if(hinge_clearance)
        translate([-8,-5,z]) cube(12);
      else
        translate([-9,2.5+thickness/4,z]) rotate([0,0,-45]) cube([20,12,12]);
    }
  }
  if(notch==2) {
    translate([35,20,-.6]) cube([3,20,1.5]);
    translate([-extra,0]) mirrory(30) {
      translate([-0.01,4,(2.5-thickness/2)-.01]) difference() {
        union() {
          cube([58,16.5,10]);
          if(notch==1)
            translate([31,16]) cube([7,5,1]);
        }
        if(one_way)
        translate([17.6,0,2.5-thickness/2]) cube([4,22,1.6]);
        translate([0,-.01]) cube([2.5,16.6,1.45]);
        translate([1.25,-.01,1.45]) rotate([-90,0]) cylinder(d=3,h=16.6,$fn=20);
      }
      translate([7.75,-.01,2.5]) rotate([-90,0]) cylinder(d=screwd,h=61,$fn=20);
    }
  }
}
}

module nub_prop() {
  difference() {
    union() {
      translate([2.5,0,2.5-thickness/2]) cube([41+(extra_prop>10?8.5:0),15.6,thickness]);
      translate([2.55,0,2.5]) rotate([-90,0]) cylinder(d=thickness,h=15.6,$fn=40);
    }
    if(one_way)
        translate([12,0,2.5-thickness/2-.01]) cube([4.8,20,2]);
    translate([2.5,-.01,2.5]) rotate([-90,0]) cylinder(d=screwd,h=20,$fn=30);
    translate([9.1,-.01,4]) rotate([-90,0]) linear_extrude(20,convexity=3) {
      circle(d=screwd,h=20,$fn=30);
      translate([-1.5,-3]) square([3,3]);
      difference() {
        translate([-2.5,-3]) square([5,3]);
        translate([-2.5,0]) circle(d=screwd,$fn=20);
        translate([2.5,0]) circle(d=screwd,$fn=20);        
      }
    }
  }
}

module cube2(dims,rtop=0,rbottom=0)
{
  linear_extrude(dims[2],convexity=2)
  {
    translate([rtop,0]) square([dims[0]-rtop-rbottom,dims[1]]);
    if(rtop>0) {
      translate([0,rtop]) square([rtop,dims[1]-rtop*2]);
      translate([rtop,rtop]) circle(r=rtop,$fn=30);
      translate([rtop,dims[1]-rtop]) circle(r=rtop,$fn=30);
    }
    if(rbottom>0) {
      translate([dims[0]-rbottom,rbottom]) square([rbottom,dims[1]-rbottom*2]);
      translate([dims[0]-rbottom,rbottom]) circle(r=rbottom,$fn=30);
      translate([dims[0]-rbottom,dims[1]-rbottom]) circle(r=rbottom,$fn=30);
    }
    
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