echo(str(concat([[0,1]],[[2,3]])));
wedge(a1=0,a2=120,radius=10,$fn=20);
module wedge(angle=0,radius,a1=0,a2=0,$fn=20)
{
  //echo(str("arc: ", arc(0,angle,radius,$fn)));
  astart=a1>0?a1:0;
  aend=a2>0?a2:angle;
  $fn=abs(astart-aend)/$fn;
  echo(str("Angle: ", astart, "-", aend, " $fn=",$fn));
  wpoints=arc(astart,aend,radius,$fn);
  //echo(str("arc: ", wpoints));
  polygon(concat([[0,0]],wpoints));
}

function arc(a1,a2,radius,$fn) =
  (a1+((a2-a1)/$fn)>=a2?
    [arcpoint(a2,radius)] :
    concat([arcpoint(a1,radius)],arc(a1+$fn, a2, radius, $fn)));
function arcpoint(angle,radius) = [radius*cos(angle),radius*sin(angle)];