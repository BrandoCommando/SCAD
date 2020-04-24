difference() {
  union() {
    translate([-55,-60]) square([100,115]);
    translate([-40,0]) square([85,70]);
  }
  translate([-30,-60.01]) square([75.01,100]);
  for(y=[-30,0,30]) translate([-45,y]) circle(d=5,$fn=40);
  for(x=[-20,0,20]) translate([x,60]) circle(d=5,$fn=40);
  *for(x=[-40,40],y=[-55,55]) translate([x,y]) circle(d=3,h=6,$fn=20);
}