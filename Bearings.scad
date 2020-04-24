h=3;
od1=8;
od2=7;
id=4;
spacer(od1,h,od2,id);
translate([10,0]) spacer(od1,h+3,od2,id);
translate([10,10]) spacer(od1,h+3,od2,id);
translate([0,10]) spacer(od1,h,od2,id);
translate([20,0]) spacer(od1,h+5,od2,id);
translate([20,10]) spacer(od1,h+5,od2,id);
translate([40,15]) spacer(21.8,7,21.8,8.2,false);
translate([40,-10]) spacer(21.8,7,21.8,8.2,false);
module spacer(od1,h,od2,id,cham=true) { 
  difference(){
    cylinder(d1=od1,d2=od2,h=h,$fn=40);
    translate([0,0,-.01]) cylinder(d=id,h=h+.02,$fn=30);
    if(cham)
      translate([0,0,h-1]) cylinder(d1=id,d2=id+1,h=1+.01,$fn=30);
  }
}