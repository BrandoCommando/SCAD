font="Superclarendon:style=Black";
zr=2;
$fn=50;
//mirror([1,0])
{
  //mirror([0,0,1])
  {
text_hollow("L",font=font,size=88,h=zr*9);
translate([135,46.2]) scale([1,1.06]) rotate([0,0,-40]) text_hollow("o",font=font,halign="center",size=105,valign="center",h=zr*10);
translate([0,-84]) text_hollow("V",size=80,font=font,h=zr*10);
translate([91,-84]) text_hollow("E",size=80,font=font,h=zr*9);
}
//mirror([0,0,1])
{
translate([22,72]) difference(){cube([20,20,10]); translate([10,8]) hanging_hook();}
intersection() {
  translate([135,46.2]) scale([1,1.06]) rotate([0,0,-40]) linear_extrude(zr*10) text("o",font=font,halign="center",size=105,valign="center",h=zr*10);
  translate([123,72]) difference(){cube([20,30,10]); translate([10,8]) hanging_hook();}
}
}
}
module text_hollow(s,font=font,size=9,halign="left",valign="baseline",h=10,top=0,bottom=1) {
  linear_extrude(h) text_outline(s,font=font,size=size,halign=halign,valign=valign);
  if(top)
  linear_extrude(1) text(s,font=font,size=size,halign=halign,valign=valign);
  if(bottom)
    translate([0,0,h-1]) linear_extrude(1) text(s,font=font,size=size,halign=halign,valign=valign);
}
module text_outline(s,font=font,size=9,halign="left",valign="baseline") {
  difference() {
  minkowski() {
    text(s,font=font,size=size,halign=halign,valign=valign);
    square([3,3],center=true);
  }
   text(s,font=font,size=size,halign=halign,valign=valign);
}
}

module hanging_hook() {
  translate([0,0,-.01]) {
    cylinder(d=9,h=5,$fn=30);
    translate([0,5,1]) cylinder(d1=5,d2=9,h=4.01,$fn=26);
    translate([0,5]) cylinder(d=5,h=1.01,$fn=26);
    translate([-2.5,0]) cube([5,5,5]);
    translate([0,0,4]) {
      translate([0,5,1]) cylinder(d=9,h=3,$fn=40);
      translate([-4.5,0,1]) cube([9,5,3]);
      cylinder(d=9,h=4,$fn=40);
    }
  }
}
/*
union()
{
    linear_extrude(file = "love.dxf", layer="L", height = 8, convexity = 4); 
    linear_extrude(file = "love.dxf", layer="O", height = 10, convexity = 4); 
    linear_extrude(file = "love.dxf", layer="V", height = 12, convexity = 4); 
    linear_extrude(file = "love.dxf", layer="E", height = 6, convexity = 4); 
}
*/