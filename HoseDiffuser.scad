t=4;
od=57;
main_height=36;
reduced_dia=57;
reduced_height=50;
reduced_t = 4;
$fn=50;

ring(od,od-t,main_height);
translate([0,0,main_height]) ring_cone(od,reduced_dia+(t-reduced_t),t,od-reduced_dia);
color("blue") {
  difference() {
    union(){
      translate([0,0,main_height+od-reduced_dia]) ring_cone(reduced_dia,reduced_dia,reduced_t,reduced_height);
      translate([0,0,main_height+reduced_height]) cylinder(d=reduced_dia,h=reduced_t);
    }
    translate([0,0,main_height]) {
      for(zm=[2:10])
      {
        for(d=[0:20:359])
        {
            translate([0,0,zm*5-2]) rotate([0,90,d+(zm%2==1?10:0)]) cylinder(d=4,h=30,$fn=4);
        }
      }
      translate([0,0,reduced_height-reduced_t])
      {
      for(d=[0:90:359])
      {
        rotate([0,0,d+22.5]) translate([6,0,-0.01]) cylinder(d=4,h=50.02,$fn=40);
      }
      for(d=[0:45:359])
      {
        rotate([0,0,d]) translate([14,0,-0.01]) cylinder(d=4,h=50.02,$fn=40);
      }
      for(d=[0:30:359])
      {
        rotate([0,0,d+22.5]) translate([22,0,-0.01]) cylinder(d=4,h=50.02,$fn=40);
      }
    }
    }
  }
}

color("green")
difference()
{
  intersection(){
    translate([0,-15]) cube([80,30,200]);
    union(){
      ring(68,64,26);
      translate([0,0,26]) ring_cone(68,56,4,10);
  //    difference(){
  //    });
    }
  }
  translate([28,-10,-30])
    rotate([35,0]) cube([20,20,40]);
  rotate([0,0,8])
  translate([30,0,-4]) {
  translate([0,-2]) cube([4,6,15]);
  translate([0,-1,12.5]) rotate([40,0,0]) {
    translate([0,-0.5,-1.2]) cube([4,6,15.3]);
    translate([0,-0.6,9])
      cube([4,2,5]);
  }
  translate([0,-10.4,19]) cube([4,5,4]);
  //translate([0,-7.43,28]) cube([4,12,4]);
  }
  translate([0,0,.5])cylinder(d=od,h=main_height+reduced_height+(od-reduced_dia-1));
}

module ring_cone(odB,odT,t,h)
{
  difference(){
    cylinder(d1=odB,d2=odT,h=h,$fn=odB*2);
    translate([0,0,-0.1]) cylinder(d1=odB-t,d2=odT-t,h=h+.2,$fn=odB*2-t*2);
  }
}

module ring(od,id,h)
{
  difference(){
    cylinder(d=od,h=h,$fn=od*2);
    translate([0,0,-0.01]) cylinder(d=id,h=h+0.02,$fn=id*2);
  }
}