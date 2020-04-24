iw=inches(7);
ih=inches(5+(11/16));
ow=inches(8);
oh=inches(7+(9/16));
screwpos=[inches(5.5),inches(6.5)];
show_text=1;

difference()
{
  rsquare([ow,oh]);
  //translate([ow/2-iw/2,oh/2-ih/2]) square([iw,ih]);
//} union(){
  *translate([inches(0.5),inches(0.5)]) square([iw,ih]);
  translate([ow/2-iw/2,oh/2-iw/2+15]) cutouts();
  screwholes();
}

module screwholes() {
  for(x=[ow/2-screwpos[0]/2,ow/2+screwpos[0]/2],y=[oh/2-screwpos[1]/2,oh/2+screwpos[1]/2])
    translate([x,y]) circle(d=6);
}

module cutouts()
{
  screen();
  toggles();
  estop();
  key_lock();
  power();
  laser_enable();
  test_switch();
  translate([inches(3.5),inches(1.25)]) {
    current_knob();
    current_dial();
    current_slider();
  }
}
module screen()
{
  translate([10,ih-64.6])
  {
    square([83.2,54.6]);
    for(x=[-5,88.2],y=[-5,59.6])
      translate([x,y]) circle(d=3,$fn=20);
  }
}
module toggles()
{
  translate([inches(0.5),inches(1)])
  {
    tx=inches(0.95);
    toggle("air");
    translate([tx,0]) toggle("guide");
    translate([tx*2,0]) toggle("fan");
    translate([tx*3,0]) toggle("light");
  }
}
module toggle(lbl)
{
  difference() {
    circle(d=12);
    translate([-0.8,-6.1]) square([1.6,1.4]);
  }
  translate([0,-14]) label(lbl);
}
module estop()
{
  translate([inches(2),inches(2.25)])
  {
    circle(d=31);
    translate([31,-4]) label("STOP");
  }
}
module key_lock()
{
  translate([inches(0.5+3.8)+10,inches(1)]) {
    intersection(){
      circle(d=12.2,$fn=30);
      translate([-5.25,-6.5]) square([10.5,13]);
    }
    translate([0,-14]) label("key");
  }
}
module laser_enable()
{
  translate([iw-inches(1.6),inches(2.1)]) {
    square([12,12],center=true);
    translate([0,-14]) label("enable");
  }
}
module test_switch()
{
  translate([iw-inches(.6),inches(2.1)]) {
    square([12,12],center=true);
    translate([0,-14]) label("test");
  }
}
module current_slider()
{
  translate([inches(1),inches(2.8)]) rotate([0,0,90]) slider_cutout();
}
module slider_cutout()
{
  translate([-32.5,0]) circle(d=3,$fn=20);
  translate([32.5,0]) circle(d=3,$fn=20);
  translate([-28,-2]) square([56,4]);
}
module current_knob()
{
  translate([inches(1)+34, 50]) {
    circle(d=10);
    translate([0,-16]) label("current");
  }
}
module current_dial()
{
  translate([inches(1)+34,84])
  {
    circle(d=38);
    for(x=[-22.5+5.5,22.5-5.5])
        translate([x,-22.5+5.25]) circle(d=3,$fn=20);
    *translate([0,-30]) label("current");
  }
}
module power()
{
  translate([iw-39,10]) {
    square([29,23]);
    
  }
}
module label(lbl) {
  if(show_text)
    %text(lbl,size=6,halign="center");
  else
    circle(d=3);
}
module rsquare(dims,r=5)
{
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
  for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=25);
}
function inches(in) = in * 25.4;