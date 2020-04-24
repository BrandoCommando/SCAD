part="all"; // [top,bottom,all]
th=5;
od=82;
id=77;
if(part=="top"||part=="all"){
translate([0,id/2]) cube([od,(od-id)/2,th]);
translate([20,id/2+(od-id)/2]) rotate([90,0]) difference(){
  box(od-40,20,(od-id)/2,5,0,0);
  translate([(od-40)/2-14,14,-.01]) cylinder(d=4,h=5,$fn=20);
  translate([(od-40)/2+14,14,-.01]) cylinder(d=4,h=5,$fn=20);
}
difference(){
  cylinder(d=od,h=th,$fn=140);
  translate([0,0,-0.01]) cylinder(d=id,h=th+1,$fn=140);
}
translate([od-1,0]) difference(){
  cylinder(d=od,h=th,$fn=140);
  translate([0,0,-0.01]) cylinder(d=id,h=th+1,$fn=140);
}
}
%translate([0,0,-100]) cylinder(d=76,h=240,$fn=100);
%translate([od,0,-100]) cylinder(d=76,h=240,$fn=100);
if(part=="bottom"||part=="all") {
translate([0,0,-110]) {
  cylinder(d1=60,d2=40,h=10,$fn=120);
  translate([od-1,0])
    cylinder(d1=60,d2=40,h=10,$fn=120);
  cube([od-1,od/2,2]);
  translate([20,id/2+(od-id)/2]) rotate([90,0]) difference(){
    box(od-40,20,(od-id)/2,5,0,0);
    translate([(od-40)/2-14,14,-.01]) cylinder(d=4,h=5,$fn=20);
    translate([(od-40)/2+14,14,-.01]) cylinder(d=4,h=5,$fn=20);
  }
}
}
module box(w,d,h,r=1,top=1,bottom=1)
{
  intersection(){
    cube([w,d,h]);
    minkowski(){
      translate([r,r,bottom?r:0]) cube([w-r*2,d-r*2,h-(top?r:0)-(bottom?r:0)]);
      sphere(r,$fn=30);
    }
  }
}