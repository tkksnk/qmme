% GOLDEN Computes maximum of the function using golden section search
% USAGE
%   [x] = golden(fname,xmin,xmax,varargin);
% INPUTS
%   fname    : the name of the function to be maximized
%   xmin     : the left point of x
%   xmax     : the right point of x
%   varargin : the other inputs for the function
%
% OUTPUTS
%   x :  maximum point
%
% USES: none
%
% See also:

% January 5 2011, Takeki Sunakawa
% takeki.sunakawa@gmail.com

function x = golden(fname,xmin,xmax,varargin)

global critg;

rg = (3-sqrt(5))/2;

a = xmin;
b = xmax;
c = a + rg*(b-a);
fc = feval(fname,c,varargin{:});

d = a + (1-rg)*(b-a);
fd = feval(fname,d,varargin{:});

% critg = 1e-5;
diff = 1e+4;
iter = 0;

while (diff>critg)

    if (fc>=fd)

        z = c + (1-rg)*(b-c);
        a = c;
        c = d;
        fc = fd;
        d = z;
        fd = feval(fname,d,varargin{:});

    else

        z = a + rg*(d-a);
        b = d;
        d = c;
        fd = fc;
        c = z;
        fc = feval(fname,c,varargin{:});

    end

    diff = d-c;
    iter = iter+1;
%     s = sprintf( ' iteration %4d:  New x = %6.8f',iter,z);
%     disp(s);

end

x = c;