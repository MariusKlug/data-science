%% Data Science for Human Factors course - script 2
% Scripts, style, and variable classes
% 
% This script is free to use and distribute for anybody!
% 
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% This is a sript section

% This is a normal comment (Toggle using CTRL-R and CTRL-T)

% Use comments regularly and explain what is happening in the code. 
% But don't overuse it, it's better to write code that
% explains itself with good naming of variables and functions

% Sections can be folded together by clicking the little "-" 
% on the side or by using the "View"->"Collapse All" button

% Scripts are essentially only textfiles that are interpreted by the 
% MATLAB Editor and converted to runable code

% You can run the entire script with the "Play" button or by
% pressing F5

% You can run code segtions by clicking "Run Section" or by 
% pressing CTRL-ENTER

%% Numerical variables: Scalars, Vectors, Matrices 
% (which are actually all the same)

% use meaningful variable names
scalar = 5
vector1 = [1:5]

% naming is case-sensitive! Use lowercase variables. 
Vector = [2:6]
vector = 1:3
vector2 = Vector

whos *ector

% use the semicolon (;) to separate lines
matrix = [1:5; 2:6]
matrix = [1 2 3 4 5; 2 3 4 5 6]
matrix = [1,2, 3, 4, 5; 2 3 4 5 6]
matrix = [1 2 3 4 5
          2 3 4 5 6]

% Error: Dimensions of matrices being concatenated are not consistent.
error = [ 1:5; 2:5]

% reassign using vriables
matrix = [vector1; vector2]

% vectors can be row vectors (as before) or column vectors:
rowvector = [1:5]
columnvector = [1;2;3;4;5]

% using the transpose operator (') or function (transpose()) 
% switches this
another_columnvector = rowvector'
another_columnvector = transpose(rowvector)

% the same works for matrices: rows become columns and the other 
% way round
transposed_matrix = matrix'

%% Matrix operations

% scale a vector or a matrix
scaled_vec = vector1 * scalar
scaled_mat = matrix * scalar

% multiply vectors
% vector1 * vector2 % error
vector1 * vector2' % dot product
vector2' * vector1 % why is this a matrix?!
vector1 .* vector2 % individual element multiplication
vector1 .* vector2' % what's this?!

% matrix fun
P = [2, 4; 6, 8]
Q = [1, 2; 3, 4]

P*Q
Q*P
P/Q
Q/P

% individual operation is also possible
P.*Q
P./Q

% matrix division mathematically means the multiplication withe the inverse
divided = P/Q
multiplied_with_inverse = P*inv(Q)

% should be 1! what's wrong?!
is_divided_equal_to_multiplied =...
    isequal(divided,multiplied_with_inverse) 

divided-multiplied_with_inverse % minimal rounding errors are the culprit

% same thing happens after scaling with a float value
% compute the hypothenuse of a right triangle and 
% compare with the actual value
shortSide = 3;
longSide = 5;
otherSide = 4;
longSide^2 == (shortSide^2 + otherSide^2)

scaleFactor = 0.01;
(scaleFactor*longSide)^2 == ((scaleFactor*shortSide)^2 +...
    (scaleFactor*otherSide)^2)

(scaleFactor*longSide)^2
((scaleFactor*shortSide)^2 +...
    (scaleFactor*otherSide)^2)

(scaleFactor*longSide)^2 -...
((scaleFactor*shortSide)^2 +...
    (scaleFactor*otherSide)^2)

%% Indexing

% yes
vector2(2)
vector2(2:3)
vector2([2 4 5])
vector2(end)
vector2(end-1)

% nope: Subscript indices must either be real positive 
% integers or logicals.
% vector2(0.5)

% matrix indexing. use colon (:) to index entire rows/columns
matrix(2,3)
matrix(2,:)
matrix(1,[2 5])

% possible but can be irritating! Linear indexing is hard to tame.
matrix(7)
% essentially makes any n-dimensional matrix a vector, appending columns
matrix(:)

% delete single elements with " = []"
copy_vector1 = vector1;
copy_vector1(3)=[]

copy_matrix = matrix;
copy_matrix(1,:)=[]

% what happens here? why?
copy_matrix = matrix;
copy_matrix(1,2) = []

% and here?
copy_matrix(7) = []

%% EXERCISE
n = 5;
m = 10;

% Create a matrix with normally distributed random numbers with n cols
% and m rows. Create code that finds the minimum of each row and of each column 
% of your random matrix using min(). Find the maximum of the entire matrix.

randmat = randn(m,n)
colmin = min(randmat,[],1)
rowmin = min(randmat,[],2)
totalmax = max(randmat(:))

%% Common mistakes

% Index exceeds matrix dimensions.
vector1(6)

% but what happens here?
vector1(6) = 6
% -> this is possible and also regularly in use, but takes a little 
% more time than already allocated variable
% assignments and can sometimes also be hard to debug.

% indexing a wrong variable: Undefined function 'vector' for
% input arguments of type 'double'.
vector4(6)

% assigning must always have the same size: 
% In an assignment  A(:) = B, the number of elements in A and B must be the same.
vector1(1:3) = 1:4
vector1(1:3) = 100:-1:98

% for matrices it is: Subscripted assignment dimension mismatch.
matrix(:,2) = 6:10

% check the size of your matrix!
size(matrix)

% would work:
matrix(:,2) = [1 7]
matrix(2,:) = 6:10

%% Doubles, integers, and singles

% let's create an integer variable that does not contain 
% floating point values
number_int = 5

% well... apparently it's a double, not an int, and MATLAB 
% just rounds for visualization
whos number_*

% there are many integer classes
number_actual_int = int8(5)

% integer variables take less space on the disk
whos number_*

number_double = 5.5

whos number_*

% there's another floating point variable class
number_single = single(number_double)

% singles take half the space of doubles, but they also are 
% less accurate for decimal representation
whos number_*

% -> in most cases, numerical values (scalars, vectors, matrices) 
% are doubles, in rare cases it can be useful to create
% integers or singles, if you have large datasets with specific 
% properties.

%% Variables for text

% most common: char array
text_char = 'This is a text!'
whos text*

% possible as well
text_string = string('This is a string text!')
whos text*
text_string = "This is a string text!"

% there are every now and then some functions that require using 
% specifically strings or chars only. Normally you will
% be fine with using chars and forget about strings though.

% combine chars with []
text_char2 = ' And this is another.'
text_concatenated = [text_char text_char2]

%% Convert between numerical and character variables
text_vector1 = num2str(vector1)
text_concatenated2 = [text_concatenated text_vector1]

% can be combined
text_char3 = ['The vector 1 contains the vlaues: ' num2str(vector1)]

% the other way round
numbers_again = str2num(text_vector1)
numbers_again + 1

% what happens if you do this?
problem = text_vector1 + 1

% -> character arrays are coded in ASCII
whos *vector1

% you can index them the same way
text_char3(1:7)

%% Logical variables store true/false 
% and are created using logical operators:
% == ~= < > <= >= 
a = 1;
b = 2;
logical_a_smaller_than_b = a<b

% logicals are not the same as numbers 
logical_another_tue = 1
whos logical*

% but can mostly be converted freely
logical_a_smaller_than_b == logical_another_tue
logical_a_smaller_than_b + 1

% can work with chars as well but does a point-wise 
% comparison of the ASCII codes
text_1 = 'asdf'
text_2 = 'sdff'

text_1 == text_2
% When comparing using ==, matrix dimensions must agree.
text_1 == text_vector1

% better use strcmp
strcmp(text_1,text_vector1)

% use tilde (~) to negate
~logical_a_smaller_than_b

% indexing by logicals
% generate sample data
x = rand(1, 10)
greater_than_a_half_x = x > 0.5
x(greater_than_a_half_x) = NaN % NaN = "Not a Number" and 
% indicates some kind of "does not exist"

% logicals can be combined using & && | || operators
% & | can operate on arrays and always evaluate the second 
% statement, && || short-circuit and operate on scalar logicals only
y = rand(1, 10)
greater_than_a_half_y = y > 0.5

greater_than_a_half_in_both =...
    greater_than_a_half_x & greater_than_a_half_y
greater_than_a_half_in_both =...
    greater_than_a_half_x && greater_than_a_half_y

% short circuiting has some benefits but can also hide bugs
test_shortcircuit1 = logical_a_smaller_than_b || doesntexist
test_shortcircuit2 = ~logical_a_smaller_than_b && doesntexist

% single & and | operators always evaluate the entire statement 
test_shortcircuit3 = logical_a_smaller_than_b | doesntexist
test_shortcircuit4 = ~logical_a_smaller_than_b & doesntexist

% In general it's better to use && and || especially in loops and 
% conditional statements. You can create a construct in
% which you test whether a value is applicable for further 
% evaluation and if so evaluate, all in a single test line
c = 0;
( c~=0 && 1/c ) > 1

% actually dividing by 0 is allowed in MATLAB 
1/c

% Inf and -Inf are placeholders that will always be greater/smaller 
% than any numerical value

% REMEMBER: = is an assignment and == is a logical operator that 
% compares if things are equal!

