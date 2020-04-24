part="custom";
tile_size=inches(1.75);
tile_height=7;
letters="c";
numbers="1";
font="Open Sans";
text_size=8;
text_depth=0.85;
text_spacing=1.1;
text_offset=2;
magd=18.2;
magh=5.8;
spacing=4;
bezel_size=0;// inches(1.25);
bezel_line_width=2;

if(part=="white_even")
  tiles("aceg","2468");
else if(part=="white_odd")
  tiles("bdfh","1357");
else if(part=="black_even")
  tiles("bdfh","2468");
else if(part=="black_odd")
  tiles("aceg","1357");
else if(part=="custom")
  tiles(letters,numbers);

module tiles(cols,rows)
{
  for(coli=[0:len(cols)-1],rowi=[0:len(rows)-1])
    translate([coli*(tile_size+spacing),rowi*(tile_size+spacing)]) tile(text=str(cols[coli],rows[rowi]));
}
module tile(text="a1")
{
  difference() {
    cube([tile_size,tile_size,tile_height]);
    translate([tile_size/2,tile_size/2,-.02]) cylinder(d=magd,h=magh,$fn=40);
    for(t=[0,1]) translate([text_size+text_offset+(tile_size-text_size*2-text_offset*2)*t,text_size+(tile_size-text_size*2)*t,tile_height-text_depth]) rotate([0,0,t*180]) {
      linear_extrude(2,convexity=3) {
        text(text,valign="center",halign="center",size=text_size,font=font,spacing=text_spacing);
        *translate([-4,-4]) difference() {
          square([20,20],center=true);
          square([18,18],center=true);
        }
      }
    }
  }
}
module quadrant(bezel_left=1,bezel_bottom=1,spaces_wide=4,spaces_tall=4) {
difference(){
  translate([bezel_left?-bezel_size:0,bezel_bottom?-bezel_size:0])
  cube([tile_size*spaces_wide+bezel_size,tile_size*spaces_tall+bezel_size,4]);
  if(bezel_size>0&&bezel_line_width>0)
  {
    translate([bezel_left?-bezel_line_width:tile_size*4,bezel_bottom?-bezel_line_width:0,2]) cube([bezel_line_width+.01,tile_size*4+bezel_line_width,4]);
    translate([bezel_left?-bezel_line_width:0,bezel_bottom?-bezel_line_width:tile_size*4,2]) cube([tile_size*4+bezel_line_width,bezel_line_width,4]);
  }
  for(x=[0:3])
    for(y=[0:3])
      if(y%2==x%2)
        translate([x*tile_size-.01,y*tile_size-.01,0.6]) cube([tile_size+.02,tile_size+.02,5]);
}
}
*cube([inches(2),inches(2),6]);
*difference() {
  cube([inches(5.5),inches(70),inches(3/4)]);
  #for(y=[0:inches(2.125):inches(70-2.125)])
    translate([-.01,y-.01]) cube([inches(2.125),inches(2.125)+.02,inches(1)]);
}
function inches(mm) = 25.4 * mm;