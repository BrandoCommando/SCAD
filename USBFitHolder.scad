thick=1.6;
main_arr=[12.6,5.4,11.4];
difference() {
  minkowski() {
    cube(main_arr);
    union(){
    cylinder(r=thick,h=thick-.01,$fn=20);
    sphere(r=thick,$fn=20);
    }
  }
  translate([0,0,thick]) cube(main_arr);
}
*translate([main_arr[0]/2-3,0,main_arr[2]+thick-.01]) {
  cube([6,thick,10]);
  translate([0,0,8]) cube([6,thick+.5,2]);
}
translate([0,main_arr[1],main_arr[2]+9]) difference() {
  hull() {
    translate([0,0]) cube([main_arr[0],2,1]);
    translate([main_arr[0]/2,0,5]) rotate([-90,0]) cylinder(d=main_arr[0]-6,h=2,$fn=30);
  }translate([main_arr[0]/2,-.01,5]) rotate([-90,0]) cylinder(d=3,h=2.02,$fn=30);
  
}
translate([0,main_arr[1],main_arr[2]+thick-.01]) difference()
{
    hull() {
    intersection() {
      translate([0,0,-3]) cube([main_arr[0],7,11.2]);
      translate([-.01,-2,3.5]) rotate([0,90]) scale([1,.9]) cylinder(r=4+thick*1.5,h=main_arr[0]+thick*2+.02,$fn=40);
    }
      *translate([0,-2]) cube([main_arr[0]+thick*2,7,12]);
      translate([0,0,-5]) cube([main_arr[0],thick,2]);
    
    }
    translate([0,-main_arr[1]-thick,-main_arr[2]-thick]) translate([thick,thick,thick]) cube([main_arr[0],main_arr[1],main_arr[2]+2]);
    translate([-.01,-2,3.5]) rotate([0,90]) scale([1,.9]) cylinder(r=4,h=main_arr[0]+thick*2+.02,$fn=40);
}