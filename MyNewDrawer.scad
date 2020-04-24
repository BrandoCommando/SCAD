walls=1.25;
tw=80;
th=90;
td=15;
roundness=2;
knob_halign="middle"; // [left,middle,right]
knob_valign="middle";
knob_depth=12;
knob_width=2;
pockets_deep=1;
pockets_wide=4;
modifier=0;

difference(){drawer();
if(modifier>0)
  modifier();
}
module modifier(){
  for(y=[1:pockets_deep+1])
  {
    for(x=[1:pockets_wide+1])
    {
      translate([
          walls+((x-1)*((tw-walls)/pockets_wide))-(modifier/4),
          walls+((y-1)*((th-walls)/pockets_deep))-(modifier/4),
          walls])
      {
          if(!(x==1&&(y==1||y==pockets_deep+1))&&
             !(x==pockets_wide+1&&(y==1||y==pockets_deep+1)))
        difference(){
          cylinder(d=modifier,h=td+1,$fn=4);
          translate([modifier*.4,modifier*.4,-.01])
            cylinder(d=modifier*.8,h=td+1.02,$fn=16);
          translate([modifier*.4,modifier*-.4,-.01])
            cylinder(d=modifier*.8,h=td+1.02,$fn=16);
          translate([modifier*-.4,modifier*-.4,-.01])
            cylinder(d=modifier*.8,h=td+1.02,$fn=16);
          translate([modifier*-.4,modifier*.4,-.01])
            cylinder(d=modifier*.8,h=td+1.02,$fn=16);
          if(x==1)
            translate([-.4*modifier,-1*modifier-.01,-.01])
              cube([modifier*.5,2*modifier+.02,td+1.02]);
          else if(x==pockets_wide+1)
            translate([0*modifier,-1*modifier-.01,-.01])
              cube([modifier*.5,2*modifier+.02,td+1.02]);
          else if(y==1&&pockets_wide%2==0&&x==(pockets_wide/2)+1)
            translate([-1*modifier,-.3*modifier,-.01]) cube([modifier*2+.02,modifier*2,td+1.02]);
          /*
          if(y==1)
            translate([-1*modifier,-.3*modifier,-.01])
              cube([modifier*2+.02,modifier*0,td+1.02]);
          else if(y==pockets_deep+1)
            translate([-1*modifier,0*modifier,-.01])
              cube([modifier*2,modifier*.5,td+1.02]);
          */
        }
      }
    }
  }
}
module drawer() {
difference(){
  rectangle(tw,th,td,roundness);
  for(y=[1:pockets_deep])
  {
    for(x=[1:pockets_wide])
    {
      translate([
          walls+((x-1)*((tw-walls)/pockets_wide)),
          walls+((y-1)*((th-walls)/pockets_deep))+.2,
          walls*2]) 
        rectangle(
          tw/pockets_wide-walls*(pockets_wide==1?2:1.5),
          th/pockets_deep-walls*(pockets_deep==1?2:1.5)-.4,
          td,
          roundness, v=1);
    }
  }
  /*translate([walls,th/2+walls*.5,walls]) rectangle(tw/2-walls*1.5,th/2-walls*1.5,td,roundness-1);
  translate([tw/2+walls*.5,walls,walls]) rectangle(tw/2-walls*1.5,th/2-walls*1.5,td,roundness-1);
  translate([tw/2+walls/2,th/2+walls/2,walls]) rectangle(tw/2-walls*1.5,th/2-walls*1.5,td,roundness-1);*/
}
translate([(tw/4)*(knob_halign=="left"?-1:(knob_halign=="right"?1:0)),0,0])
  translate([tw/2-knob_width/2,-1*knob_depth]) difference() {
    cube([knob_width,knob_depth,td+walls*1.3]);
    translate([-.01,-10,-.01]) rotate([-45,0]) cube([knob_width+.02,10,10]);
    translate([-.01,-10,td+1.2]) rotate([-45,0]) cube([knob_width+.02,10,10]);
  }
}

module rectangle(w,h,d,r=0,v=0)
{
  translate([r,r])
   minkowski(){
     cube([w-r*2,h-r*2,d]);
     if(v)
       sphere(r=r,$fn=30);
     else
      cylinder(r=r,$fn=30);
   }
}
