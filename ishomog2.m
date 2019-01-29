%ISHOMOG2 Test if SE(2) homogeneous transformation matrix
%
% ISHOMOG2(T) is true (1) if the argument T is of dimension 3x3 or 3x3xN, else 
% false (0).
%
% ISHOMOG2(T, 'valid') as above, but also checks the validity of the rotation
% sub-matrix.
%
% Notes::
% - The first form is a fast, but incomplete, test for a transform in SE(3).
%
% See also ISHOMOG, ISROT2, ISVEC.




% Copyright (C) 1993-2017, by Peter I. Corke
%
% This file is part of The Robotics Toolbox for MATLAB (RTB).
% 
% RTB is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% RTB is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
% 
% You should have received a copy of the GNU Leser General Public License
% along with RTB.  If not, see <http://www.gnu.org/licenses/>.
%
% http://www.petercorke.com

function h = ishomog2(T, rtest)
    h = false;
    d = size(T);
    
    if ndims(T) >= 2
        if ~(all(d(1:2) == [3 3]))
            return %false
        end

        if nargin > 1
            for i = 1:size(T,3)
                % check rotational part
                R = T(1:2,1:2,i);
                e = R'*R - eye(2,2);
                if norm(e) > 10*eps
                    return %false
                end
                e = abs(det(R) - 1);
                if norm(e) > 10*eps
                    return %false
                end
                % check bottom row
                if ~all(T(3,:,i) == [0 0 1])
                    return %false
                end
            end
        end
    end

    h = true;
end