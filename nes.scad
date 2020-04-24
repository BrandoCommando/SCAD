part="bottom";
colors="gray";
bh=17.5;
bd=91;
bottom_fan=25;
gpio_slot=1;
extra_usb_slot=0;

if(part=="bottom") {
if(colors=="black"||colors=="both")
color(colors=="both"?"black":"gold") {
  if(colors=="black")
  {
    translate([bd+10,10.1,0]) rotate([0,-90]) difference() {
      union() {
        translate([0,0,0]) cube([4.3,7.8,5]);
        translate([0,-1,4]) rotate([90,0,90]) linear_extrude(4.3) polygon([[0,0],[1,1],[8.8,1],[9.8,0]]);
      }
      translate([2.15,3.9,2.7]) cylinder(d=4,h=2.01,$fn=20);
      translate([-.01,.8,3]) cube([6.2,6.2,3]);
      *translate([-.01,2.15,3.01]) cube([5,3.5,1]);
      *translate([-.01,1.9,1.1]) cube([5,4.1,2.02]);
    }
    translate([bd+10,20.1,0]) rotate([0,-90]) difference() {
      translate([0,0,0]) union() {
          translate([0,0,0]) cube([4.3,7.8,5]);
          translate([0,-1,4]) rotate([90,0,90]) linear_extrude(4.3) polygon([[0,0],[1,1],[8.8,1],[9.8,0]]);
        }
      translate([2.15,3.9,2.7]) cylinder(d=4,h=2.01,$fn=20);
      translate([-.01,.8,3]) cube([6.2,6.2,3]);
      *translate([-.01,2.15,3.01]) cube([5,3.5,1]);
      *translate([-.01,1.9,1.1]) cube([5,4.1,2.02]);
    }
  }
  *translate([bd-4,10,5]) cube([6,8,4.5]);
  *translate([bd-4,20,5]) cube([6,8,4.5]);
  scale(0.9) translate([bd-1.02,59]) rotate([0,colors=="both"?0:-90]) difference() {
    translate([0,1]) linear_extrude(bh+.03) polygon([[2,0],[0,-2],[0,16],[2,14]]);
    *cube([2.03,17,bh+.01]);
    if(extra_usb_slot)
      translate([-.01,1,bh-13.2]) cube([3,15,13.3]);
  }
  scale(0.9) translate([-.01,60]) rotate([0,colors=="both"?0:90]) linear_extrude(bh+.03) polygon([[0,0],[2,-2],[2,16],[0,14]]);
  *translate([-.01,60]) cube([2.02,14,bh+.01]);
}
if(colors=="gray"||colors=="both")
color("gray")
difference(){
intersection(){
  translate([0,4]) rotate([0,90,0]) rotate([0,0,90]) linear_extrude(bd+1) polygon([[-1,0],[-4,11],[-4,bh],[76,bh],[76,11],[73,0]]);
  union(){
    translate([bd-7,2,9.5]) {
      translate([3,0,3]) rotate([-90,0]) linear_extrude(14) polygon([[0,0],[3,0],[3,3]]);
      translate([0,0,-9.5]) cube([6,2,12.5]);
      *cube([6,14,3]);
    }
    translate([82.5,43]) cube([8,16,12.5]);
translate([0,0,11]) difference() { // left
  cube([bd+1,2,bh-11]);
  translate([8,-0.01,2.4]) cube([9.5,2.02,6]);
  translate([26,-.01,3]) cube([16.5,2.02,4]);
  translate([55.7,-.01,6]) rotate([-90,0]) cylinder(d=7,h=4,$fn=30);
}
translate([0,3,0]) rotate([15,0]) cube([92,2,11.4]);
translate([0,78,11]) difference() {
  cube([bd+1,2,bh-11]); // right
  if(gpio_slot)
    translate([8,-.01,bh-15]) cube([52,2.02,10]);
}
translate([0,77,0]) mirror([0,1,0]) rotate([15,0]) cube([92,2,11.4]);
difference(){
  translate([0,3,0]) cube([bd+1,74,2]);
  if(bottom_fan>0)
  translate([42-bottom_fan/2,33-bottom_fan/2,-.01]) {
    
    intersection(){
      translate([bottom_fan/2,bottom_fan/2]) cylinder(d=bottom_fan,h=3,$fn=50);
    for(i=[0:bottom_fan/4]) translate([0,4*i]) cube([bottom_fan,2,2.02]);
    }
  }
}
difference(){ // back
  translate([0,4]) rotate([0,90,0]) rotate([0,0,90]) linear_extrude(2) polygon([[0,0],[-3,11],[-3,bh],[75,bh],[75,11],[72,0]]);
  translate([-.01,24,11]) {
    cube([4.02,14,2]);
    translate([2,0]) mirror([1,0]) {
    rotate([0,-45]) cube([4.02,14,1.4]);
    mirror([0,0,1]) translate([0,0,-2]) rotate([0,-45]) translate([0,0]) cube([4.02,14,1.4]);
    }
  }
  translate([-.01,8,13]) cube([2.02,6,3]);
}
translate([bd-9,10.4,2]) {
  cube([4,6,8]);
  translate([0,-1,0]) cube([9,18,2]);
}
translate([bd-9,20.4,2]) cube([4,6,8]);
difference(){ // front
  translate([bd-1,4]) rotate([0,90,0]) rotate([0,0,90]) linear_extrude(2) polygon([[0,0],[-3,11],[-3,bh],[75,bh],[75,11],[72,0]]);
  translate([bd-1.01,3,14]) cube([3,55,5]);
  translate([bd-3,9.8,4.9]) cube([6,7.8,4.6]);
  translate([bd-3,19.8,4.9]) cube([6,7.8,4.6]);
  translate([bd-3,6.5,7.2]) rotate([0,90,0]) cylinder(d=4.5,h=6,$fn=16);
}
translate([5.7,5.75]) {
  translate([0,0.5,2]) difference(){
    cylinder(d1=8,d2=6,h=10.5,$fn=20);
    cylinder(d=2.5,h=15,$fn=16);
  }
  translate([0,49.4,2]) difference(){
    cylinder(d1=8,d2=6,h=10.5,$fn=20);
    cylinder(d=2.5,h=15,$fn=16);
  }
  translate([58,0.5,2]) difference(){
    cylinder(d1=8,d2=6,h=10.5,$fn=20);
    cylinder(d=2.5,h=15,$fn=16);
  }
  translate([58,49.4,2]) difference(){
    cylinder(d1=8,d2=6,h=10.5,$fn=20);
    cylinder(d=2.5,h=15,$fn=16);
  }
}
}
}
translate([-.02,60,-.01]) {
  linear_extrude(bh+.03) polygon([[0,0],[2.04,-2],[2.04,16],[0,14]]);
  *cube([2.04,14,bh+.03]);
}
translate([bd-1.01,59,-.01]) {
  translate([0,1]) linear_extrude(bh+.03) polygon([[0,-2],[2.04,0],[2.04,14],[0,16]]);
  *cube([2.04,17,bh+.03]);
}
translate([5.7,5.75]) {
  translate([0,0,-.01]) cylinder(d1=5.5,d2=5,h=10.02,$fn=20);
  translate([0,49.4,-.01]) cylinder(d1=5.5,d2=5,h=10.02,$fn=20);
  translate([58,0,-.01]) cylinder(d1=5.5,d2=5,h=10.02,$fn=20);
  translate([58,49.4,-.01]) cylinder(d1=5.5,d2=5,h=10.02,$fn=20);
}
}
}