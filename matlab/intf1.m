function y = intf1(xx,yy,x)
% 1-dim linear interpolation
% Rewritten on May 8, 2018
% by Takeki Sunakawa
% NOTE: There are two different options wrt how to deal with knot points.
nx = size(xx,1);

ix = 1;
% for x
if (x<=xx(1))

    ix = 1;

elseif (x>=xx(nx))

    ix = nx-1;

else

    for ix = 1:nx-1

        if (x<xx(ix+1)); break; end; % x in [xx(jx-1) xx(jx)) (doesn't include xx(jx)) for jx = 1,2,3,...,nx-1
%        if (x<=xx(ix+1)); break; end; % x in (xx(jx-1) xx(jx)] (doesn't include xx(jx-1)) for jx = 2,3,...,nx

    end
    
end

wx = (x-xx(ix))/(xx(ix+1)-xx(ix));
y = (1-wx)*yy(ix) + wx*yy(ix+1);