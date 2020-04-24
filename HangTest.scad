cube([64,30,2]);
intersection()
{
  cube([60,40,20]);
  translate([0,0,10]) mirror([0,0,1])
for(x=[0:4])
{
  translate([2+pow(x+1,2)*3,20]) {
    cylinder(d2=5-x,d1=5+x*5,h=10,$fn=20+x*5);
      echo(str("#",x+1,": ",5-x,"/",5+x*5));
    translate([0,0,x*-1-1]) sphere(d=2.5+x*2.5,$fn=40);
  }
  translate([5+x*10,5]) translate([0,0,0])
    rotate([0,x*15]) translate([-2,0,0]) cube([4,4,15]);
}
}