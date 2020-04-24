if(!novac)
  vac3();
module vac5() {
    fd1=42;
  fd2=fd1+8;
  b5d=35.5;
  neckh=40;
  base_male(b5d);
  translate([0,0,20]) difference() {
    cylinder(d1=b5d-3,d2=35,h=10,$fn=60);
    translate([0,0,-.01])
      cylinder(d1=b5d-8,d2=b5d-5,h=10.02,$fn=50);
  }
  translate([0,0,10]) {
    translate([0,0,20]) difference() {
      cylinder(d1=35,d2=36,h=20,$fn=60);
      translate([0,0,-.01]) cylinder(d1=31,d2=32,h=20.02,$fn=60);
    }
    translate([0,0,40]) ring2(36,36,2,neckh);
    translate([0,0,40+neckh]) difference() {
      cylinder(d1=36,d2=8,h=40,$fn=60);
      translate([0,0,-.01]) cylinder(d1=32.5,d2=4,h=40.02,$fn=50);
      scale([1,0.4,1]) translate([0,0,4]) scale([1,0.8,1]) rotate([0,0,45]) cylinder(d1=fd1-4,d2=fd2-4,h=60.02,$fn=4);
    }
    translate([0,0,46+neckh]) difference() {
    scale([1,0.4,1])
    difference() {
      rotate([0,0,45]) 
        cylinder(d1=fd1,d2=fd2,h=60,$fn=4);
      translate([0,0,-.01]) scale([1,0.8,1]) rotate([0,0,45])  cylinder(d1=fd1-4,d2=fd2-4,h=60.02,$fn=4);
    }
      translate([-25,-10,40]) rotate([50,0]) cube(50);
      translate([-25,0,60.5]) rotate([-40,0]) cube(50);
    //cylinder(d=14,h=50,center=true);
      translate([0,0,-10]) cylinder(d1=35,d2=7,h=40,$fn=60);
      translate([2-17,2-6.8,98.5-56]) rotate([45,0]) translate([0,0,0]) cube([30,14.2,90.02]);
    }
    }
    translate([0,0,neckh]) difference() {
    translate([-17,-6.8,98.5]) rotate([45,0]) translate([0,0,-4]) difference() {
      cube([34,18.2,74]);
      translate([2,2,-.01]) cube([30,14.2,90.02]);
      translate([-2,-4,-.01]) cube([50,20,4]);
    }
      translate([-25,6,100]) cube(50);
      translate([-25,-80,155]) rotate([0,0]) cube(50);
      translate([0,-60,130]) cylinder(d=30,h=50,$fn=60);
  }
  }
module vac4() {
  fd1=42;
  fd2=fd1+8;
  botd=(1+3/8)*25.4;
  echo(str("Bottom D: ",botd));
  base_male();
  translate([0,0,20]) ring2(od1=31.5,od2=35,t=2.5,h=10);
  translate([0,0,30]) difference() {
      cylinder(d1=35,d2=36,h=30,$fn=60);
      translate([0,0,-.01]) cylinder(d1=30,d2=32.5,h=30.02,$fn=60);
    }
  difference() {
    translate([-20,-20,60])
      cube([40,40,3]);
    cylinder(d=32.5,h=80,$fn=60);
    translate([0,0,59.99]) {
      translate([0,0,2.01]) cylinder(d1=32.5,d2=34,h=1.01,$fn=60);
      translate([-16,-16]) cylinder(d=4,h=4,$fn=12);
      rotate([0,0,90]) translate([-16,-16]) cylinder(d=4,h=4,$fn=12);
      rotate([0,0,180]) translate([-16,-16]) cylinder(d=4,h=4,$fn=12);
      rotate([0,0,270]) translate([-16,-16]) cylinder(d=4,h=4,$fn=12);
    }
  }

}
module vac3() {
  fd1=42;
  fd2=fd1-8;
  sec1d2=10;
  sec1h=40;
  exh=80;
  exrd=10;
  exz=40;
  exscx=.5;
  exscy=.75;
  slanta=10;
  exscr=exscx/exscy;
  exscx2=exscx-.05;
  exscy2=exscy-.04;
  base_male();
  translate([0,0,20]) ring2(od1=32,od2=35,t=2.5,h=10);
  difference() {
  translate([0,0,10]) {
    translate([0,0,20])
      cylinder(d1=35,d2=36,h=20,$fn=60);
    translate([0,0,40])
      cylinder(d1=36,d2=sec1d2,h=sec1h,$fn=60);
    translate([0,0,exz])
      scale([exscx,exscy,1])
      {
        rotate([0,0,45]) {
          minkowski() {
            cylinder(d1=fd1,d2=fd2,h=exh,$fn=4);
            sphere(d=exrd,$fn=20);
          }
        }
      }
    }
    translate([0,0,10]) {
      translate([0,0,19.99]) cylinder(d1=30,d2=31,h=20.02,$fn=60);
      translate([0,0,39.99]) cylinder(d1=31,d2=sec1d2-4,h=sec1h+.02,$fn=50);
      translate([0,0,exz-.01]) scale([exscx2,exscy2,1]) rotate([0,0,45]) minkowski() {
        cylinder(d1=fd1-4,d2=fd2-4,h=exh+.03,$fn=4);
        sphere(d=exrd,$fn=20);
      }
      translate([fd2*-.5*exscx-1,fd2*-.5*exscy-1,exz+exh]) rotate([-slanta,0]) cube([fd2,fd2,30]);
    }
  }
}
module vac2(bd=38) {
base_female(bd);
translate([0,0,10]) {
  ring2(bd,bd,1.5,20);
translate([0,0,20]) difference() {
  ring2(bd,8,1.5,40);
  translate([0,0,10]) scale([2,0.4,1]) scale([1,0.8,1]) rotate([0,0,45])  cylinder(d1=bd*.5-4,d2=bd*(80/36)-6,h=60.02,$fn=4);
}
translate([0,0,30]) difference() {
scale([2,0.4,1])
difference() {
  rotate([0,0,45]) 
    cylinder(d1=bd*.5,d2=bd*(80/36),h=60,$fn=4);
  translate([0,0,-.01]) scale([1,0.8,1]) rotate([0,0,45])  cylinder(d1=bd*.5-4,d2=bd*(80/36)-6,h=60.02,$fn=4);
}
  translate([0,-10,75]) rotate([30]) cube([200,50,50],center=true); //cylinder(d=14,h=50,center=true);
  translate([0,0,-10]) cylinder(d1=35,d2=7,h=40,$fn=60);
}
}
}

module vac1() {
union(){
difference() {
rotate_extrude()
{
translate([30,0]) difference() {
  circle(d=10,$fn=30);
  translate([-10,-10]) square([20,7]);
  circle(d=5,$fn=20);
  rotate(230) square([10,3]);
}
}
  translate([30,0,0]) rotate([0,20,0]) cylinder(d1=5,d2=6,h=10,$fn=20);
}
difference() {
translate([30,0,0]) rotate([0,20,0])
  difference() {
    union() {
      cylinder(d1=10,d2=37,h=40,$fn=60);
      intersection() {
        translate([0,0,40]) sphere(d=37,$fn=60);
        translate([-20,-20,40]) cube(40);
      }
      translate([0,0]) intersection() {
        translate([-40,-20,40]) cube(60);
        translate([0,0,40]) rotate([0,-20,0]) cylinder(d1=35,d2=38,h=40,$fn=60);
      }
    }
    translate([2,0,34]) rotate([0,-20,0]) cylinder(d1=30,d2=32.5,h=50,$fn=50);
    translate([0,0,-.01]) cylinder(d1=5,d2=32,h=40.02,$fn=50);
  }
    rotate_extrude() {
      translate([30,0]) circle(d=8,$fn=30);
    }
}
}
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