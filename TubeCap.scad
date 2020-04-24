od=24;
id=20;
id2=14;
lip=6;
lip2=2;
corr=0;
$fn=80;

difference(){
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
  translate([-7.75,-8,-.01]) cube([14.5,16,10]);
}
