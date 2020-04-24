part="vac"; // [all:Preview All,base:Dremel Base,tbase:Table Base,top:Table Top,clamp:Dremel Clamp,vac:Vacuum Attachment]
vacneck=48;
table_height=14; // [14,32]
table_width=80;
table_depth=100;
tbase_extender=1;

if(part=="base") base();
else if(part=="tbase") tablebase();
else if(part=="top") tabletop(1);
else if(part=="fence") rotate([0,90]) fence();
else if(part=="vac") vacattach();
if(part=="all") {
translate([vacneck-10,0,62]) vacattach(neck=vacneck);
#translate([0,0,25]) dremel();
//rotate([180,0]) {
translate([35,0,62]) clamp2vac(neck=vacneck);
translate([0,-20,42]) rotate([0,180]) topclamp();
//}
translate([-10,0,16]) base();
translate([0,-60,table_height-2]) tabletop();
translate([0,-60,0]) tablebase();
  translate([table_width,-68,table_height-14]) fence();
}
module fence() {
  difference() {
    union() {
      translate([0,0,14.5]) cube([10,table_depth+16,16]);
      mirrory(table_depth+16) translate([0,-3,9]) {
        translate([0,0,13]) rotate([0,90]) linear_extrude(10) {
          *square([10,7]);
          polygon([[-2,6],[4,0],[10,0],[18,6]]);
        }
      }
      intersection() {
        translate([0,0,1]) cube([10,table_depth+16,20]);
        translate([0,7.5,-0.5]) mirrory(table_depth) translate([-1,-1,table_height-6]) {
          rotate([180-45,0]) cube([table_width+10,10,10]);
          rotate([180,0]) cube([table_width+10,10,table_height]);
        }
      }
    }
    translate([5,-5,4.5]) rotate([-90,0]) cylinder(d=3,h=table_depth+30,$fn=20);
  }

}
module tablebase() {
  color("green") translate([20,-.5]) difference() {
    translate([0,-3]) cube([table_width+7,table_depth+7,table_height+.01]);
    mirrory(table_depth) translate([-1,0,table_height-6]) {
      rotate([180-45,0]) cube([table_width+10,10,10]);
      rotate([180,0]) cube([table_width+10,10,table_height]);
    }
    if(table_height>15)
    {
      translate([-1,54,16]) cube([20,13,20]);
    }
    translate([3,0,table_height-2.3]) cube([table_width+1,table_depth+1,10]);
    translate([8,8,-.01]) difference() {
      cube([table_width-8,table_depth-16,table_height]);
      translate([-.01,30,-.01]) cube([30,45,8]);
      for(x=[30:20:table_width-20]) translate([x,-.01,-.01]) cube([1.6,table_depth,table_height-2]);
    }
  for(y=[5,-17]) translate([-.01,y+60.5,0]) difference() {
    rotate([0,90,0]) linear_extrude(30.5) {
      rotate([0,0,90])
      polygon([[1.6,-.01],[-.4,4.2],[12.4,4.2],[10.4,-.01]]);
    }
  }
    for(x=[15,25],y=[5,-17]) translate([x,y+66.5,-.01]) {
      cylinder(d=3,h=table_height,$fn=20);
      translate([0,0,table_height-8]) cylinder(d=7,h=9,$fn=30);
    }
  }
  if(tbase_extender) {
  for(y=[5,-17]) translate([20+table_width+7,y+60,0]) difference() {
    rotate([0,90,0]) linear_extrude(30) {
      rotate([0,0,90])
      polygon([[2,0],[0,4],[12,4],[10,0]]);
    }
    for(x=[5,15,25]) translate([x,6,-.01]) cylinder(d=3,h=5,$fn=20);
  }
  }
}
module tabletop(rotprint=0) {
  rotate(rotprint?[180,0]:0)
  difference() {
    union() {
      translate([24,0]) cube([table_width,table_depth,2.3]);
      *translate([21,-3,2]) cube([table_width+6,table_depth+6,1]);
    }
    translate([34,40,-1]) cube([4,40,20]);
  }
}
module base() {
  translate([-32,-20,-16]) cube([42,40,1]);
  translate([-table_width,-20,-16]) cube([table_width,40,1]);
  difference() {
    translate([0,-20,-16]) cube([10,40,25]);
    translate([-.01,0,9.5]) rotate([0,90,0]) difference() {
      cylinder(d=19,h=10.02,$fn=40);
      rotate([0,0,90]) translate([-10,-10,2]) {
        cube([20,2,1]);
        translate([0,0,4]) cube([20,2,1]);
      }
    }
    mirrory()
    translate([5,15,-16.02]) cylinder(d=3,h=30,$fn=20);
  }
  translate([10,-20,-16]) cube([20,40,13]);
  for(y=[5,-17]) translate([30,y,-16]) difference() {
    rotate([0,90,0]) linear_extrude(30) {
      rotate([0,0,90])
      polygon([[2,0],[0,4],[12,4],[10,0]]);
    }
    for(x=[5,15,25]) translate([x,6,-.01]) cylinder(d=3,h=5,$fn=20);
  }
  translate([0,20,-16]) difference() {
    rotate([90,0]) linear_extrude(40) {
      polygon([[-25,0],[0,15],[0,0]]);
    }
    translate([0,-20,22]) rotate([0,-10,0]) rotate([0,-90]) cylinder(d1=32,d2=30,h=25,$fn=40);
  }
  mirrory() translate([-25,-10,-16]) peg();
  mirrory() translate([-134,-14.5,-16]) peg(16);
}
module peg(h=16) {
  cylinder(d=5.6,h=h-2.8,$fn=30);
  cylinder(d1=10,d2=5.6,h=3,$fn=40);
  translate([0,0,h-2.8]) sphere(d=5.6,$fn=30);
}
module topclamp() {
  difference() {
  cube([10,40,16]);
  translate([-.01,20,16]) rotate([0,90]) cylinder(d=19,h=10.02,$fn=40);
  mirrory(40)
  translate([5,5,-.01]) cylinder(d=3,h=30,$fn=20);
}
}
module dremel() {
  rotate([0,90]) {
    cylinder(d=3.2,h=35,$fn=30);
    cylinder(d=11,h=21,$fn=40);
    translate([0,0,35]) cylinder(d=30,h=2,$fn=50);
    translate([0,0,-75]) scale([.95,1]) cylinder(d=52,h=10,$fn=100);
  }
}
module clamp2vac(neck=48) {
  translate([neck-45,0,-20]) difference() {
    union() {
      cylinder(d=48,h=8,$fn=80);
    linear_extrude(8,convexity=3) difference() {
      hull() {
        translate([-neck,-20]) square([10,40]);
        circle(d=38,$fn=80);
      }
      circle(d=27.5,$fn=60);
      translate([-40,15]) circle(d=3,$fn=20);
      translate([-40,-15]) circle(d=3,$fn=20);
    }
  }
  for(r=[0:3]) rotate([0,0,90*r+45]) translate([20,0,-.01]) cylinder(d=3,h=8.02,$fn=20);
  translate([0,0,-.01]) cylinder(d1=33,d2=27.5,h=8.02,$fn=80);
}
}
module vacattach() {
  translate([0,0,-22]) difference() {
    union() {
      cylinder(d=50,h=3,$fn=80);
      translate([0,0,3]) rotate_extrude($fn=80) {
        translate([16,0]) intersection(){
          square([5,5]);
          difference() {
            square([10,10]);
            translate([5,5]) circle(d=10,$fn=30);
          }
        }
      }
    }
    translate([0,0,-.01]) cylinder(d=27.5,h=10.02,$fn=80);
    for(r=[0:3]) rotate([0,0,90*r+45]) translate([20,0,-.01]) {
      cylinder(d=3,h=8.02,$fn=20);
      translate([0,0,1.6]) cylinder(d=7,h=8,$fn=30);
    }
  }
  rotate([180,0]) {
    translate([0,0,-18]) base_male(35.5);
    translate([0,0,2]) difference() {
      cylinder(d=32.5,h=20,$fn=80);
      translate([0,0,-.01]) cylinder(d=27.5,h=20.02,$fn=80);
    }
    *translate([0,0,20]) difference() {
      cylinder(d1=32,d2=54,h=30,$fn=80);
      translate([0,0,-.01]) cylinder(d1=28,d2=50,h=30.02,$fn=80);
    }
  }
}

module mirrory(off=0)
{
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off*-.5]) children();
}



module ring(od,id,h)
{
  difference() {
    cylinder(d=od,h=h,$fn=od*2);
    translate([0,0,-.01]) cylinder(d=id,h=h+.02,$fn=id*2);
  }
}
module ring2(od1,od2,t,h)
{
  difference() {
    cylinder(d1=od1,d2=od2,h=h,$fn=od1*2);
    translate([0,0,-.01]) cylinder(d1=od1-t*2,d2=od2-t*2,h=h+.02,$fn=(od1-t*2)*2);
  }
}
module base_male(bd=35) {
  difference() {
    //ring2(bd,bd,4,20);
    //translate([0,0,-.01]) ring2(bd+.5,bd+2,1,1);
    //*
    cylinder(d=bd-.02,h=19.98,$fn=60);
    translate([0,0,-.01]) base_female(bd);
    translate([0,0,-.01]) cylinder(d=bd-8,h=20,$fn=56);
    translate([0,0,9.98]) ring(od=bd+2,id=bd-3,h=10.02);
    *translate([0,0,-.01]) ring2(bd-3,bd-1,1,2);
    //*/
  }
}
module base_female(bd=36.5) {
  difference() {
    cylinder(d=bd,h=10,$fn=60);
    translate([0,0,-.01]) cylinder(d=bd-3,h=3.02,$fn=50);
    translate([0,0,3]) cylinder(d1=bd-3,d2=bd-5,h=1.01,$fn=50);
    translate([0,0,4]) cylinder(d=bd-5,h=4.01,$fn=50);
    translate([0,0,8]) cylinder(d1=bd-5,d2=bd-3,h=1.01,$fn=50);
    translate([0,0,9]) cylinder(d=bd-3,h=1.01,$fn=50);
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