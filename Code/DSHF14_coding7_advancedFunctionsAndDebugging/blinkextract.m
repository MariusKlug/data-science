function [newPR,bl] = blinkextract(PR,n)
% BLINKEXTRACT returns the major and minor axis PS with blinks removed and returned in b.
%
%    V 1.0   17 July 2009    Ravi Chacko  
%    V 1.1   24 Aug  2009    Andy Mitz, documentation only
%    V 1.6   25 Aug  2009    More detailed reporting during processing. Some error trapping
%    V 2.0    7 Oct  2009    Explicitly calls findpeaks2007b.m
%    V 2.7    9 Nov  2009    bl was a row vector. Changed now into a column vector to match PR 
%
% INPUTS
%   PR          original Pupil Radius 
%    n          number of standard deviations away from the mean (to establish blink threshold)
%               2 is a sufficient n.
%
% OUTPUTS
%   newPR    array    Pupil Radius (size) without spikes (blinks removed)
%      bl    array    b=1 for first 50 points after initiation of a blink and 0 elsewhere
% 
% USE
%   To get one Pupil Size vector you have to get the max of the two PS channels:
%        PRs = max(AllPR{3,tno},AllPR{4,tno}); 
%   before passing PRs into blinkextract()
%    
%
   fprintf('Blink extraction  ');% MK: added "nan" to allow for more robust estimation also when tracking was lost or subjects blinked very much.
    PR(PR<0.2) = NaN;
    m=nanmean(PR); 
    s=nanstd(PR);
    threshold = (m-n*s); %threshold n std devs below the mean, line added by MK
    PR(isnan(PR)) = 0; % Enable searching again

   PRlinked = PR;
   counter=1;
   LPR=length(PR);
   bl = zeros(LPR,1);
   progress = 10;
   fprintf('0');
   while counter < LPR;
       
       if counter/LPR*100 >= progress
          fprintf('..%d',progress);
          progress=progress+10;
       end
       if PR(counter) < (m-n*s) %threshold n std devs below the mean
           lbound = counter;       
           while PR(counter) < threshold && counter < LPR
               counter=counter+1;
           end        
           rbound = counter;       
           link(lbound,rbound); % cuts out spike, see nested function link below
       else
           counter = counter+2; 
       end
   end % while
   fprintf('..100\n');
   newPR = PRlinked; % return linked pupil radius (without spikes)


% ========= Nested subfunction link() =========
   % link the ends before and after blink
   function l = link(l,r) 

      ext = 100;     % look 100 samples in either direction
      if l-ext < 1   % Clip values that go below sample number 1
          lb = 1;
      else
          lb = l-ext;
      end
          
      if r+ext > LPR  % Clip values that go above the end of the data
          rb = LPR;
      else
          rb = r+ext;
      end
           
      diblink = diff(PR(lb:rb));
      [pks,locs] = findpeaks2007b(abs(diblink));
      if isempty(locs)==0;
          left = l-ext+locs(1);
          if left < 1       % to stay above lowerbound
              left = 1;
          end
          right = l-ext+locs(length(locs));    
          if right > LPR    % to stay below upperbound
              right = LPR;
          end
      else
          return;
      end
     
      bl(left:right)=1;
      counter=right;
      %difference between points, starting 5 points before where PR reaches threshold to cut out little spikes 
      dif = PRlinked(right)-PRlinked(left); 
      incr = dif/(right-left+1);    % the increment to each point
      for count = 1:(right-left)
         PRlinked(left+count) = PR(left)+count*incr;  %  linking the blink points
      end
     
   end % end of nested subfunction link()
 
end % end of blinkextract()
