maind=inches(1);
ithick=3;

difference() {
  //translate([maind*-.5-ithick,maind*-.5-ithick,maind*-.5-ithick]) cube([maind+ithick*2,maind+ithick*2,maind/2+1.99]);
  union() {
  bottom_female();
    //top_male();
}}
translate([maind+ithick*2+6,0]) intersection(){
  mirror([0,0,1])
    top_male();
  translate([maind*-.5-ithick-2,maind*-.5-ithick-2,-2]) cube(maind+ithick*2+4);
}

module bottom_female()
{
  difference() {
    translate([maind*-.5-ithick-2,maind*-.5-ithick-2,maind/-2-ithick-2])
      cube([maind+ithick*2+4,maind+ithick*2+4,maind/2+ithick+2]);
    scale((ithick*2)/maind+1) object();
  }
}
module top_male()
{
  translate([maind*-.5-ithick-2,maind*-.5-ithick-2]) cube([maind+ithick*2+4,maind+ithick*2+4,maind/2+ithick+2]);
    object();
}
module object()
{
  sphere(d=maind,$fn=80);
  *for(x=[-15,15])
    translate([x,0,-20]) sphere(d=20,$fn=40);
}

function inches(in) = 25.4 * in;