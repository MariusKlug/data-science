function cleaned_pupil_data = cleanPDwithblinks(eye_pupil_data, blinks)
	cleaned_pupil_data = eye_pupil_data;
	eyeblink_data = diff(blinks);
	blink_onsets_offsets = find(eyeblink_data~=0);
	
	% test if we actually start and end with eyes open
	if eyeblink_data(blink_onsets_offsets(1)) ~= 1
		blink_onsets_offsets(1) = [];
	end
	if eyeblink_data(blink_onsets_offsets(end)) ~= -1
		blink_onsets_offsets(end) = [];
	end
	
	blink_onsets_offsets = reshape(blink_onsets_offsets,[2,length(blink_onsets_offsets)/2])';
	
	for i_blink = 1:length(blink_onsets_offsets)
		
		cleaned_pupil_data(blink_onsets_offsets(i_blink,1)+1:blink_onsets_offsets(i_blink,2)) = ...
			linspace(cleaned_pupil_data(blink_onsets_offsets(i_blink,1)),...
			cleaned_pupil_data(blink_onsets_offsets(i_blink,2)+1),...
			blink_onsets_offsets(i_blink,2)-blink_onsets_offsets(i_blink,1));
	end