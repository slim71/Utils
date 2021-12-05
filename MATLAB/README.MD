# MATLAB

This folder contains useful MATLAB functions I've implemented along the way.

## figure2()

This provides an alternative to the standard **figure()** functions, to 
automatically detect a second screen and open the figures in it (if available). 
The number of figures in not yet supported.

Credits go to *Jan*, in [this post](https://it.mathworks.com/matlabcentral/answers/16663-is-it-possible-to-viewing-the-figure-window-on-second-display)
in the Mathworks Forum.
*WindowState* added as for [this post](https://it.mathworks.com/matlabcentral/answers/98331-is-it-possible-to-maximize-minimize-or-get-the-state-of-my-figure-programmatically-in-matlab)

## indexAt()

Useful script to automatically extract an indexed element of a returning value
from the specified expression.

Credits go to *Walter Roberson & Stephen* in the answer at [this post](https://it.mathworks.com/matlabcentral/answers/127342-access-a-single-element-of-an-anonymous-function-that-returns-an-array)
in the Mathworks forum.

They first coded this as an anonymous function, I've simply implemented it as
readily-available.

## outval()

Useful script to automatically pick one or more return values from a function
that has more than one.

Implemented based on [this post](https://it.mathworks.com/matlabcentral/answers/96038-how-can-i-capture-an-unknown-number-of-output-arguments-in-a-cell-array-in-matlab-7-5-r2007b)
in the Mathworks forum.
