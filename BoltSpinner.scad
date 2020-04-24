cylh=80;
//mirror([0,0,1]) base();
small_box();
module small_box() {
  difference(){
    union(){
      intersection(){
        cube([60,20,45]);
        minkowski(){
          translate([4,4]) cube([52,12,45]);
          sphere(4,$fn=20);
        }
      }
      translate([0,-14]) intersection(){
        cube([10,18,10]);
        minkowski(){
          translate([4,4]) cube([2,18,10]);
          sphere(4,$fn=20);
        }
      }
      translate([50,-14]) intersection(){
        cube([10,18,10]);
        minkowski(){
          translate([4,4]) cube([2,18,10]);
          sphere(4,$fn=20);
        }
      }
    }
    translate([5,-9,-.01]) cylinder(d=4,h=12,$fn=16);
    translate([55,-9,-.01]) cylinder(d=4,h=12,$fn=16);
    translate([13,10,30]) cylinder(d=3.5,h=20,$fn=16);
    translate([47,10,30]) cylinder(d=3.5,h=20,$fn=16);
  }
  %translate([13,10,69]) mirror([0,0,1]) small_cyl();
  %translate([47,10,69]) mirror([0,0,1]) small_cyl();
}
module small_cyl() {
  difference(){
    union(){
    cylinder(d=30, h=2, $fn=50);
    translate([0,0,2]) cylinder(d1=24,d2=12,h=10,$fn=40);
    translate([0,0,4]) cylinder(d=12,h=20,$fn=30);
      translate([0,0,16]) cylinder(d1=12,d2=15,h=8,$fn=36);
    }
    translate([0,0,-.01]) cylinder(d=5,h=40,$fn=20);
  }
}
module props() {
%translate([0,0,7]) bearing608();
%union(){
  cylinder(d=8,h=67,$fn=20);
}
}
module cyl(){
translate([0,0,14])
  difference()
  {
    cylinder2([[30,4,30],[30,8,25],[25,2,22],[22,cylh-28,22],[22,2,25],[25,8,30],[30,4,30]]);
    translate([0,0,-.01])
      cylinder2([[23,6,23],[23,6,20],
        [20,cylh-24,20],[20,6,23],[23,6.02,23]]);
  }
*difference()
{
  union(){
    cylinder(d=25,h=cylh);
    cylinder(d1=30,d2=25,h=8);
    translate([0,0,cylh-8]) cylinder(d1=25,d2=30,h=8);
  }
  translate([0,0,-.01]) cylinder(d=22.4,h=6);
  translate([0,0,5.98]) cylinder(d1=22.4,d2=22,h=8);
  translate([0,0,-.01]) cylinder(d=20,h=cylh+10);
  translate([0,0,cylh-14]) cylinder(d1=20,d2=22.4,h=8.01);
  translate([0,0,cylh-6]) cylinder(d=22.4,h=6.02);
}
}
module base(){
  bw=36;
difference(){
  union(){
    translate([bw*-.5,bw*-.5]) intersection(){
      cube([bw,bw,10]);
      minkowski(){
        translate([2,2,0]) cube([bw-4,bw-4,10]);
        sphere(2,$fn=20);
      }
    }
    *translate([0,0,6]) cylinder(d=14,h=1);
  }
  translate([0,0,-.01]) cylinder(d=15,h=5.4,$fn=6);
  cylinder(d=8.1,h=20,$fn=20);
  translate([0,-6.5,-.01]) cube([40,13,5.4]);
  translate([0,-4,5.38]) cube([40,8,6]);
  //translate([0,0,1]) cylinder(d=22,h=8,$fn=50);
  translate([bw*-.35,bw*-.35,-.01]) cylinder(d=3.5,h=20,$fn=16);
  translate([bw*-.35,bw*.35,-.01]) cylinder(d=3.5,h=20,$fn=16);
  translate([bw*.35,bw*-.35,-.01]) cylinder(d=3.5,h=20,$fn=16);
  translate([bw*.35,bw*.35,-.01]) cylinder(d=3.5,h=20,$fn=16);
  
}
}
module bearing608(){
difference(){
  cylinder(d=22,h=7,$fn=40);
  translate([0,0,-.01]) cylinder(d=8,h=7.02,$fn=20);
}
}
function sum(list,index,off=0) = (index > 0 ? sum(list,index-1,off) : 0) + list[index][off];
module cylinder2(ca) // [[d1A,hA,d2A],[dB,hB],...]
{
  for(i=[0:len(ca)-1])
  {
    z=sum(ca,i-1,1);
    echo(str("Height: ",ca[i][1]," @ ",z));
    translate([0,0,z]) cylinder(d1=ca[i][0],d2=len(ca[i])>2?ca[i][2]:0,h=ca[i][1],$fn=ca[i][0]*2);
  }
}