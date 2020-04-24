part="A"; // ["A":"Small Cube (8,0,3)","D30":"Ornate Arch"]
thick_small_arch(1);
*cube2([20,20,20]);
ornate_arch(1);
module thick_small_arch(rotprint=0) {
  *translate([0,0,.0085]) import("einsteins_anker_blocks/STL/d28.stl");
  rotate(rotprint?[-90,0,90]:[]) difference() {
  cube2([40,20,20]);
  translate([20-0.25,0,-.01]) {
    cylinder(d=19.5,h=20.02,$fn=32);
    for(z=[-.25,20]) translate([0,0,z]) {
      for(r=[22.5,68,112.5,157.5]) rotate([0,0,r]) rotate([0,90]) cylinder(d=1.5,h=18,$fn=20);
      //*cylinder(d1=40.8,d2=39.5,h=.5,$fn=32);
      *translate([0,0,19])
        cylinder(d1=39.5,d2=40.8,h=.51,$fn=32);
      translate([0,0.0,-.2]) {
        rotate_extrude($fn=40) {
          translate([9.75,0]) circle(d=1.5,$fn=20);
          translate([18,0]) circle(d=1.5,$fn=20);
        }
      }
    }
  }
}
}
module ornate_arch(rotprint=0) {
  *import("einsteins_anker_blocks/STL/d30.stl");
  rotate(rotprint?[-90,0,90]:[]) difference() {
  cube2([60,40,20]);
  translate([30-0.25,0,-.01]) {
    cylinder(d=39.5,h=20.02,$fn=32);
    translate([0.5,0]) for(r=[17.5,180-19.5,90-9.5,90+10.5]) rotate([0,0,r]) translate([0,0,20]) rotate([0,90]) cylinder(d=1.5,h=42,$fn=20);
    translate([1,0]) rotate([0,0,122]) translate([0,0,20]) rotate([0,90]) {
      cylinder(d=1.5,h=35,$fn=20);
      translate([0,0,35]) {
        rotate([270+32,0]) translate([0,0,-.1]) cylinder(d=1.5,h=20,$fn=20);
        rotate([32,0]) translate([0,0,-.1]) cylinder(d=1.5,h=20,$fn=20);
      }
    }
    translate([1,0]) rotate([0,0,61.75]) translate([0,0,20]) rotate([0,90]) {
      cylinder(d=1.5,h=33.2,$fn=20);
      translate([0,0,33]) {
        rotate([-27.25,0]) translate([0,0,-.1]) cylinder(d=1.5,h=20,$fn=20);
        rotate([-27.25+90,0]) translate([0,0,-.1]) cylinder(d=1.5,h=20,$fn=20);
      }
    }
    translate([0,-1]) rotate([0,0,43]) translate([0,0,20]) rotate([0,90]) {
      cylinder(d=1.5,h=30.5,$fn=20);
      translate([0,-.25,30]) {
        rotate([-47,0]) translate([0,0,-.1]) cylinder(d=1.5,h=9.8,$fn=20);
        rotate([43,0]) translate([0,0,-.1]) cylinder(d=1.5,h=20,$fn=20);
      }
    }
    translate([-.2,0]) rotate([0,0,90+49.5]) translate([0,0,20]) rotate([0,90]) {
      translate([0,-.15]) rotate([-.5,0]) translate([0,-0.5,0]) cylinder(d=1.5,h=30,$fn=20);
      translate([0,-.25,29.8]) {
        rotate([-40.5,0]) translate([0,0,-.1]) cylinder(d=1.5,h=9.8,$fn=20);
        rotate([49.5,0]) translate([0,0,-.1]) cylinder(d=1.5,h=10.3,$fn=20);
      }
    }
    translate([0,0,-.25]) for(r=[22.5,68,112.5,157.5]) rotate([0,0,r]) rotate([0,90]) cylinder(d=1.5,h=28.2,$fn=20);
    //*cylinder(d1=40.8,d2=39.5,h=.5,$fn=32);
    translate([0,0,19])
      cylinder(d1=39.5,d2=40.8,h=.51,$fn=32);
    translate([0,0.0,-.2]) {
      rotate_extrude($fn=40) {
        translate([19.75,0]) circle(d=1.5,$fn=20);
        translate([28,0]) circle(d=1.5,$fn=20);
      }
    }
  }
}
}

module cube2(dims,r=.75,trim=.5)
{
  intersection(){
    cube([dims[0]-trim,dims[1]-trim,dims[2]-trim]);
    translate([r,r,r])
      minkowski() {
        cube([dims[0]-trim-r*2,dims[1]-trim-r*2,dims[2]-trim-r*2]);
        sphere(r=r,$fn=16);
      }
  }
}