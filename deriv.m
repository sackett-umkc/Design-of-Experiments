function zd = deriv(z,dt)
%
%  DERIV  Smoothed numerical differentiation.  
%
%  Usage: zd = deriv(z,dt);
%
%  Description:
%
%    Computes smoothed derivatives of measured time series 
%    by differentiating a local quadratic least-squares fit 
%    to the set of points consisting of each data point 
%    and its four nearest neighboring points.  
%
%  Input:
%    
%     z = vector or matrix of measured time series.
%    dt = sampling interval, sec.
%
%  Output:
%
%    zd = vector or matrix of smoothed time derivatives.
%

%
%    Calls:
%      None
%
%    Author:  Eugene A. Morelli
%
%    History:  
%      13 Jan  1996 - Created and debugged, EAM.
%      06 Sept 2001 - Modified to accept row or column vectors, EAM.
%
%  Copyright (C) 2006  Eugene A. Morelli
%
%  This program carries no warranty, not even the implied 
%  warranty of merchantability or fitness for a particular purpose.  
%
%  Please email bug reports or suggestions for improvements to:
%
%      e.a.morelli@nasa.gov
%
[m,n]=size(z);
zd=zeros(m,n);
%
%  Put data in column vectors if necessary,
%  and set the number of data points.
%
if m < n
  zd=zd';
  z=z';
  npts=n;
else
  npts=m;
end
%
%  Analytic expressions for the derivative of local 
%  polynomial fits to the noisy measured data.  
%  The expressions are different near the endpoints 
%  because there are not enough neighboring points on one side.
%
zd(1,:)=(-54*z(1,:)+13*z(2,:)+40*z(3,:)+27*z(4,:)...
         -26*z(5,:))/(70*dt);
zd(2,:)=(-34*z(1,:)+3*z(2,:)+20*z(3,:)+17*z(4,:)...
         -6*z(5,:))/(70*dt);
zd(3:npts-2,:)=(-2.*z(1:npts-4,:)-z(2:npts-3,:)+z(4:npts-1,:)...
                +2.*z(5:npts,:))/(10.*dt);
zd(npts-1,:)=(34*z(npts,:)-3*z(npts-1,:)-20*z(npts-2,:)...
              -17*z(npts-3,:)+6*z(npts-4,:))/(70*dt);
zd(npts,:)=(54*z(npts,:)-13*z(npts-1,:)-40*z(npts-2,:)...
            -27*z(npts-3,:)+26*z(npts-4,:))/(70*dt);
%
%  Switch data back to original form, if necessary.
%
if m < n
  zd=zd';
  z=z';
end
return
