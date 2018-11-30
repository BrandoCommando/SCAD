part="preview"; // [preview:Preview All (ABCDEF),both:Corner Post (AB),post_base:Corner Post Base (A),post_top:Corner Post Top (B),belt_base:Belt Base (C),belt_cap:Belt Cap (D),top2:Corner Top (E),top_clamp (F), support:Mid-beam support (untested)]
height=40+25.4*2.5; // 4*25.4+40;
piped=23.5;
postd=40;
nutd=7;
belt_offset=3;
bumps=[-19.5,19.5];
cte=0;

//echo(str("Height: ",height));
if(part=="belt_cap")
  translate([-104.8,41]) rotate([0,90]) belt_cap();
else if(part=="belt_base")
  rotate([0,90]) belt_base();
else if(part=="both"||part=="post")
{
  post();
  corner_bottom();
} else if(part=="extender") {
  translate([-20,-7]) rotate([0,0,90]) rotate([90,0]) intersection() {
        belt_receiver(20,0);
        translate([0,-0,1]) cube([20,7,10]);
      }
  translate([-10,0,2]) rotate([0,0]) difference() {
    union() {
      *intersection() {
        belt_receiver(20);
        translate([0,-0]) cube([20,7,10]);
      }
      translate([0,-8,-2]) cube([20,23,5]);
    }
    translate([-.5,0]) cube([21,7,5]);
    for(x=[5,15],y=[-4,11]) translate([x,y,-3]) cylinder(d=3,h=10,$fn=20);
  }
  for(x=[15,30]) translate([x,-6,0]) rotate([0,0]) difference() {
    translate([.5,-2,0]) cube([9,23,5]);
    translate([-.01,5.4,3]) cube([20.2,7.8,3.01]);
    for(x=[5,15],y=[2,17]) translate([x,y,-.01]) cylinder(d=3,h=10,$fn=20);
  }
} else if(part=="support") {
  post(16);
  support(16);
} else if(part=="post_base") {
  post();
} else if(part=="post_top") {
  corner_bottom();
} else if(part=="top2") {
  rotate([-90,0]) mirror([1,0]) corner_top();
} else if(part=="top2c") {
  intersection(){
    translate([.75,-127,1]) rotate([-90,0]) corner_top();
    translate([-30,-30,18]) cube([60,60,50]);
  }
} else if(part=="top2b") {
  corner_top();
  corner_top_clamp();
} else if(part=="endstop") {
  *corner_top();
  rotate([0,90]) endstop();
} else if(part=="endstop2") {
  rotate([0,90]) endstop2();
} else if(part=="endstop3") {
  //*
  rotate([0,0])/*/
  corner_top(); //*/
  endstop3();
} else if(part=="top_clamp") {
  mirror([0,0,1]) corner_top_clamp(1);
} else {
  color("green") post();
  color("green") corner_bottom();
  color("blue") corner_top();
  color("red") corner_top_clamp();
  translate([0,0,1]) {
    color("purple") belt_base();
    color("pink") belt_cap();
  }
  *translate([0,0,height+18.5]) rotate([0,0,0]) translate([-5,10]) rotate([90,0]) translate([-100,-100,-13.5]) import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/Top_CornerC.STL");
*translate([0,50,0]) corner_bottom2();

%translate([-25,0,height-piped/2-2]) rotate([0,90,0]) pipe();
%translate([0,25,height+piped/2+4.2]) rotate([90,0]) pipe();
echo(str("New Pipe: ",(height-piped/2-2),":",(height+piped/2+4.2),"=",(height+piped/2+4.2)-(height-piped/2-2)));
*intersection() {
  corner_bottom();
  translate([-30,-40,127]) cube([60,80,100]);
}

*translate([-127,0,180]) rotate([0,0,0])
*old_parts();
}

module corner_top() {
  toptype=0;
  translate([0,0,height+3]) intersection() {
    translate([-42,-24-cte]) cube([84,48+cte,48]);
    difference(){
      union(){
        translate([0,0,13]) rotate([90,0]) translate([0,0,-24]) cylinder(d=40,h=48,$fn=100);
        translate([0,-24]) cube([24,48,10]);
        translate([-24,-24-cte]) cube([24,48+cte,16]);
        translate([-26,-10]) cube([26,36,18]);
        translate([0,0,-3]) for(m=[0]) mirror([m,0]) {
          difference(){union(){
            if(toptype==1)
              translate([-42,-10]) cube([20,20,22]);
            else difference() {
              translate([-42,-10,18]) union() {
                translate([0,-cte,-15]) cube([30,34,18]);
                translate([4.5,10-cte,-2]) cylinder(d1=9,d2=12,h=3,$fn=30);
                *cube([9,34,8]);
              }
              *translate([-42,10,17]) rotate([0,0,50]) cube([50,50,16]);
            }
            translate([-26,-10-cte,20]) rotate([0,0,90]) belt_receiver(18);
            }
            translate([-37.5,0-cte,-3.01]) {
              cylinder(d=3,h=50,$fn=20);
              translate([0,0,16]) rotate([0,0,90]) cylinder(d=7,h=3,$fn=6);
            }
          }
        }
      }
      for(rx=[0:3]) rotate([0,0,rx*90])
      translate([-19.5,-19.5,-.01]) {
        cylinder(d=3,h=40,$fn=20);
        translate([0,0,10]) cylinder(d=(rx==0||rx==3?7:10),h=30,$fn=32);
        rotate([0,0,rx==0?90:(rx==2?90:(rx==1?-90:0))]) {
          if(rx==3)
            translate([-5,-3.5,10]) cube([5,7,30]);
          else if(rx==0) {
            translate([-5,0,10]) cube([8.5,7,30]);
            translate([-5,-3.5,10]) cube([5,7,30]);
          } else
            translate([-5,-5,10]) cube([5,5,30]);
        }
      }
      for(m=[0]) mirror([m,0])
      {
        translate([-21,-cte,-.01]) {
          cylinder(d=3,h=50,$fn=20);
          rotate([0,0,90]) cylinder(d=8,h=10,$fn=4);
        }
      }
      translate([0,-cte]) for(x=[-42,-26],m=[0]) mirror([m,0]) translate([x-.01,-24.01,18]) cube([9,48.02+cte,10]);
      translate([0,0,13]) rotate([90,0]) translate([0,0,-24.01]) cylinder(d=piped+1,h=48.02+cte,$fn=90);
      translate([piped*-.5-.5,-24.01-cte,-.01]) cube([piped+1,49.02+cte,13.02]);
    }
  }
}
module endstop3() {
  drop=16;
  translate([19.5,0,height+14]) {
    difference(){
      union(){
        for(y=bumps)
          translate([0,y]) difference() {
            union(){
            cylinder(d=8,h=4,$fn=40);
              translate([0,-4,0]) cube([4,8,4]);
            }
            translate([0,0,-.01]) cylinder(d=3,h=4.02,$fn=20);
          }
        translate([2,-5]) rotate([0,0,90]) translate([1,-23.5]) {
          *cube([4,47,33]);
          translate([6,0]) rotate([0,-90]) linear_extrude(3) {
            translate([0,0,0]) square([33,24.5]);
            translate([0,2,0]) square([35,20.5]);
            *translate([drop*-1,30]) square([33,27]);
            for(x=[2,22.5],y=[33])
              translate([y,x]) circle(d=4,$fn=20);
          }
        }
        translate([1,-16]) cube([3,37,4]);
        
      }
      translate([32,0]) rotate([0,0,90]) for(y=[10],z=[3,25,-19])
      translate([-2,y+1,z+7]) rotate([0,90]) linear_extrude(10){
        circle(d=3.4,$fn=30);
        //translate([-1.7,0]) square([3.4,11]);
        translate([0,10.2,9]) circle(d=3.4,$fn=30);
      }
      for(y=bumps) translate([0,y,-.01]) {
        cylinder(d=3,h=30,$fn=20);
        translate([0,0,4]) cylinder(d1=10,d2=6,h=8,$fn=50);
      }
    }
    %color("gray") translate([24,2.5,7]) rotate([0,0,90])difference(){
      cube([10,16.2,28]);
      translate([-.01,3,3]) rotate([0,90]) cylinder(d=3,h=10.02,$fn=20);
      translate([-.01,13.2,25]) rotate([0,90]) cylinder(d=3,h=10.02,$fn=20);
    }
  }
}
module endstop2() {
  drop=16;
  translate([19.5,0,height+14]) {
    difference(){
      union(){
        for(y=bumps)
          translate([0,y]) difference() {
            union(){
            cylinder(d=8,h=4,$fn=40);
              translate([0,-4,0]) cube([4,8,4]);
            }
            translate([0,0,-.01]) cylinder(d=3,h=4.02,$fn=20);
          }
        translate([1,-23.5]) {
          *cube([4,47,33]);
          translate([6,0]) rotate([0,-90]) linear_extrude(3) {
            translate([0,0,0]) square([33,57]);
            translate([0,2,0]) square([35,53]);
            *translate([drop*-1,30]) square([33,27]);
            for(x=[2,55],y=[33])
              translate([y,x]) circle(d=4,$fn=20);
          }
        }
        translate([1,-16]) cube([3,17,4]);
        
      }
      for(y=[10],z=[3,25,-19])
      translate([0,y,z+7]) rotate([0,90]) linear_extrude(10){
        circle(d=3.4,$fn=30);
        translate([-1.7,0]) square([3.4,20]);
        translate([0,20]) circle(d=3.4,$fn=30);
      }
      for(y=bumps) translate([0,y,-.01]) {
        cylinder(d=3,h=30,$fn=20);
        translate([0,0,4]) cylinder(d1=10,d2=6,h=8,$fn=50);
      }
    }
    %color("gray") translate([7.5,8,7]) difference(){
      cube([10,16.2,28]);
      translate([-.01,3,3]) rotate([0,90]) cylinder(d=3,h=10.02,$fn=20);
      translate([-.01,13.2,25]) rotate([0,90]) cylinder(d=3,h=10.02,$fn=20);
    }
  }
}
module endstop() {
  translate([19.5,0,height+14]) {
    difference(){
      union(){
        for(y=[19.5,-19.5])
          translate([0,y]) difference() {
            union(){
            cylinder(d=8,h=6,$fn=40);
              translate([0,-4,0]) cube([4,8,6]);
            }
            translate([0,0,-.01]) cylinder(d=3,h=6.02,$fn=20);
          }
        translate([1,-23.5]) {
          *cube([4,47,33]);
          translate([6,0]) rotate([0,-90]) linear_extrude(3) {
            translate([0,0,0]) square([31,47]);
            translate([0,2,0]) square([33,43]);
            for(x=[2,45],y=[31])
              translate([y,x]) circle(d=4,$fn=20);
          }
        }
        translate([1,-16]) cube([3,37,6]);
        
      }
      for(y=[10,-20],z=[4,24])
      translate([0,y,z+5]) rotate([0,90]) linear_extrude(){
        circle(d=3.4,$fn=30);
        translate([-1.7,0]) square([3.4,10]);
        translate([0,10]) circle(d=3.4,$fn=30);
      }
      for(y=[19.5,-19.5]) translate([0,y,-.01]) {
        cylinder(d=3,h=30,$fn=20);
        translate([0,0,6]) cylinder(d1=10,d2=6,h=8,$fn=50);
      }
    }
    *%translate([7.5,8,5]) difference(){
      cube([10,16.2,28]);
      translate([-.01,4,4]) rotate([0,90]) cylinder(d=3,h=10.02,$fn=20);
      translate([-.01,12.2,24]) rotate([0,90]) cylinder(d=3,h=10.02,$fn=20);
    }
  }
}
module corner_top_clamp(alone=0) {
  translate(alone?[]:[-42,-10,height+26]) difference() {
    translate([1,0,-3]) cube([23,20,9]);
    translate([8,-.01,-3.01]) cube([9,20.02,5]);
    translate([4,10,-3.01]) cylinder(d=3,h=10,$fn=20);
    translate([21,10,-3.01]) cylinder(d=3,h=20,$fn=20);
  }
}
module corner_bottom2() {
  support_type=0;
  difference(){union(){
    difference(){
        translate([-25,0,height-30+17]) intersection() {
          rotate([0,90,0]) cylinder(d=46,h=50,$fn=100);
          translate([0,-23,-25]) cube([50,46,33]);
        }
          if(support_type==1)
          translate([-30,-20,height-36]) cube([60,40,5]);
      }
     translate([-25,-23,height-13]) cube([50,46,13]);
    *translate([0,0,height-40]) scale([1.55,0.75,1]) cylinder(d=32,h=20,$fn=6);
    }
    translate([-30,0,height-30+17]) {
      rotate([0,90,0]) cylinder(d=25,h=60,$fn=60);
      translate([0,-12.5]) cube([60,25,25]);
    }
    translate([-7.5,-25,height-7]) {
      cube([15,50,20]);
      rotate([0,-45,0]) cube([20,50,20]);
    }
    translate([0,0,height-32]) cylinder(d=13.4,h=20,$fn=6);
    *translate([0,0,height-36]) cylinder(d=20,h=20,$fn=6);
    cylinder(d=7.4,h=height,$fn=30);
  for(x=[0:1],y=[0:1])
    mirror([x,y]) top_cutout(0);
  }
}  
module support(d=postd) {
  extra_pipe=1;
  support_type=0;
  nut_type=1;
difference(){
  union(){
    translate([0,0,height-(extra_pipe?65:55)]) cylinder(d=d,h=(extra_pipe?15:5)+(support_type==0?0:20),$fn=100);
    translate([0,0,height-65+15]) cylinder(d1=d,d2=d-10,h=28,$fn=90);
    if(support_type==0)
    translate([0,0,height-65]) scale([0.88,0.44,1.1]) rotate([0,0,45])
     {
       cylinder(d1=23.5*.5,d2=30,h=18,$fn=4);
       translate([0,0,18]) rotate([0,0,-45]) scale([1,1]) rotate([0,0,45]) cylinder(d1=30,d2=32,h=5,$fn=4);
       translate([0,0,23]) cylinder(d=32,h=5,$fn=4);
     }
     difference(){
      translate([-25,0,height-30+17]) intersection() {
        rotate([0,90,0]) cylinder(d=46,h=50,$fn=100);
        translate([15,-5,-25]) cube([20,10,13]);
      }
    }
  }
  translate([-30,0,height-30+17]) {
    rotate([0,90,0]) cylinder(d=25,h=60,$fn=60);
    translate([0,-12.5]) cube([60,25,25]);
  }
}
}
module corner_bottom(d=postd) {
  extra_pipe=1;
  support_type=0;
  nut_type=1;
  *%translate([-50,0,149]) rotate([0,90]) pipe();
difference(){
  union(){
    translate([0,0,height-(extra_pipe?65:55)]) cylinder(d=d,h=(extra_pipe?15:5)+(support_type==0?0:20),$fn=100);
    if(support_type==0||support_type==3) {
    translate([0,0,height-50]) cylinder(d1=d,d2=min(46,d+16.5),h=14.5,$fn=100);
    translate([0,0,height-35.5]) cylinder(d1=min(46,d+16.5),d2=min(46,d+21.5),h=25,$fn=100);
    } else {
      translate([0,0,height-40]) cylinder(d1=d,d2=30,h=10,$fn=100);
    }
    translate([-25,-23,height-5.01]) {
      *cube([44,44,5]);
      cube([18,46,5]);
      translate([32,0])
        cube([18,46,5]);
      translate([16,2,0])
        cube([16,40,4]);
      translate([16,0,4])
        cube([16,46,1]);
    }
    if(support_type==0)
    translate([0,0,height-55]) scale([2.21,1,0.85]) rotate([0,0,45])
     {
       cylinder(d1=23.5*.5,d2=30,h=18,$fn=4);
       translate([0,0,18]) rotate([0,0,-45]) scale([1,1]) rotate([0,0,45]) cylinder(d1=30,d2=32,h=5,$fn=4);
       translate([0,0,23]) cylinder(d=32,h=5,$fn=4);
     }
    *translate([-15,-15,height-40]) cube([30,30,35]);
     difference(){
      translate([-25,0,height-30+17]) intersection() {
        rotate([0,90,0]) cylinder(d=46,h=50,$fn=100);
        translate([0,-23,-25]) cube([50,46,33]);
      }
        if(support_type==1)
        translate([-30,-20,height-36]) cube([60,40,5]);
    }
    translate([-25,-23,height-13]) cube([50,46,10]);
  }
  translate([-7,-30,height-6.52])
    cube([14,60,10]);
  *translate([-7,-30,height-10])
    translate([0,7.99,5]) cube([14,2,4]);
  *mirror([0,1]) translate([-7,-30,height-10])
    translate([0,7.99,5]) cube([14,2,4]);
  translate([-30,0,height-30+17]) {
    rotate([0,90,0]) cylinder(d=25,h=60,$fn=60);
    translate([0,-12.5]) cube([60,25,25]);
  }
  for(x=[0:1],y=[0:1])
    mirror([x,y]) top_cutout(0);
  translate([0,0,14]) {
    center_bolt();
    translate([0,0,height-60]) cylinder(d=20,h=32,$fn=50);
    *translate([0,0,height-44.99]) mirror([0,0,1])  cylinder(d1=13.4,d2=nutd,h=5,$fn=6);
  }
}
}

module belt_platform() {
  belt_base();
  belt_cap();
}
module belt_base() {
  h=13.4;
  difference(){union(){
  translate([h*-.5,-20,height-5]) difference() {        
    union() {
      translate([0,10,5]) cube([h,20,0]);
      translate([0,-3,0]) cube([h,46,5]);
      //translate([0,0,0]) cube([h,4
      *for(m=[0,1]) mirror([0,m,0])
        translate([0,-16,-3]) cube([h,13,4]);
    }
    translate([h/2,40.01,20]) rotate([90,0]) cylinder(d=24,h=50,$fn=50);
    translate([-.01,20,-9.5]) rotate([0,90]) cylinder(d=24,h=20,$fn=50);
  }
  for(m=[0,1]) mirror([0,m])
  translate([h*-.5,-30,height-5]) difference() {
    union(){
      translate([0,0-belt_offset,0]) belt_receiver(h);
      translate([0,-5-belt_offset,0]) cube([h,15,2]);
      translate([0,-8-belt_offset,-4]) cube([h,17.4+belt_offset,6]);
      translate([0,6,-1.2]) cube([h,11.4,2]);
    }
    translate([-.01,-8-belt_offset,2]) cube([h+.02,8,3.01]);
    translate([h/2,-4-belt_offset,-5.01]) {
      cylinder(d=3,h=20,$fn=20);
      translate([0,0,-7.01]) cylinder(d=nutd,h=11,$fn=6);
    }
  }
}
  *for(m=[0,1]) mirror([0,m,0])
    translate([h*-.5-.01,-23.6,height-5-3]) cube([h+.02,11,4.4]);
}
}
module belt_cap(h=13.4,pipeoff=4) {
  for(m=[0,1]) mirror([0,m])
  translate([h*-.5,-36,height]) difference() {
    union(){
    translate([0,-2-belt_offset,.3]) cube([h,40+belt_offset,pipeoff+1]);
    translate([0,-2-belt_offset,-2.7]) cube([h,7.5,4]);
    }
    translate([h/2,2-belt_offset,-.01]) {
      translate([0,0,-3]) cylinder(d=3,h=10,$fn=20);
      translate([0,0,pipeoff-4]) cylinder(d=6.2,h=5,$fn=30);
    }
    translate([-.01,5.5-belt_offset,-.03])
      cube([h+.02,8,2]);
    *translate([-.01,13.49,-.03])
      cube([h+.02,3,1.3]);
    translate([h/2,-2.01-belt_offset,pipeoff+23.5/2]) rotate([-90,0]) cylinder(d=23.5,h=41+belt_offset,$fn=60);
  }
}
module fancy_base(h=5,r=2) {
  difference(){union(){difference(){
        translate([-25,-25])
        intersection() { linear_extrude(h) {
          translate([0,6,0]) square([50,38]);
          translate([6,0,0]) square([38,50]);
        }
           intersection(){
             cube([50,50,h]);
             if(r>0)
             translate([r,r,r/-2]) minkowski(){
               cube([46,46,h-r/2]);
               sphere(r=r,$fn=30);
             }
           }
        }
      }
      for(rd=[0:3]) rotate([0,0,90*rd])
        translate([-19,-19]) intersection() {
          rotate_extrude($fn=50) {
            translate([5,3]) circle(d=4,$fn=50);
            square([8,3]);
            translate([0,3]) square([h,2]);
          }
          cylinder(d=14,h=h,$fn=50);
        }
      }
         center_bolt();

   for(r=[0:3])
     rotate([0,0,45+90*r]) translate([27,0,-.01]) {
       cylinder(d=4,h=25,$fn=20);
       translate([0,0,h-2.5]) cylinder(d1=4,d2=8,h=3,$fn=30);
     }
   }
}
module post(d=postd) {
  fancy_base=1;
difference(){union(){
    if(fancy_base) {
      fancy_base();
    } else {
      translate([-25,-25]) cube([50,50,5]);
    }
    translate([0,0,5]) cylinder(d1=min(47,d+16.5),d2=d,h=10,$fn=100);
    translate([0,0,15]) cylinder(d=d,h=height-70,$fn=100);
   }
   translate([0,0,-.01]) cylinder(d=13.4,h=6,$fn=6);
   translate([0,0,5.98]) cylinder(d1=13.4,d2=7.4,h=5,$fn=6);
   center_bolt();
   for(r=[0:3])
     rotate([0,0,45+90*r]) translate([27,0,-.01]) {
       cylinder(d=4,h=25,$fn=20);
       translate([0,0,2.5]) cylinder(d1=4,d2=8,h=3,$fn=30);
       translate([0,0,5.49]) cylinder(d=10,h=22,$fn=30);
     }
 }
}
module center_bolt() {
  translate([0,0,-.01]) cylinder(d=7.4,h=height,$fn=20);
  translate([0,0,5*25.4-10]) cylinder(d=13.4,h=45,$fn=6);
}

module belt_holes() {
  
  translate([7,0,-5.01]) {
    cylinder(d=3,h=20,$fn=20);
    *cylinder(d=nutd,h=7,$fn=6);
  }
  *translate([-.01, 2, 6]) cube([15,6,3]);
}

module belt_receiver(h=14,vert=1) {
  difference(){
    translate([0,-6,1]) cube([h,21,4]);
  }
  *translate([0,7,5]) cube([h,3,1]);
  translate([0,0,5]) for(x=[0:2:h-1]) translate([x,0,0]) {
    *cube([.8,7,1]);
    translate([0,7,0]) rotate([90,0]) linear_extrude(7) {
      if(vert)
        polygon([[0,0],[0,1],[.5,1],[.8,.5],[.8,0]]);
      else
        square([.8,1]);
    }
  }
  *translate([0,10,-12]) intersection() {
    rotate([45,0]) cube([14,10,sqrt(pow(12,2)+pow(16,2))]);
    translate([0,-14,0]) cube([14,14,15]);
  }
}

module belt_clamp() {
  translate([0,-4,1]) cube([14,12,3]);
  translate([.2,7,-1]) cube([13.4,1.7,3]);
  translate([0,2,0]) for(x=[1:2:14]) translate([x,0,0]) cube([.8,5,2]);
}
module top_cutout(big_cutout=1) {
  translate([-19.4,-19.4,height-40]) {
    translate([0,0,-10]) {
      translate([0,0,15]) rotate([0,0,0]) {
        cylinder(d=nutd,h=20,$fn=6);
      }
      *translate([-3.25,-5,25]) cube([6.5,4,5]);
      *cylinder(d=8,h=31.01,$fn=30);
      *translate([-5,-5]) cube([7,7,35.01]);
      if(big_cutout)
      translate([-6,-6]) cube([12,12,35.01]);
    }
    translate([0,0,0]) cylinder(d=3,h=50.01,$fn=20);
    *translate([-20,-20]) cube([24,24,35.01]);
  }
}

module old_parts(top=0) {
translate([10,-5]) {
  #translate([-15,15]) rotate([90,0]) translate([-100,-100,-13.5]) import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/Top_CornerC.STL");
  rotate([0,0,90]) translate([0,0,-36]) rotate([180,0]) rotate([90,0]) translate([-100,-100,-13.5]) import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/Bottom_CornerC.STL");
  translate([-8,5,-70]) rotate([180,0]) translate([-100,-100,-13.5])import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/Lock-CornerC.STL");
}
translate([0,0,-160]) translate([-275,-160,-20]) import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/Flex_Foot_Bottom.STL");
%translate([0,24,-4]) rotate([90,0]) pipe(200);
%translate([-175,0,-30]) rotate([0,90,0]) pipe(200);
%translate([0,0,-175]) pipe();
}

module pipe(length=100)
{
  difference(){
    cylinder(d=piped,h=length,$fn=50);
    translate([0,0,-.01])
      cylinder(d=21.2344,h=length+.02,$fn=40);
  }
}
module extension(h=40,lip=1)
{
  difference(){
    cylinder(d=lip?23.5:23,h=h,$fn=80);
    translate([0,0,-.01]) cylinder(d=7.4,h=h+.02,$fn=20);
  }
  if(lip) translate([0,0,-6])
    difference(){
      union(){
        cylinder(d=30,h=6,$fn=80);
        translate([0,0,6]) cylinder(d1=30,d2=23.5,h=min(h-6,17),$fn=80);
      }
      *translate([0,0,5]) cylinder(d1=24,d2=23,h=1.02,$fn=80);
      translate([0,0,-.01])
        cylinder(d=24,h=6.02,$fn=80);
      translate([0,0,-.01])
        cylinder(d=7.4,h=40,$fn=20);
    }
}