ring_od = 80;
arc_deg = 15;
seg_mult = .1;
can_h = 100;
screw_t = 4;
screw_bore = 2;
screw_deg = .5;
module cap() {
for(seg=[0:(720/arc_deg)-1])
{
  rotate([0,0,arc_deg*seg]) translate([0,0,seg_mult*seg])
  rotate([0,screw_deg,0]) ring_deg(ring_od,screw_t,screw_bore,arc_deg);
}
difference(){
  translate([0,0,-4]) cylinder(d=ring_od+screw_t,h=9,$fn=80);  
  translate([0,0,0])
    cylinder(d=ring_od,h=6.01,$fn=80);
}
}

cap();
//can();
module can(){
  difference(){
    cylinder(d=ring_od-screw_t-.2,h=can_h,$fn=90);
    translate([0,0,-0.01]) cylinder(d=ring_od-screw_t-4,h=can_h+0.02,$fn=90);
  }
  for(seg=[0:(720/arc_deg)-1])
  {
    rotate([0,0,arc_deg*seg]) translate([0,0,seg_mult*seg])
    rotate([0,screw_deg,0]) ring_deg(ring_od-.2,screw_t,screw_bore,arc_deg,false);
  }
}

module ring_deg(od,t,h,deg,thread_in=true)
{
  deg=deg%360;
  intersection()
  {
  difference(){
    if(thread_in)
      cylinder(d=od,h=h,$fn=od*1.5);
    else
      translate([0,0,h/2]) cylinder(d2=od,d1=od-t,h=h,$fn=od*1.5);
    //translate([0,0,h/2]) cylinder(d1=od-t,d2=od-t,h=h+0.02,$fn=(od-t)*1.5);
    if(thread_in)
      translate([0,0,-0.01+h/2]) cylinder(d2=od-t,d1=od,h=h+0.02,$fn=(od-t)*1.5);
    else
      translate([0,0,-0.01]) cylinder(d=od-t,h=h+0.02,$fn=(od-t)*1.5);
  }
  translate([0,0,h/2]) linear_extrude(h)
  if(deg<90)
    polygon([[0,0],[0,od],
      [sin(deg)*(od),cos(deg)*(od)]]);
  else if(deg<180)
    polygon([[0,0],[0,od],[od,od],
      [sin(deg)*od,cos(deg)*od]]);
  else if(deg<225)
    polygon([[0,0],[0,od],[od,od],[od,-1*od],
      [sin(deg)*od,cos(deg)*od]]);
  else if(deg<315)
    polygon([[0,0],[0,od],[od,od],[od,-1*od],[-1*od,-1*od],
      [sin(deg)*od,cos(deg)*od]]);
  else
    polygon([[0,0],[0,od],[od,od],[od,-1*od],[-1*od,-1*od],[-1*od,0],
      [sin(deg)*od,cos(deg)*od]]);
  }
}