t=inches(0.21);
tw=t*62;
th=t*62;
jump=25.4;
echo(str("t:",t," j:",jump));

wall();
translate([tw,0,tw-t]) mirror([1,0]) wall();
rotate([0,90,0]) translate([tw*-1,0,0]) color("green") wall();
translate([tw,0]) rotate([0,-90,0]) color("brown") wall();

translate([tw+.01,t+.01,.01]) mirror([1,0]) rotate([90,0]) color("purple") wall(1,1);

module wall(off=0,top=0) {
linear_extrude(t) difference(){
  square([tw,th]);
  for(x=[0:jump:tw])
  {
    translate([x-(off?jump/2:0),-.01]) square([jump/2,t]);
    if(top)
      translate([x-(off?jump/2:0),th-t]) square([jump/2,t]);
  }
  for(y=[0:jump:th])
  {
    translate([-.01,y-(off?jump/2:0)]) square([t,jump/2]);
    translate([tw-t,y-jump/2]) square([t,jump/2]);
  }
}
}

function inches(mm) = mm * 25.4;