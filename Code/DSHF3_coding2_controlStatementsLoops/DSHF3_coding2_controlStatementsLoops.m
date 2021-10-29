%% Data Science for Human Factors course - script 3
% Complex variables, control statements and loops
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2021, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Structs are one of the most complex data container variables in MATLAB 
% we will deal with. They contain fields and associated values, 
% indexed by a dot (.):

clear students

students.name = 'Beispiel';
students.given_name = 'Barbara';
students.age = 25;
students.major = 'HF';

% you can also have an array of structs
students(2).name = 'Max Mustermann';
students(2).given_name = 'Damn, I wrote my entire name in the wrong section already!';
students(2).age= 27;
students(2).major = 'HF'

% now you can access it in different ways
students(1)
students(2).name
students.given_name

% note that this last result came out as two separate answers again. 
% If you want to combine them into a single output 
% (e.g., a cell array or vector), use appropriate brackets around:
all_names = {students.name}
all_ages = [students.age]

%% EXERCISE
% Create an array of 10 "numbers" structs with the field "one" and the 
% value 1 for all structs by using deal() and []. Hint: It's doable in one 
% line. The output should look like this:

% numbers = 
% 
% 1x10 struct array with fields:
% 
%     one
% 
% >> numbers(5).one
% 
% ans =
% 
%      1



%% Cell arrays can store all kinds of variables and act like matrices

cell_array = {text_vector1 text_char2, vector1}

% cells are basically like matrices, so can also be transposed
cell_array2 = {text_vector1 ; text_char2 ; vector1}
cell_array'

% indexing of a cell works differently. use {} to index the 
% content of a cell
cell_array(2)
cell_array{2}

% notice how this gives you two answers
clc
cell_array{2:3}

% we can catch them using []
[content1 content2] = cell_array{2:3}

% we can even put struct arrays in the cell array
cell_array{4} = students

%% Finding out the class of a variable

% mostly obvious, but if you need it in a code, it's possible:
class(vector1)
class(text_char)
class(students)

isnumeric(vector1)
ischar(vector1)
ischar(text_vector1)

isa(vector1,'double')

%% EXERCISE
% Convert the students struct array a) to a cell array b) and back again.
% Hint: fieldnames()

load students_data



isequal(students,students_struct_back)

%% IF-ELSE
% Exactly what you'd expect
randnum = randn;

if 4>5
	disp('Something strange just happened...')
end


% with an alternative
if 4>5
	disp('Something is still very wrong')
else
	% note the two single-quote marks inside the string
	disp('Whew! Everything''s normal.')
end


% more alternatives
if randnum>2
	disp('Big number')
elseif randnum>0 && randnum<2
	disp('Not so big')
elseif randnum<0 && randnum>-2
	disp('A bit on the negative side')
else
	disp('super negative')
end

% combining statements
if abs(randnum)>2 && sign(randnum) == 1
	disp('Big positive number')
elseif abs(randnum)<2 && sign(randnum) == 1
	disp('Small positive number')
elseif abs(randnum)>2 && sign(randnum) == -1
	disp('Big negative number')
elseif abs(randnum)<2 && sign(randnum) == -1
	disp('Small negative number')
else
	disp('This should never be reached...')
end

%% SWITCH-CASE
% the 'switch/case' statement is similar to 'if/else'

animal = 'monkey';

switch animal
	% compares variable "animal" to 'dog'
	case 'dog'
		fav_food = 'cheese';
	case 'cat'
		fav_food = 'bird-flavored yogurt';
	case 'monkey'
		fav_food = 'bananas';
		% adding the following line produces strange results
		%         animal = 'cat';
	otherwise
		fav_food = 'pizza';
end % end switch

disp([ 'In the wild, the ' animal ' prefers to eat ' fav_food '.' ])

%% FOR-LOOPS
% A for-loop is a way to iterate repeatedly

for counting_variable = 1:10
	disp(counting_variable);
end

% an if-statement embedded in a loop
for i_num=1:10
	if mod(i_num,2)==0
		disp([ 'The number ' num2str(i_num) ' is even.' ])
	else
		disp([ 'Hm. This is odd...' ])
	end
end

% another example:
for i = 1:2:10
	% what's wrong here?
	disp([ 'The ' num2str(i) 'th iteration value times 2 divided by 3 is '...
		num2str(i*2/3) '.' ])
end

% solutions: counter
numbers = 1:2:10;
counter_for_loop = 0;
for i = numbers
	counter_for_loop = counter_for_loop + 1;
	disp([ 'The ' num2str(counter_for_loop)...
		'th iteration value times 2 divided by 3 is '...
		num2str(i*2/3) '.' ])
end

% You can embed loops within loops
for i = 1:5
	for j = 3:7
		% Matlab produces a warning here because product_matrix is not initialized.
		product_matrix(i,j) = i*j;
	end
end

product_matrix

% Two important things to note about the example above:
% (1) You can use the same numbers as indices AND as variables;
% (2) Unspecified elements in a matrix are automatically created
%       and set to zero.

% Solution: initialize matrix with zeros
% having many spaces is allowed and facilitates code aesthetics
number_rows    = 5;
number_columns = 5;
product_matrix = zeros(number_rows,number_columns);

for i=1:number_rows
	for j=1:number_columns
		product_matrix(i,j)=i * (j+2);
	end % end j-loop
end % end i-loop

product_matrix

% note the comments following end-statements. When you have multiple long
% loops, this kind of commenting will be helpful. Also note that when you
% click on one of the "for" or "end" statements, its match will be underlined.

%% EXERCISE
% Write a script section that will display the numbers from 5 to 25
% with a step of 5 two times, using different for loops.


%% WHILE-LOOPS
% while loops are similar to for-loops except:
%   1) You don't need to specify before-hand how many iterations to run,
%   2) The looping variable is not implicitly updated;
%       you have to increment it yourself.

toggle = false;

idx = 1;
while toggle
	disp([ 'I''m working on step ' num2str(idx) ' and it makes me happy.' ])
end

toggle = true;

idx = 1;
% use CTRL-C to abort!
while toggle
	disp([ 'I''m working on step ' num2str(idx) ' and it makes me happy.' ])
end

%% example of while loop

% initialize values to 100
[learning_efficiency,init_val] = deal( 100 );

toggle = true;

while toggle
	
	% decrease value by 5%
	% this could be a comprehensive optimization algorithm which
	% results in a learning efficiency for each step that is large
	% in the beginning and decreases to the end
	learning_efficiency = learning_efficiency * .95;
	
	% compute percent change from initial value
	pctchng = 100*(init_val-learning_efficiency) / init_val;
	
	% round to 2 decimal points
	pctchngRound = round(pctchng*100)/100;
	
	% display message
	disp([ 'Value = ' num2str(learning_efficiency) ', '...
		num2str(pctchngRound)...
		'% change from original value.' ])
	
	% check if toggle should be switched off
	if learning_efficiency<1
		toggle = false;
	end
	pause(0.05)
end

% what can be optimized in this while script?

%%
% initialize values to 100
[learning_efficiency,init_val] = deal( 100 );

iterations = 0;

while learning_efficiency>1
	
	% decrease value by 5%
	learning_efficiency = learning_efficiency * .95;
	
	iterations = iterations + 1;
	
	% compute percent change from initial value
	percent_change = 100*(init_val-learning_efficiency) / init_val;
	
	% round to 2 decimal points
	percent_change_rounded = round(percent_change*100)/100;
	
	% display message
	disp([ 'Iteration = ' num2str(iterations) ',Value = '...
		num2str(learning_efficiency) ', '...
		num2str(percent_change_rounded)...
		'% change from original value.' ])
	
	pause(0.05)
end

%% EXERCISE
% What is the difference between the following for-loop vs. while-loop?
% Find two ways of changes/additions to the while loop to make them the same.

% loop 1
for i = 1:6
	disp([ 'Iteration ' num2str(i) ])
end

% loop 2
j = 1;
toggle = true;
while toggle
	disp([ 'Iteration ' num2str(j) ])
	
	j = j + 1;
	if j > 6, toggle=false; end
	
end

