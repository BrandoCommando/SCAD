pod=25.4*6.625;
xmin=pod/2-7.15;
xmax=pod/2+60;
zmax=180;
zclimb=52;
echo(str("POD:",pod));
intersection() {
  cylinder(d=pod+xmax+10,h=zmax,$fn=20);
difference() {
  translate([0,0,.01]) union() {
    *rotate_extrude($fn=100) {
      polygon([[30,0],[40,0],[50,15],[60,105],[60,135],[50,180],[40,195],[30,195]]);
      translate([35,193]) circle(d=11,$fn=20);
    }
    translate([xmax,0]) {
      translate([0,0,4]) cylinder(d=16,h=zmax-zclimb-4,$fn=32);
      intersection() {
        cylinder(d=16,h=4,$fn=32);
        translate([0,0,4]) sphere(d=16,$fn=32);
      }
      translate([0,0,80]) {
        *sphere(d=16,$fn=32);
        *translate([0,0,3]) rotate([0,-60,0]) cylinder(d=10,h=62,$fn=24);
      }
    }
    hull() {
      translate([xmax,0,zmax-zclimb]) sphere(d=16,$fn=32);
      translate([xmin+10,0,zmax-7]) sphere(d=10,$fn=32);
    }
    rotate([0,0,-2]) rotate_extrude(angle=4) {
      polygon([[xmin-20,0],[xmin-20,zmax+8],[xmax,zmax-zclimb],[xmax,0]]);
    }
    *translate([50,-5,100]) cube([9,10,8]);
    translate([xmin,-15,0]) {
      intersection() {
        rotate([-90,0]) rotate([0,270,180]) linear_extrude(10,convexity=4) {
          hull() {
          for(x=[-5,35],y=[zmax-8,2.5])
            translate([x,y]) circle(d=5,$fn=25);
          *polygon([[-5,zmax-5.5],[10,zmax-4],[20,zmax-4],[35,zmax-5.5],[35,0],[0,0]]);
            translate([15,zmax-6]) circle(d=8,$fn=30);
          }
        }
        translate([-1*xmin,15]) rotate_extrude($fn=100) translate([xmin,0]) square([10,zmax]);
      }
    }
    *rotate([0,0,-15]) rotate_extrude(angle=30,$fn=100) {
      translate([xmin,0]) square([10,zmax-12]);
    }
  }
  #cylinder(d=pod,h=200,$fn=200);
  for(r=[-10,10],z=[8,zmax/2,zmax-12]) rotate([0,0,r]) translate([pod,0,z]) rotate([0,-90,0]) cylinder(d=4,h=pod,$fn=24);
}
}