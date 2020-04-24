arms=4;
boltd=8.4; // [6.8:1/4",8.4:5/8"];
nutd=14.7; // [13.1:1/4",14.7:5/8"];
od=70;
th=25;
es=.35;
topnut=0;
intersection() {
  cylinder(d=od,h=th,$fn=100);
difference() {
  union() {
    linear_extrude(8,convexity=3) difference() {
      circle(d=od,$fn=100);
      circle(d=od-3,$fn=100);
    }
    cylinder(d=boltd+4,h=80,$fn=40);
    cylinder(d=nutd+5,h=8,$fn=40);
    translate([0,0,8]) cylinder(d1=nutd+5,d2=boltd+4,h=9,$fn=40);
    *translate([0,0,76]) difference() {
      cylinder(d=26,h=4,$fn=50);
      translate([0,0,-.01]) cylinder(d=18,h=4.02,$fn=50);
    }
    *translate([0,0,topnut?0:5]) {
    translate([0,0,th-10]) cylinder(d=boltd+24,h=10,$fn=40);
    translate([0,0,th-26]) cylinder(d1=boltd+4,d2=boltd+24,h=16,$fn=40);
    }
    for(r=[0:360/arms:359])
      rotate([0,0,r])
      {
        *rotate([0,0,60]) translate([0,-2,th-24]) cube([24,4,4]);
        translate([0,4])
          rotate([0,0,0]) {
            rotate([0,90]) mirror([1,0]) linear_extrude(od/2) mirror([0,0,0]) translate([0,-7.5]) polygon([[0,0],[8,4],[8,8],[0,1]]); //square([8,4]);
          }
        *translate([0,0,8])
        scale([1,1,1])
        linear_extrude(height=th-16,center=false,convexity=10,twist=-90,scale=[1,es],$fn=th*2) translate([od/2-6,.5]) square([8,4]);
      }
  }
  union(){
  translate([0,0,-.01]) cylinder(d=nutd,h=9,$fn=6);
  translate([0,0,8.98]) cylinder(d1=nutd,d2=boltd,h=8,$fn=6);
  translate([0,0,-.01]) cylinder(d=boltd,h=120,$fn=30);
    if(topnut)
    translate([0,0,th-8]) cylinder(d=nutd,h=8.02,$fn=6);
}
}
}