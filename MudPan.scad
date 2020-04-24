tw=8*25.4;
th=4*25.4;
td=3*25.4;
echo(str("Total Size: ",tw,"x",th,"x",td));
rotate([90,0]) {
linear_extrude(2) step2(0);
linear_extrude(tw) step3();
translate([0,0,tw-2]) linear_extrude(2) step2(0);
}
module step2(round=1){
  minkowski(){
    profile(0);
    if(round)
      circle(r=2,$fn=20);
    else
      translate([-1,-1]) square([2,2]);
  }
}
module step3(){
difference(){
  step2(0);
  profile();
  polygon([[0,td-1],[-1,td+5],[th+1,td+5],[th,td-1]]);
}
}

module profile(circles=1){
polygon(circles?
  [[0,td],[th/4-4.7,16],[th*3/8,0],[th*5/8,0],[th*3/4+4.7,16],[th,td]] :
  [[0,td],[th/4,0],[th*3/4,0],[th,td]]);
  if(circles) {
translate([th/4+15,20]) circle(r=20,$fn=50);
translate([th*3/4-15,20]) circle(r=20,$fn=50);
  }
}