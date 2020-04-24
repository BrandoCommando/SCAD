//mirror([0,0,1])
//rotate([0,0,45])
//for(m=[0,1]) mirror([m,0]) translate([1,0]) arm(m);
rotate([0,90]) arm(1);
//half();
//translate([0,0,22]) mirror([0,0,1]) half(1);
module half(top=0)
{
    for(r=[0:90:359])
      rotate([0,0,r]) translate([20,0,10]) rotate([0,90,0])
        arm(top);
}

module arm(top=0) {
  intersection() {
    translate([-1,-25,-10]) cube([11,50,100]);
  difference() {
    union() {
      translate([0,0,80]) rotate([0,-90,0]) intersection() { 
        union() {
        translate([0,0,-12]) cylinder(d1=16,d2=20,h=12,$fn=40);
          cylinder(d=20,h=1,$fn=40);
        }
        *sphere(d=24,$fn=40);
      }
      intersection(){
        translate([-1,-30,-10]) cube([20,60,90]);
        translate([-1,0,-10]) union() {
          cylinder(d1=40,d2=22,h=80,$fn=60);
          translate([0,0,80]) cylinder(d1=22,d2=18,h=10,$fn=60);
        }
      }
      *translate([0,0,-20]) rotate([0,90]) cylinder(d=80,h=10,$fn=100);
    }
    rotate([0,-90]) {
      translate([80,0,-9]) cylinder(d=9,h=20,$fn=24);
      translate([80,0,-20]) cylinder(d=7,h=20,$fn=20);
      translate([0,0,-16]) for(pos=[[71,0],[-6,14],[-6,-14]]) translate(pos) {
        cylinder(d=3,h=30,$fn=20);
        if(!top)
          rotate([0,0,0]) cylinder(d=7.8,h=8,$fn=4);
        else cylinder(d=7,h=9,$fn=30);
      }
    }
    translate([-0.8,0,-4]) battery(top=top);
  }
}
}

module battery(type="18650",neg=1,top=0)
{
  noff=neg?4:0;
  if(type=="18650") {
    cylinder(d=18+(neg?0.5:0),h=65+noff,$fn=40);
    if(neg)
    {
      for(m=[0,1]) translate([0,0,m?65+noff:0]) mirror([0,0,m]) {
        translate([-5,-5,-1.7]) cube([10,10,1]);
        if(top)
          translate([0,-2,-1.7]) cube([11.02,4,1]);
        translate([0,0,-.71]) cylinder(d=8,h=2.02,$fn=30);
        translate([-1,-5,-1.2]) cube([2,10,2]);
      }
    } else
    translate([0,0,64.99+noff]) cylinder(d=6,h=1.4,$fn=20);
  }
}