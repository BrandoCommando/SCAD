V=100000;
h=50;
r=sqrt(V/(h*3.14159267));
echo(str("r:",r));
difference() {
  union() {
  skin(1.05) translate([0,0,-62.02]) beaker(r+1.61,h+2,6);
  for(z=[15:5:50]) translate([0,0,z-70]) rotate_extrude($fn=80) translate([r*1.1+.2,0]) circle(d=1.2,$fn=20);
  }
  for(z=[15:5:50]) translate([0,0,z-70]) rotate_extrude($fn=80) translate([r*1.1-1,0]) circle(d=1.2,$fn=20);
}
//skin(1.1) scale(0.9)
//translate([80,0])
translate([0,0,-60]) beaker(r,h,5);

module beaker(r=50,h=50,bottomround=5,toplip=1) {
  if(bottomround)
    rotate_extrude($fn=80) {
      difference() {
        union() {
          if(toplip)
          {
            polygon([[0,0],[r-bottomround,0],[r-bottomround,bottomround],[r,bottomround],[r,h+3],[r+3,h+8],[r+3,h+10],[0,h+10]]);
            translate([r+3,h+9]) scale([0.75,1]) circle(r=1,$fn=20);
          }
          else {
            square([r-bottomround,h+10]);
            translate([0,bottomround]) square([r,h+10-bottomround]);
          }
          translate([r-bottomround,bottomround]) circle(r=bottomround,$fn=30);
        }
        translate([r+3,h+3]) scale([1,1.675]) circle(d=6,$fn=30);
      }
    }
  else
    cylinder(r=r,h=h+10,$fn=80);
  translate([0,0,10]) intersection() {
    translate([r-12,0,h+5]) rotate([0,-60]) rotate([0,90]) rotate([0,0,-45]) cube(30,center=true);
    cylinder(r=r+10,h=h,$fn=40);
  }
}
module skin(ratio=1.1) {
  difference() {
    scale(ratio) children();
    translate([0,0,.01]) children();
  }
}