part="all"; //[all,idler,idler_base,plate,bracket,connector,small_gear,large_gear]
ratio = 5;
pitch = 6;
ssize=43.2;
hob_tx=1.4;
rot=4.5;
screwd=3.5;
baseh=13;
gearh=10;
nutd=6.5;
anim_ratio = 6.4;
bigd = (50*pitch)/PI;
littled = bigd/ratio;
$fn=20;
echo(str("Diameters: ", littled, " : ", bigd));
if(part=="small_gear")
  gear(littled,gearh,6,0,0,1.2);
else if(part=="large_gear")
  gear(bigd,gearh,6,0,holes=6,set_hole=3);
else if(part=="plate")
  base_plate();
else if(part=="idler+base")
  base_idler(true);
else if(part=="idler")
  rotate([90,0]) idler();
else if(part=="idler2")
  idler2();
else if(part=="idler_base")
  rotate([0,0,-1*rot]) base_idler(0);
else if(part=="bracket")
  mirror([0,0,1]) large_bracket();
else if(part=="connector")
  bracket_connector();
else if(part=="cup")
  bearing_cup();
else if(part=="all") {
translate([0,0,2]) rotate([0,0,$t*anim_ratio]) gear(bigd,gearh,6,0,0,holes=6,set_hole=3);
%translate([0,0,-7]) bearing608();
translate([0,0,-10]) bearing_cup();
//%bearing608();
color("red") base_idler();
//%translate([0,0,gearh+.2]) bearing608();
//%translate([0,0,26.5]) bearing608();
color("purple") translate([bigd+littled/2,0]) rotate([0,0,180]) base_idler();
#hobbed_bolt(h=50,hobz=20,hobh=4,od=9,id=9-hob_tx);
translate([bigd/2+littled/2+pitch/2-8,30]) {
  %translate([ssize*-.5,ssize*-.5,ssize*-1-4]) difference(){
    union(){
      cube([ssize,ssize,ssize]);
      translate([ssize/2,ssize/2,ssize]) cylinder(d=5,h=15);
    }
    translate([6.1,ssize-6.1,-0.01]) cylinder(d=screwd,h=50);
    translate([ssize-6.1,ssize-6.1,-0.01]) cylinder(d=screwd,h=50);
    translate([6.1,6.1,-0.01]) cylinder(d=screwd,h=50);
    translate([ssize-6.1,6.1,-0.01]) cylinder(d=screwd,h=50);
  }
  rotate([0,0,18-$t*5*anim_ratio]) gear(littled,gearh,6,set_hole=1.2);
  translate([ssize*-.5,littled/2,-3.5]) {
    //small_bracket();
    color("orange")
    translate([0,-26,26.7])
      base_plate();
  }
}
translate([bigd/2+littled/2+pitch/2-8+ssize*-.5,bigd*-1+33.5,23.1]) {
  base_plate();
  translate([0,0,-26.5]) {
    large_bracket();
    translate([0,0,3]) bracket_connector();
    translate([0,123,3]) mirror([0,1]) bracket_connector();
  }
}
translate([bigd+littled+pitch-16,0]) {
  rotate([0,0,$t*anim_ratio]) gear(bigd,gearh,6,holes=6,set_hole=3);
  %translate([0,0,10]) bearing608();
  %hobbed_bolt(h=50,hobz=20,hobh=4);
}
%translate([bigd/2+4,0,22]) {
  //cylinder(d=4,h=20);
  rotate([0,0,rot]) translate([bigd/2+4,11.8,-3.5]) bearing608();
  rotate([0,0,rot]) translate([bigd*-.5-4,-11.8,-3.5]) bearing608();
  rotate([0,90,rot]) translate([0,0,bigd*-1-60]) {
    color("lightgreen")
      translate([0,0,-10]) cylinder(d=1.75,h=bigd*3+20,$fn=20);
    translate([0,0,89]) mirror([0,0,1]) coupler();
    translate([0,0,120]) coupler();
    difference(){
      color("white") 
      cylinder(d=4,h=bigd*3,$fn=20);
      translate([0,0,-0.01]) cylinder(d=2,h=bigd*3+0.02,$fn=20);
      translate([2,-8,104]) rotate([0,-90,0]) cylinder(d=24,h=5,$fn=50);
    }
  }
}
}
module bearing_cup(h=6){
  difference(){
    translate([-15,-15]) cube([30,30,h]);
            rotate([0,0,45]) translate([14,0,-0.01]) cylinder(d=screwd,h=h+.02);
        rotate([0,0,135]) translate([14,0,-0.01]) cylinder(d=screwd,h=h+.02);
        rotate([0,0,225]) translate([14,0,-0.01]) cylinder(d=screwd,h=h+.02);
        rotate([0,0,315]) translate([14,0,-0.01]) cylinder(d=screwd,h=h+.02);
    translate([0,0,-0.01]) cylinder(d=16,h=h+.02,$fn=30);
    translate([0,0,3]) cylinder(d=22.2,h=h-3+.01,$fn=30);
  }
}
module small_bracket(){
  difference()
  {
    cube([ssize,ssize/2,3]);
    translate([6.1,6.1,-20]) cylinder(d=screwd,h=50);
    translate([ssize-6.1,6.1,-20]) cylinder(d=screwd,h=50);
  }
  translate([0,ssize/4,0]) {
    difference()
    {
      cube([ssize,ssize/4,26.7]);
      translate([6.1,5.1,20])
        cylinder(d=screwd,h=40);
      translate([ssize-6.1,5.1,20])
        cylinder(d=screwd,h=40);
    }
  }
}
module bracket_connector(h=23.5){
  difference(){
    union(){
      cube([ssize,ssize/4,h]);
      translate([ssize/2,ssize/8]) cylinder(d=26,h=h);
    }
    translate([0,-20,-.01]) cube([ssize,20,h+0.02]);
    translate([6.1,6.1,-0.01]) cylinder(d=screwd,h=h+0.02);
    translate([ssize-6.1,6.1,-0.01]) cylinder(d=screwd,h=h+0.02);
  }
}
module large_bracket(){
  bw=139;
  difference(){union(){
    //cube([ssize,ssize/4,26.5]);
    cube([ssize,123,3]);
//    translate([0,123-ssize/4,0]) cube([ssize,ssize/4,26.5]);
    translate([bigd*-.5,47,0]) difference() {
      union(){
      cube([bw,30,3]);
//      translate([17,15,-6]) cylinder(d1=24,d2=30,h=6,$fn=40);
//        translate([bw-17,15,-6]) cylinder(d1=24,d2=30,h=6,$fn=40);
      }
      translate([17,15]) {
        rotate([0,0,45]) translate([14,0,-0.01]) cylinder(d=screwd,h=3.02);
        rotate([0,0,135]) translate([14,0,-0.01]) cylinder(d=screwd,h=3.02);
        rotate([0,0,225]) translate([14,0,-0.01]) cylinder(d=screwd,h=3.02);
        rotate([0,0,315]) translate([14,0,-0.01]) cylinder(d=screwd,h=3.02);
//        translate([0,0,-6.01]) cylinder(d=18,h=10.02,$fn=35);
        translate([0,0,-4]) cylinder(d=22.2,h=7.01,$fn=40);
      }
      translate([bw-17,15]) {
        rotate([0,0,45]) translate([14,0,-0.01]) cylinder(d=screwd,h=3.02);
        rotate([0,0,135]) translate([14,0,-0.01]) cylinder(d=screwd,h=3.02);
        rotate([0,0,225]) translate([14,0,-0.01]) cylinder(d=screwd,h=3.02);
        rotate([0,0,315]) translate([14,0,-0.01]) cylinder(d=screwd,h=3.02);
//        translate([0,0,-6.01]) cylinder(d=18,h=10.02,$fn=35);
        translate([0,0,-4]) cylinder(d=22.2,h=7.01,$fn=40);
      }
    }
  }
  translate([ssize/2,91.6,-0.01]) cylinder(d=10,h=10);
  translate([6.1,6.1,-0.01]) cylinder(d=screwd,h=60);
  translate([ssize-6.1,6.1,-0.01]) cylinder(d=screwd,h=60);
  translate([6.1,123-6.1,-0.01]) cylinder(d=screwd,h=60);
  translate([ssize-6.1,123-6.1,-0.01]) cylinder(d=screwd,h=60);
  translate([0,107-ssize+6.1,-10.01]) {
    translate([6.1,6.1]) cylinder(d=screwd,h=60);
    translate([6.1,ssize-6.1]) cylinder(d=screwd,h=60);
    translate([ssize-6.1,6.1]) cylinder(d=screwd,h=60);
    translate([ssize-6.1,ssize-6.1]) cylinder(d=screwd,h=60);
  }
  translate([0,9.9,-10.01]) {
    translate([6.1,6.1]) cylinder(d=screwd,h=60);
    translate([6.1,ssize-6.1]) cylinder(d=screwd,h=60);
    translate([ssize-6.1,6.1]) cylinder(d=screwd,h=60);
    translate([ssize-6.1,ssize-6.1]) cylinder(d=screwd,h=60);
    translate([ssize/2,ssize/2]) cylinder(d=10,h=60);
  }
}
}
module base_plate(){
  difference(){
        cube([ssize,ssize+4.4,4]);
     translate([6.1,6.1,2]) cylinder(d=nutd,h=30,$fn=6);
     translate([6.1,ssize-1.5,2]) cylinder(d=nutd,h=30,$fn=6);
     translate([ssize-6.1,6.1,2]) cylinder(d=nutd,h=30,$fn=6);
     translate([ssize-6.1,ssize-1.5,2]) cylinder(d=nutd,h=30,$fn=6);
        translate([6.1,6.1,-7]) cylinder(d=screwd,h=20);
        translate([ssize-6.1,6.1,-7]) cylinder(d=screwd,h=20);
        translate([6.1,ssize-1.5,-7]) cylinder(d=screwd,h=20);
        translate([ssize-6.1,ssize-1.5,-7]) cylinder(d=screwd,h=20);
      }
}
module base_idler(idler=1){
  difference()
{
  translate([0,0,17.2]) rotate([0,0,rot]) {
  //  translate([-15,-30]) cube([30,30,10]);
    base();
    if(idler)
    {
      idler();
      #translate([0,0,10]) bearing608();
      #translate([0,0,-7]) bearing608();
    }
  }
  translate([bigd/2+littled/2+pitch/2-8+ssize*-.5,30+littled/2-26,23.2]) {
    cube([ssize,38,4.01]);
    translate([6.1,6.1,-7]) cylinder(d=screwd,h=20);
    translate([ssize-6.1,6.1,-7]) cylinder(d=screwd,h=20);
  }
}
}
module idler2() {
  difference()
  {
    translate([-20,-22,-4.2]) {
      translate([0,-1,0]) cube([40,13,4]);
      //cube([2.6,12,12]);
      translate([32,-1,0]) cube([8,7,4.4+baseh]);
      translate([0,-1,0]) cube([8,7,4.4+baseh]);
      translate([20,6,4]) cylinder(d1=11,d2=9,h=1.4,$fn=50);
      translate([20,6,0]) cylinder(d=8,h=13.5,$fn=40);
    }
    translate([0,0,-5.7]) cylinder(d=25,h=7,$fn=50);
    translate([-20,-22,-4]) {
      translate([4,20,9]) rotate([90,0]) cylinder(d=screwd,h=30,$fn=20);
      translate([36,20,9]) rotate([90,0]) cylinder(d=screwd,h=30,$fn=20);
    }
  }
}
module idler(){
  difference()
  {
    translate([-20,-22,-4.2]) {
      translate([0,-1,0]) cube([40,13,4]);
      //cube([2.6,12,12]);
      translate([32,-1,0]) cube([8,2,4.4+baseh]);
      translate([0,-1,0]) cube([8,2,4.4+baseh]);
      translate([20,6,4]) cylinder(d1=11,d2=9,h=2,$fn=50);
      translate([20,6,13]) cylinder(d1=9,d2=9+baseh-7.5,h=baseh-7.5,$fn=50);
      translate([0,-1,baseh+4.4]) cube([40,13,17-baseh]);
      translate([0,-1,15]) cube([40,2,3]);
    }
    translate([17,-13,-5.01]) rotate([0,0,90]) cylinder(d=screwd,h=23);
    translate([0,0,-10]) cylinder(d=24,h=30,$fn=50);
      translate([0,-16,-4.3]) cylinder(d=8,h=30,$fn=40);
    translate([-20,-22,-4]) {
      translate([4,20,9]) rotate([90,0]) cylinder(d=screwd,h=30,$fn=20);
    }
  }
}
module base(){
  pnh=3.4; // pocket nut height
  difference()
  {
    union(){
      translate([-20,-15])
      difference()
      {
        cube([8,20,baseh]);
        translate([4,8,5]) rotate([90,0]) cylinder(d=screwd,h=20,$fn=30);
        translate([1,2,4]) cube([6,pnh,10]);
        translate([4,5.5,5]) rotate([90,30]) cylinder(d=7,h=pnh,$fn=6);
      }
      translate([12,-15]) 
      difference()
      {
        translate([0,-1,0]) cube([8,25,baseh]);
        translate([5,2,-5.01]) rotate([0,0,90]) cylinder(d=screwd,h=23);

        //translate([4,8,5]) rotate([90,0]) cylinder(d=screwd,h=20,$fn=30);
        //translate([1,2,4]) cube([6,pnh,10]);
        //translate([4,5.5,5]) rotate([90,30]) cylinder(d=7,h=pnh,$fn=6);
      }
//      translate([11,-20]) cube([6,10,2]);
      difference(){union(){
      //ring(40,8,10);
        translate([-20,0]) cube([40,20,10]);
        translate([0,5,0]) cube([80,15,10]);
        translate([0,0,10]) ring(od=30,id=22.2,h=5,$fn=50);
        translate([0,0,6]) difference(){
          cylinder(d=30,h=4,$fn=50);
        }
        difference(){
          union(){
            translate([40,-3.2,0]) cube([10,10,18]);
            translate([54.7,-5,0]) cube([10,10,18]);
          }
          translate([42,0,15]) {
            cube([6,pnh,20]);
            translate([3,0,0]) rotate([-90,30]) cylinder(d=7,h=pnh,$fn=6);
          }
          translate([56.7,-1.5,15]) {
            cube([6,pnh,20]);
            translate([3,0,0]) rotate([-90,30]) cylinder(d=7,h=pnh,$fn=6);
          }
          translate([30,-4.2,5]) rotate([0,90]) cylinder(d=6,h=50,$fn=40);
          translate([45,-10.01,15]) rotate([-90,0]) cylinder(d=screwd,h=50);
          translate([59.7,-10.01,15]) rotate([-90,0]) cylinder(d=screwd,h=50);
        }
      }
      translate([0,0,-0.01]) cylinder(d=12,h=10.02);
      translate([-30,-56,5]) rotate([0,0,0]) cube([50,50,20]);
      translate([-12,-12,10]) rotate([0,45,0]) cube([17,10,17]);
//      translate([0,0,8]) cylinder(d=22.2,h=10);
//      translate([0,-18,-.01]) cylinder(d=30,h=10.02);
      //translate([0,-15,-0.01]) cylinder(d=26,h=10.02);
      }
    }
    #translate([20.01,-4,6]) rotate([0,-90,0]) cylinder(d1=10.2,d2=9.5,h=8.02,$fn=40);
    #translate([-20.01,-4,6]) rotate([0,90,0]) cylinder(d1=10.2,d2=9.5,h=8.22,$fn=40);
    translate([20.01,-4,6]) rotate([0,-90,0]) cylinder(d=9,h=40.02,$fn=40);
  }
}
module coupler(){
  difference(){
    union(){
      cylinder(d=8,h=6,$fn=40);
      translate([0,0,6]) cylinder(d=10,h=6,$fn=6);
      color("blue") translate([0,0,12]) cylinder(d=6.5,h=2,$fn=40);
      color("blue") translate([0,0,14]) cylinder(d=11,$h=1,$fn=50);
    }
    translate([0,0,-0.01]) cylinder(d=4.5,h=20.02,$fn=30);
  }
}
module gear(d,h,pitch,rod=1,bearing=0,set_hole=0,holes=0,bolt_head=0)
{
  teeth=(PI*d)/pitch;
  echo(str("Teeth: ", teeth));
  //intersection()
  {
    //  translate([0,0,-20]) sphere(d=d+21,$fn=80);
  difference(){
    union(){
  difference(){
    cylinder(d=d,h=h,$fn=teeth*2);
    if(d>50)
    {
      translate([0,0,4]) ring(od=d-7,id=28,h=h,$fn=80);
//      translate([0,0,7]) cylinder(d=22,h=h,$fn=60);
    }
    translate([0,0,-0.01]) cylinder(d=bearing?22.2:8.2,h=h+0.02,$fn=60);
    if(bolt_head==1) {
      translate([0,0,-0.01]) cylinder(d=12.2,h=3,$fn=6);
      translate([0,0,2.98]) cylinder(d1=12.2,d2=8,h=4.2,$fn=6);
    }
  }
  if(rod!=0)
    translate([0,0,rod<0?rod*30+h:0])
      cylinder(d=8,h=30,$fn=20);
  for(t=[0:teeth]) {
    rotate([0,0,t*(360/teeth)]) translate([d/2-1,pitch*-.25,0])
    {
      tt=pitch*.25;
      tr=pitch*.65;
      translate([0,tt])
      linear_extrude(h) polygon([[0,tt],[tr*.7,tt],[tr*.9,tt*.8],[tr,0],[tr*.9,tt*-.8],[tr*.7,tt*-1],[0,tt*-1]]);
//      cube([pitch*.5+1,pitch*.5,h]);
    }
  }
}
  if(set_hole>0) {
      translate([0,0,-0.01]) cylinder(d=5,h=gearh+0.02);
    translate([0,0,h-3]) rotate([90,0,0]) {
      cylinder(d=3,h=d>50?28:d);
      translate([0,0,d>50?set_hole+6:set_hole+4]) cylinder(d=6.5,h=6);
      translate([0,0,set_hole+2]) {
        rotate([0,0,30]) cylinder(d=6.5,h=2.4,$fn=6);
        translate([-2.75,0,0]) cube([5.5,6.1,2.4]);
      }
    }
  }
  if(holes>0)
  {
    deg=360/holes;
    for(hole=[1:holes])
    {
      rotate([0,0,deg*hole]) translate([d/4+5,0,-0.01]) cylinder(d=d/holes,h=h+0.02,$fn=d/4);
    }
  }
  }
}
}
module hobbed_bolt(h,hobz,hobh=0,od=8,id=6)
{
  hobh=hobh?hobh:od-id;
  cylinder(d=od,h=hobz,$fn=40);
  translate([0,0,hobz]) cylinder(d1=od,d2=id,h=hobh/2,$fn=40);
  translate([0,0,hobz+hobh/2]) cylinder(d2=od,d1=id,h=hobh/2,$fn=40);
  translate([0,0,hobz+hobh]) cylinder(d=od,h=h/2-hobz,$fn=40);
}
module bearing608(){ring(22,8,7);}
module ring(od,id,h)
{
  difference(){
    cylinder(d=od,h=h);
    translate([0,0,-0.01]) cylinder(d=id,h=h+0.02);
  }
}