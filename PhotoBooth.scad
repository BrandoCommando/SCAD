tx=feet(5);
ty=feet(4);
tz=feet(6);
sections=[1.5,2,2.5];
for(y=[0,ty-20],x=[0,tx-20]) translate([x,y,20+(x==0?0:tz-feet(sections[0]))]) color("blue") tube(feet(sections[0])-20,2);
for(y=[0,ty-20],x=[0,tx-20]) translate([x,y,20+(x==0?feet(1.5):tz-feet(sections[0])-feet(sections[1]))]) color("green") tube(feet(sections[1])-20,2);
for(y=[0,ty-20],x=[0,tx-20]) translate([x,y,20+(x==0?feet(sections[0])+feet(sections[1]):0)]) color("red") tube(feet(sections[2])-20,2);
for(y=[0,ty-20],z=[0,tz-20]) translate([20,y,z]) tube(tx-40);
for(z=[0,tz-20],x=[0,tx-20]) translate([x,20,z]) tube(ty-40,1);
for(yo=[0,ty/2+20],zf=[2.5,4.5]) translate([tx-20,yo,feet(zf)]) color("purple") tube(ty/2-20,1);
for(yo=[-20,0]) translate([tx-20,ty/2+yo,feet(2.5)]) tube(feet(2)+20,2);
for(yo=[0,ty/2]) translate([0,yo,feet(sections[0])+feet(sections[1])]) color(yo==0?"teal":"aqua") tube(ty/2,1);
for(y=[0,ty-20]) translate([0,y,feet(1.5)]) tube(feet(2));
translate([feet(2),0,feet(1.5)]) color("blue") tube(ty,1);
for(xo=[-20,0],y=[0,ty-20]) translate([feet(2)+xo,y,20]) tube(feet(1.5)-20,2);

module tube(length,dir="x")
{
  cube([
    dir==0||dir=="x"?length:20,
    dir==1||dir=="y"?length:20,
    dir==2||dir=="z"?length:20
  ]);
}
function feet(mm) = 25.4*12*mm;