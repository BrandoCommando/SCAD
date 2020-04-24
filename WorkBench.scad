tw=30*25.4;
th=31*25.4;
td=24*25.4;
ww=9*25.4;
pt=19;
assembled=false;
if(assembled) {
  translate([19,0,pt]) rotate([0,-90]) sidepanel();
  color("green") hpanel();
  translate([tw,0,pt]) rotate([0,-90]) sidepanel();
  translate([0,0,th-pt]) hpanel();
} else {
  #cube([49*25.4,49*25.4,pt-.1]);
  sidepanel();
  translate([0,td+10,0]) sidepanel();
  translate([th-pt*2+10,0]) wing();
  translate([th-pt*2+20+ww,0]) wing();
  translate([50*25.4,0]) {
    #cube([96*25.4,49*25.4,pt-.1]);
    hpanel();
    translate([0,td+10]) hpanel();
    translate([tw+10,0]) hpanel();
    translate([tw*2+20,0]) wingsupport();
  }
}
module wingsupport() {
  color("lightblue") panel(th,th-pt);
}
module wing() {
  color("blue") panel(ww,th+3*25.4);
}
module hpanel() {
  color("green") panel(tw,td);
}
module sidepanel() {
  panel(th-pt*2,td);
}
module panel(w,h,d=pt) {
  cube([w,h,d]);
}