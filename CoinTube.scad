tube_count = 4;
coin_count = 50;
tube_floors = "yes"; // [yes,no]
coin1="quarter"; // [quarter,dime,nickel,penny,custom]
coin2="nickel"; // [quarter,dime,nickel,penny,custom]
coin3="penny"; // [quarter,dime,nickel,penny,custom]
coin4="dime"; // [quarter,dime,nickel,penny,custom]

/* [Custom] */
// Coin 1 Tube Size
custom_tube1_size=24;
// Coin 1 Coin Height
custom_coin1_height=1.75;
// Coin 1 Step
custom_coin1_step=10;
// Coin 1 Step Value
custom_coin1_step_value=10;
// Coin 2 Tube Size
custom_tube2_size=20;
// Coin 2 Coin Height
custom_coin2_height=2;
// Coin 2 Step
custom_coin2_step=10;
// Coin 2 Step Value
custom_coin2_step_value=10;
// Coin 3 Tube Size
custom_tube3_size=20;
// Coin 3 Coin Height
custom_coin3_height=1.5;
// Coin 3 Step
custom_coin3_step=10;
// Coin 3 Step Value
custom_coin3_step_value=10;
// Coin 4 Tube Size
custom_tube4_size=20;
// Coin 4 Coin Height
custom_coin4_height=1.35;
// Coin 4 Step
custom_coin4_step=10;
// Coin 4 Step Value
custom_coin4_step_value=10;

/* [Hidden] */
tube1_size = coin1=="quarter"?25:(coin1=="dime"?19:(coin1=="nickel"?22:(coin1=="penny"?20:custom_tube1_size)));
tube2_size = coin2=="quarter"?25:(coin2=="dime"?19:(coin2=="nickel"?22:(coin2=="penny"?20:custom_tube2_size)));
tube3_size = coin3=="quarter"?25:(coin3=="dime"?19:(coin3=="nickel"?22:(coin3=="penny"?20:custom_tube3_size)));
tube4_size = coin4=="quarter"?25:(coin4=="dime"?19:(coin4=="nickel"?22:(coin4=="penny"?20:custom_tube4_size)));
coin1_height = coin1=="quarter"?1.75:(coin1=="nickel"?2:(coin1=="dime"?1.35:(coin1=="penny"?1.5:custom_coin1_height)));
coin2_height = coin2=="quarter"?1.75:(coin2=="nickel"?2:(coin2=="dime"?1.35:(coin2=="penny"?1.5:custom_coin2_height)));
coin3_height = coin3=="quarter"?1.75:(coin3=="nickel"?2:(coin3=="dime"?1.35:(coin3=="penny"?1.5:custom_coin3_height)));
coin4_height = coin4=="quarter"?1.75:(coin4=="nickel"?2:(coin4=="dime"?1.35:(coin4=="penny"?1.5:custom_coin4_height)));
coin1_step = coin1=="quarter"?4:(coin1=="nickel"?5:custom_coin1_step);
coin1_step_value = coin1=="quarter"||coin1=="dime"?1:(coin1=="nickel"?.25:(coin1=="penny"?.1:custom_coin1_step_value));
coin2_step = coin2=="quarter"?4:(coin2=="nickel"?5:custom_coin2_step);
coin2_step_value = coin2=="quarter"||coin2=="dime"?1:(coin2=="nickel"?.25:(coin2=="penny"?.1:custom_coin2_step_value));
coin3_step = coin3=="quarter"?4:(coin3=="nickel"?5:custom_coin3_step);
coin3_step_value = coin3=="quarter"||coin3=="dime"?1:(coin3=="nickel"?.25:(coin3=="penny"?.1:custom_coin3_step_value));
coin4_step = coin4=="quarter"?4:(coin4=="nickel"?5:custom_coin4_step);
coin4_step_value = coin4=="quarter"||coin4=="dime"?1:(coin4=="nickel"?.25:(coin4=="penny"?.1:custom_coin4_step_value));
tube_height = max(coin1_height, tube_count > 1 ? coin2_height : coin1_height, tube_count > 2 ? coin3_height : (tube_count > 1 ? coin2_height : coin1_height), tube_count > 3 ? coin4_height : (tube_count > 2 ? coin3_height : (tube_count > 1 ? coin2_height : coin1_height))) * coin_count;

$fn=80;

coin_pair(tube1_size,tube_height,coin_count,coin1_height,coin1_step,coin1_step_value,tube_floors);
if(tube_count > 1)
  translate([0,(tube1_size+tube2_size)/2+1,0])
    coin_pair(tube2_size,tube_height,coin_count,coin2_height,coin2_step,coin2_step_value,tube_floors);
if(tube_count > 2)
  translate([0,tube1_size+((tube2_size+tube3_size)/2)+1,0])
    coin_pair(tube3_size,tube_height,coin_count,coin3_height,coin3_step,coin3_step_value,tube_floors);
if(tube_count > 3)
  translate([0,tube1_size+tube2_size+((tube3_size+tube4_size)/2)+1,0])
    coin_pair(tube4_size,tube_height,coin_count,coin4_height,coin4_step,coin4_step_value,tube_floors);

module coin_pair(d,h,coin_count,coin_height,coin_step,step_value,tube_floors)
{
  echo(str("Coin Pair: ", d, ", ", h, ", ", coin_count, ", ", coin_height, ", ", coin_step, ", ", step_value));
  coin_tube(d,h,coin_count,coin_height,coin_step,step_value);
  if(tube_floors=="yes")
  {
  translate([30,0,0])
  difference() {
    cylinder(d=d-.8,h=5);
    translate([0,0,2])
      cylinder(d=d-3,h=5);
  }
}
}
module coin_tube(d=25,th=80,coin_count=40,coin_height=1.75,coin_step=10,step_value=1)
{
  toph = coin_height + 2;
  difference(){
    tube(d,th);
    translate([d/2-1,-1,4])
      cube([3,2,th-8]);
  }
  for(lvl=[coin_step:coin_step:coin_count])
  {
    z=th-(coin_height*1.05*lvl);
    if(z>4) {
    translate([d/2,-2,z]) {
      cube([2,4,1]);
      num=(lvl/coin_step)*step_value;
      translate([0,2,1])
      rotate([90,0,90])
      linear_extrude(2)
      text(str(num),size=4,halign="center");
    }
    }
  }
  translate([0,0,th])
  difference() {
    color("blue") cylinder(d=d+2,h=toph);
    translate([0,0,-.5]) cylinder(d=d-4,h=toph+1);
    translate([0,(d+2)*-.5,-.5])
    cube([d+2,d+2,toph+1]);
    translate([0,0,-1])
      cylinder(d=d,h=coin_height*1.05);
    translate([0,0,coin_height-1])
      cylinder(d1=d,d2=d-4,h=coin_height*1.05);
  }
}

module tube(d,h,t=2)
{
  difference(){
    cylinder(d=d+t,h=h);
    translate([0,0,t]) cylinder(d=d,h=h);
  }
}