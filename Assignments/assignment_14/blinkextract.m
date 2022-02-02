function [newPR,bl,threshold] = blinkextract(PR,n,searchbuffer,applybuffer)
% BLINKEXTRACT returns the major and minor axis PS with blinks removed and returned in b.
%
%    V 1.0   17 July 2009    Ravi Chacko
%    V 1.1   24 Aug  2009    Andy Mitz, documentation only
%    V 1.6   25 Aug  2009    More detailed reporting during processing. Some error trapping
%    V 2.0    7 Oct  2009    Explicitly calls findpeaks2007b.m
%    V 2.7    9 Nov  2009    bl was a row vector. Changed now into a column vector to match PR
%	 V 2.8	  5 Nov  2019    MK changes for NeSitA Project, bemobil.bpn.tu-berlin.de
%
% INPUTS
%   PR				original Pupil Radius
%    n				number of standard deviations away from the mean (to establish blink threshold)
%					3 is a sufficient n.
%	searchbuffer	buffer around coarse theshold based blink detection to find more fine grained blinks (in samples)
%	applybuffer		buffer around actually detected peaks (in samples)
%
% OUTPUTS
%   newPR    array    Pupil Radius (size) without spikes (blinks removed)
%      bl    array    b=1 for applybuffer samples around detected blinks, 0 elsewhere
%   threshold		  threshold that was used for peak detection

%%
fprintf('Blink extraction  ');

% MK: added "nan" to allow for more robust estimation also when tracking was lost or subjects blinked very much.
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
	if PR(counter) < threshold
% 		PR(counter)
		lbound = counter;
		while PR(counter) < (m-n*s) && counter < LPR
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


%% ========= Nested subfunction link() =========
% link the ends before and after blink
	function l = link(l,r)
		
		ext = searchbuffer;     % MK: changed from 100 to allow individual buffers
% 		rate and also to account for changes in peak detection
		
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
		
		% MK changes to find actually blink start and end, not just peaks of
		% pupil size
		
		left = max(1,l-applybuffer); % left always starts at the applybuffer before threshold was reached, can't be lower than the first sample
		
		% right is after the last blink in the searchbuffer ends, plus
		% applybuffer
		pk_threshold = (max(pks)-min(pks))/3; % MK: we can ignore small pks, the large are actual blinks, the small are other pupil dilation
		
		locs(pks<pk_threshold) = [];
		
		if isempty(locs)==0;
			right = l-ext+locs(length(locs));
			right = right+applybuffer; % MK added to have a buffer around blinks again after finding exact blink end
			if right > LPR    % to stay below upperbound
				right = LPR;
			end
			
			% MK: make sure it always at least stays within the [l,r]
			% boundaries, otherwise it can lead to issues when a blink is
			% happening at the end of the data
			right = max(r,right);
		else
			return;
		end
		
		% MK: added to ensure that if the search starts or ends during a
		% blink it is correctly identified
		if PR(rb)<threshold
			right = min(LPR,rb+applybuffer);
		end
		
		
		bl(left:right)=1;
		counter=right; %MK: changed from right+20 to account for instances 
% 		where counter jumped just at the next sample above the threshold
		
		%difference between points, starting 5 points before where PR reaches threshold to cut out little spikes
		dif = PRlinked(right)-PRlinked(left);
		incr = dif/(right-left+1);    % the increment to each point
		for count = 1:(right-left)
			PRlinked(left+count) = PR(left)+count*incr;  %  linking the blink points
		end
		
	end % end of nested subfunction link()

end % end of blinkextract()
