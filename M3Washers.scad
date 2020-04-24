for(x=[1:9])
{
  translate([x*10,0])
    disc(h=0.3+(x/5));
  translate([x*10,10])
    disc(h=0.3+(x/5));
}

module disc(od=8,id=4,h=1)
{
  echo(str("Disc H: ", h));
difference(){
  cylinder(d=od,h=h,$fn=30);
  translate([0,0,-.01]) cylinder(d=id,h=h+.02,$fn=40);
}
}