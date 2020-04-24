part = "dresser"; // [drawer,dresser]
notch_mode = false;
walls=1.2;
tw=80;
th=90;
td=17.6;
roundness=2;
knob_halign="middle"; // [left,middle,right]
knob_valign="middle";
knob_depth=12;
knob_width=2;
notch_depth=5;
pockets_deep=1;
pockets_wide=1;
dresser_high=5;
dresser_wide=1;

if(part=="dresser")
{
  translate([0,0,th+walls*2]) rotate([-90,0,0])
  {
  //difference()
    {
    if(!notch_mode)
      difference() {
        cube([tw+walls*6,th+walls*4,walls*5+(td+walls*2)*dresser_high+1]);
        for(d=[1:dresser_high])
        {
          translate([walls,-.01,walls+((d-1)*(td+walls*3))]) cube([tw+walls*4,th+walls*3,td+walls*2]);
        }
      }
    else {
      difference(){
        cube([tw+walls*2+notch_depth*2,th+walls*2,walls*5+(td+walls*2)*dresser_high]);
        translate([notch_depth,-.01,walls*2]) cube([tw+walls*2,(th+walls)*dresser_high,(td+walls*2)*dresser_high-walls*2]);
        for(d=[1:dresser_high])
        {
          color("red")
          translate([walls,-.01,walls+((d-1)*(td+walls*3))]) cube([tw+notch_depth*2,th+walls,walls*8]);
          translate([notch_depth,-0.01,walls*8+((d-1)*(td+walls*3))]) cube([tw+walls*2,th,td-walls*5]);
        }
      }
    }
  }
  if(notch_mode) {
    for(d=[1:dresser_high])
      translate([0,th+walls,walls*2+((d-1)*(td+walls*2))]) cube([tw+walls*10,walls,walls*8]);
  }
  }
} else if(part=="drawer")
{
  if(notch_mode)
  {
    translate([walls*-3,0]) cube([tw+walls*6,th,walls]);
  }
  difference(){
    rectangle(tw,th,td,roundness);
    for(y=[1:pockets_deep])
    {
      for(x=[1:pockets_wide])
      {
        translate([
            walls+((x-1)*((tw-walls)/pockets_wide)),
            walls+((y-1)*((th-walls)/pockets_deep)),
            walls]) 
          rectangle(
            tw/pockets_wide-walls*(pockets_wide==1?2:1.5),
            th/pockets_deep-walls*(pockets_deep==1?2:1.5)+.2,
            td,
            roundness-walls);
      }
    }
    /*translate([walls,th/2+walls*.5,walls]) rectangle(tw/2-walls*1.5,th/2-walls*1.5,td,roundness-1);
    translate([tw/2+walls*.5,walls,walls]) rectangle(tw/2-walls*1.5,th/2-walls*1.5,td,roundness-1);
    translate([tw/2+walls/2,th/2+walls/2,walls]) rectangle(tw/2-walls*1.5,th/2-walls*1.5,td,roundness-1);*/
  }
  translate([(tw/4)*(knob_halign=="left"?-1:(knob_halign=="right"?1:0)),0,0])
  {
    translate([tw/2-knob_width/2,-1*knob_depth])
    difference(){
      cube([knob_width,knob_depth,td+walls*1.3]);
      color("red") translate([0,-3,-.7*knob_depth])
        rotate([45,0,0]) cube([knob_width,knob_depth,knob_depth]);
      color("red") translate([0,-3.0,td-knob_depth*.65]) rotate([45,0,0]) cube([knob_width,knob_depth,knob_depth]);
    }
  }
}

module rectangle(w,h,d,r=0)
{
  translate([r,r])
   minkowski(){
     cube([w-r*2,h-r*2,d]);
     cylinder(r=r,$fn=30);
   }
}
