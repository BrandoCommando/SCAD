battery_type="AA";
signature="Alex";
height=150;
add_wings=1;

depth=(battery_type=="AA")?40:34;
batteryd=battery_type=="AA"?15:13;
difference() {
  box(56,depth,height,r=4,bottom=0,top=0);
  translate([2,2,4]) box(52,depth-4,height,r=3,bottom=1,top=0);
  translate([2,5.99,4]) rotate([90,0]) linear_extrude(6)
  minkowski(){
    polygon([[3,3],[3,14],[22,40],[30,40],[49,14],[49,3]]);
    circle(3,$fn=20);
  }
  translate([1,depth/2,height/2]) rotate([0,90,180]) rotate([0,0,180]) linear_extrude(2) text(signature,halign="center",valign="center");
}
translate([0,-1*batteryd-1,0]) difference() {
  box(56,24,batteryd+4,r=4,bottom=0);
  translate([2,2,4]) box(52,30,30,r=3);
  translate([-0.01,2.5,15]) cube([60,15,15]);
  translate([-0.01,batteryd/2+2.5,16]) rotate([0,90]) cylinder(d=batteryd,h=60,$fn=30);
}
translate([2,depth-22,22]) rotate([0,90]) linear_extrude(52) polygon([[20,0],[20,20],[0,20]]);
translate([28,0,30+(height-30)/2]) rotate([90,0]) linear_extrude(2) text(battery_type,halign="center",size=len(battery_type)>2?16:20);
if(add_wings)
difference() {
  translate([-15,depth]) union() {
    arm();
    translate([0,0,height]) mirror([0,0,1]) arm();
    translate([86,0,0]) mirror([1,0]) arm();
    translate([86,0,height]) mirror([0,0,1]) mirror([1,0]) arm();
  }
  translate([2,2,4]) box(52,depth-4,height,r=3,bottom=1,top=0);
}

module arm()
{
  translate([5,0,5]) rotate([90,0]) difference(){
    linear_extrude(5) {
      circle(d=10,$fn=20);
      polygon([[-5,0],[-5,5],[14,30],[14,-5],[0,-5]]);
    }
    translate([0,0,-.01]) cylinder(d=4,h=5.02,$fn=20);
    translate([0,0,3]) cylinder(d1=4,d2=8,h=2.01,$fn=30);
    }
}

module box(w,h,d,r=1,top=1,bottom=1)
{
  intersection(){
    cube([w,h,d]);
    minkowski() {
      translate([r,r,bottom?r:0]) cube([w-r*2,h-r*2,d-r*((top?1:0)+(bottom?1:0))]);
      sphere(r,$fn=10+r*6);
    }
  }
}