id=58;
od=id+4;

ring(od,id,40);
translate([0,id*-.5,17]) rotate([90,0,0]) cylinder(d=5,h=10,$fn=20);

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