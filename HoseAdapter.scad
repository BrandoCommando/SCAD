t=6;
od=55;
main_height=36;
reduced_dia=31;
reduced_height=10;
reduced_t = 6;
lock_offset = 14;
lock_t = 5;
lock_height = 24;
$fn=50;

echo(str("Reducer Diameter: ", reduced_dia, ", ", (reduced_dia-reduced_t)));
pipe_z = main_height + (od-reduced_dia);

ring(od,od-t,main_height);
color("blue")
translate([0,0,main_height]) ring_adv(od,od-t,reduced_dia,reduced_dia-reduced_t,od-reduced_dia);
translate([0,0,pipe_z]) ring(reduced_dia,reduced_dia-reduced_t,reduced_height);
difference()
{
  lock_od = lock_offset+od;
  intersection(){
    translate([0,-15]) cube([80,34,200]);
    union(){
      ring(lock_od, lock_od - lock_t, lock_height);
      translate([0,0,lock_height]) ring_cone(lock_od,od,lock_t,lock_offset-lock_t);
  //    difference(){
  //    });
    }
  }
  lock_xtrans = (lock_od-lock_t)/2-6;
  echo(str("Lock X: ", lock_xtrans));
  translate([lock_xtrans,-10,-30])
    rotate([35,0]) cube([lock_t+3,20,40]);
  rotate([0,0,8])
  translate([lock_xtrans+4,0,-4]) {
  translate([0,-2]) cube([lock_t+1,6,15]);
  translate([0,-1,12.5]) rotate([40,0,0]) {
    translate([0,-0.5,-1.2]) cube([lock_t+1,6,15.3]);
    translate([0,-0.6,9])
      cube([lock_t+1,2,5]);
  }
  translate([0,-10.4,19]) cube([lock_t,5,4]);
  //translate([0,-7.43,28]) cube([4,12,4]);
  }
  translate([0,0,.5])cylinder(d=od,h=main_height+reduced_height+(od-reduced_dia-1));
}
/*
difference(){
  translate([70,0,50]) {
    difference(){
      union(){
        sphere(d=38);
        rotate([0,90,0]) cylinder(d=38,h=19);
        translate([0,0,-50]) ring(38,33.4,50);
      }
      rotate([0,90,0]) cylinder(d=33.4,h=20);
      sphere(d=33.4);
      translate([0,0,-60]) cylinder(d=33.4,h=60);
    }
    translate([0,0,-50]) {
      cylinder(d=38,h=2);
    }
  }
  translate([70,0])
  {
    for(zm=[1:6])
    {
      for(d=[0:20:359])
      {
          translate([0,0,zm*5-1]) rotate([0,90,d+(zm%2==1?10:0)]) cylinder(d=4,h=30,$fn=4);
      }
    }
    for(d=[0:90:359])
    {
      rotate([0,0,d+22.5]) translate([4,0,-0.01]) cylinder(d=4,h=5.02,$fn=40);
    }
    for(d=[0:45:359])
    {
      rotate([0,0,d]) translate([10,0,-0.01]) cylinder(d=4,h=5.02,$fn=40);
    }
    for(d=[0:30:359])
    {
      rotate([0,0,d+22.5]) translate([16,0,-0.01]) cylinder(d=4,h=5.02,$fn=40);
    }
  }
}
//*/
module ring_adv(odB,idB,odT,idT,h)
{
  difference(){
    cylinder(d1=odB,d2=odT,h=h,$fn=80);
    translate([0,0,-0.1]) cylinder(d1=idB,d2=idT,h=h+.2,$fn=80);
  }
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