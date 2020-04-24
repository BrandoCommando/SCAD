*!reinforce_box();
intersection(){
  translate([-50,-50,0]) cube([100,100,12]);
difference(){
  union(){
    translate([-24,-6,-5]) cube([48,12,12]);
    for(m=[0,1]) mirror([m,0])
    hull(){
      translate([-20,-6,-5]) cylinder(d=12,h=12,$fn=40);
      translate([-20,6,-5]) cylinder(d=12,h=12,$fn=40);
      translate([-10,0,-5]) cylinder(d=12,h=12,$fn=40);
    }
  }
  translate([-6,-6.01,5]) cube([12,12.02,4.02]);
  for(m=[0,1]) mirror([m,0]) {
    *translate([-10,0,-1.01]) screwhole();
    translate([-20,-6,-1.01]) screwhole();
    translate([-20,6,-1.01]) screwhole();
  }
}
}
module screwhole() {
  cylinder(d=4,h=20,$fn=30);
  cylinder(d1=9,d2=4,h=4,$fn=40);
}

module reinforce_box() {
  translate([-10,-10]) cube([20,20,10]);
}
