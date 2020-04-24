cylh=40;
od=24;
id=20;
id2=14;
lip=6;
lip2=2;
corr=0;
$fn=80;

difference(){
  union(){
      translate([10,12.5]) cylinder(d=32,h=cylh,$fn=50);
    //translate([-2.5,0,0])
      //cube([25,25,27]);
    *translate([10,12.5,25]) cylinder(d=32,h=cylh-25,$fn=40);
  }
  translate([10,12.5,2]) cylinder(d1=25,d2=30.6,h=2.01,$fn=40);
  translate([10,12.5,4]) cylinder(d=30.6,h=cylh-18.99,$fn=40);
  translate([2.5,2,-.01])
    cube([15,21,cylh+.02]);
  translate([0,2,2])
    cube([20,21,cylh+.01]);
  translate([10,12.5,25]) {
    cylinder(d1=30.6,d2=24,h=7,$fn=40);
    cylinder(d=24,h=cylh-24.99,$fn=40);
  }
}
*difference(){
  union(){
  translate([10,12.5,27]) rotate([0,0,45]) cylinder(d1=35,d2=30,h=5,$fn=4);
  intersection(){
  translate([10,12.5,30]) rotate([0,0,45]) cylinder(d=30,h=7,$fn=4);
  translate([10,12.5,27]) cylinder(d=24,h=10,$fn=30);
  }
  }
  translate([10,12.5,25]) cylinder(d=id-corr-4,h=50,$fn=30);
}
*translate([10,12.5,37]) difference(){
  union(){
    intersection()
    {
      cylinder(d1=id-corr,d2=id-corr+2,h=lip);
      minkowski(){
        sphere(2);
        cylinder(d1=id-corr-4,d2=id-corr-3,h=lip-2);
      }
    }
    //cylinder(d=od+1.2+corr,h=1.2);
    difference(){
      cylinder(d1=od+1.2+corr,d2=od,h=lip2);
      translate([0,0,0.1]) intersection() {
       cylinder(d1=od+corr,d2=od+corr-1.2,h=lip+1);
        minkowski(){
          sphere(1);
          translate([0,0,2]) cylinder(d=od+corr-2,h=lip);
        }
      }
    }
  }
  translate([0,0,-0.1]) cylinder(d=id2,h=lip+1);
  *translate([-7.5,-10,-.01]) cube([15,20,10]);
}
