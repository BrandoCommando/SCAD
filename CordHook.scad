//profile();
horn(40,100,lchopoff=5.5,sphr=.75,holes_flipped=1,cutover=10);
module horn(thick=40,dia=150,lchopoff=5,sphr=2,holes_flipped=0,cutover=0)
{
  lchop=dia*-.5+lchopoff;
  cut=cutover>0?cutover:dia/10;
  echo(str("dia:",dia," lchop:",lchop," cut:",cut));
  half=thick/2;
translate([0,0,half]) difference() {
  union() {
    *translate([lchop-5,-30,-half]) cube([8,30,thick]);
    intersection() {
      scale([1,1,sphr]) sphere(d=dia,$fn=dia);
      translate([lchop,dia*-.5,-half]) cube([dia,dia/2,thick]);
    }
    translate([lchop+5,0,-half]) {
      intersection() {
        cylinder(d=10,h=thick,$fn=40);
        union() {
          translate([0,0,3]) cylinder(d=10,h=thick-6,$fn=40);
          translate([0,0,3]) sphere(d=10,$fn=40);
          translate([0,0,thick-3]) sphere(d=10,$fn=40);
        }
      }
    }
    translate([dia*.5-10,0,-half]) {
      translate([-.5,0])
        cylinder(d=10,h=thick,$fn=40);
      cube([10,5,thick]);
      translate([-0,5]) difference() {
        cube([5,5,thick]);
        translate([0,5,-1]) cylinder(d=10,h=thick+2,$fn=30);
      }
    }
    //mirrorx()
    translate([dia*.5-15,dia*-.2,-half]) cube([15,dia*.2,thick]);
    translate([dia*.5-5,0,-half]) cube([5,33,thick]);
    if(thick<30)
      translate([dia*.5-5,-44,-half]) cube([5,50,thick]);
  }
  grade=[1,.99,.96,.9,.8];
  difference() {
    translate([0,0,-half-1]) scale([1,1,1]) {
      *mirrorz(thick+2) {
      *for(gz=[0:thick/2])
        translate([0,0,gz-1])
        {
          
          *cylinder(d2=dia+10*(pow(2,gz+1)),d1=dia+10*(pow(2,gz)),h=1.01,$fn=100);
        }
      cylinder(d1=dia-10,d2=dia-20,h=5,$fn=100);
      translate([0,0,3]) cylinder(d1=dia-16,d2=dia-20,h=4,$fn=100);
      }
      difference() {
        cylinder(d=dia-16,h=thick+2,$fn=100);
        translate([0,0,half+1]) rotate_extrude($fn=100) {
          translate([dia/2-8,0]) scale([.75,2.2]) {
            translate([0,-cut]) square([cut,cut*2]);
            circle(d=cut*2,$fn=50);
          }
        }
      }
    }
    *translate([lchop-5,-30,-half]) cube([10,30,thick]);
  }
  if(thick<30)
    for(y=[16,-35])
    translate([dia*.5-5.01,y,0]) rotate([0,90]) screw_hole(d=12,flip=holes_flipped);
  else
  mirrorz() translate([dia*.5-5.01,16,thick*-.5+10]) rotate([0,90]) screw_hole(d=12,flip=holes_flipped);
  }
}
module screw_hole(d=20,flip=0)
{
  for(y=[0:2:8])
    translate([0,y]) cylinder(d1=9,d2=5,h=3,$fn=30);
  linear_extrude(d) {
     translate([0,flip?8:0]) circle(d=9,$fn=30);
     hull() {
       circle(d=5,$fn=20);
       translate([0,8]) circle(d=5,$fn=20);
     }
   }
}
module profile(h=10)
{
linear_extrude(h) {
  difference() {
    union() {
      square([120,60]);
      translate([60,0]) scale([1,.25]) circle(d=120,$fn=100);
    }
    translate([60,30]) scale([2,1]) circle(d=50,$fn=50);
    translate([10,30]) square([100,31]);
  }
}
}
module mirrorx(off) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([-off/2,0]) children();
}
module mirrorz(off) {
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,-off/2]) children();
}