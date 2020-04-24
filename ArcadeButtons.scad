difference(){
  square([250,150]);
  translate([40,70]) rotate([0,0,0]) player_layout();
}
module player_layout()
{
  circle(d=35,$fn=100);
  translate([100,10])
  for(x=[-10,30,70])
    for(y=x<0?[-30,10]:[-20,20])
        translate([x,y]) circle(d=30,$fn=50);
}