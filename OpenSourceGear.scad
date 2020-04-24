dmain=30;
dteeth1=12;
dteeth2=dteeth1-2;
h=8;
dinner=12;
hteeth=10;
txt="open source hardware";
lang=270/len(txt);
if(!oshpart) scale([2,2,1]) osh_badge(1);

module osh_badge(text=0) {
difference(){
  osh_teeth();
  translate([0,0,-.01])cylinder(d=dmain,h=h+.02,$fn=50);
}
difference(){
  union(){
  cylinder(d=dmain,h=h,$fn=50);
  }
  translate([0,0,-.01]) {
    cylinder(d=dinner,h=h+.02,$fn=40);
  rotate([0,0,-90]) translate([dmain*.5+1,-6,0]) linear_extrude(h+.02) mirror([1,0]) polygon([[0,12],[12,8],[12,4],[0,0]]);
  }
  if(text)
    osh_text();
}
}

module osh_teeth()
{
  for(rot=[-225:45:45])
    rotate([0,0,rot+180])
    translate([dmain*.5-1,-4,0]) linear_extrude(h) polygon([[0,8],[8,6],[8,2],[0,0]]);
}
module osh_text()
{
  translate([0,0,h-.99]) linear_extrude(1) 
    for(i=[0:len(txt)])
    {
      ang=220-i*lang;
      translate([cos(ang)*9.5,sin(ang)*9.5])
      rotate([0,0,ang-90])
      text(txt[i],size=3,valign="baseline",halign="center",font="Courier");
    }
  }
 