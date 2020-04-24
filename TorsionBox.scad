websize=inches(2.5);
webdist=inches(4);
ywebs=floor((feet(8)-1)/webdist);
echo(str("YWebs: ",ywebs,"*",websize,"=",(ywebs*(websize+inches(1/8))/inches(1))));
mirror([0,1]) {
  #translate([0,0,inches(-1/2)]) panel(4,8);
  for(y=[1:ywebs]) translate([(y-1)*(inches(1/8)+websize),0]) cube([websize,y>ywebs?feet(8):inches(58),inches(1/2)]);
  for(y=[1:4]) translate([ywebs*(inches(1/8)+websize)+((y-1)*inches(5.125)),0]) cube([inches(5),feet(8),inches(1/2)]);
}
panel(4,8);
%translate([0,0,inches(3.5)]) panel(4,8);
for(y=[1:ywebs]) translate([inches(-5),y*webdist,inches(1/2)]) rotate([90,0]) cube([inches(58),websize,inches(1/2)]);
module panel(wft,hft,d=inches(1/2))
{
  cube([feet(wft),feet(hft),d]);
}
function inches(in) = 25.4*in;
function feet(ft) = inches(ft*12);