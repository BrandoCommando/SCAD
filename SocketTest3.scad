module socket(w=20,l=20,h=14,d=3/8)
{
  difference() {
    cube([w+2,l+2,h],center=true);
    translate([0,0,2])
      cylinder(r=w/2,h,$fn=50,center=true);
  }
  notch(w,l,h,d);
}
module notch(w=20,l=20,h=14,d=3/8)
{
  dm=25.4*d; //25.4
  ch=h;
  intersection(){
  cube([dm,dm,ch],center=true);
    union(){
    translate([0,0,-1])
    sphere(d=dm+6);
      translate([0,0,-1*ch/4])
        cube([dm,dm,ch],center=true);
    }
    cylinder(r=dm*19/32,h=h,$fn=80,center=true);
  }
  //translate([dm/2,0,(ch/2)-3])
  //sphere(dm/10,$fn=50,center=true);
}
translate([0,0,-2.69]) rotate([-90,22.5,0]) cylinder(d=5,h=90,$fn=8);
for(i=[0:5]) {
    translate([0,18*i,0]) notch(h=10);
}
