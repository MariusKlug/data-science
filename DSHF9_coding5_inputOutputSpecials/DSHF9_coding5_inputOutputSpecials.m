%% Data Science for Human Factors course - script 4
% Input / output
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2018, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Specials
% images

logo = imread('bemobil_logo.jpg');

% images are just pixel matrices with RGB values for each pixel
size(logo)

figure(1); clf;
image(logo)
xticks([])
yticks([])

% easier way to plot images, works with various types
imshow(logo)

% make all white pixels darker
threshold = 220;

logo(1,1,:)
logo(logo>=threshold) = threshold;

subplot(2,1,1,gca)
subplot(212)
imshow(logo)

% write out the image again
imwrite(logo,'bemobil_logo_grey.jpg');

% after inspection, the image has compression artifacts around the edges,
% so we want to have the best possible quality
imwrite(logo,'bemobil_logo_grey_HQ.jpg','Quality',100);


%% audio
% You don't need to understand what happens in the audiospectrogram
% function, and neither the filter or the plots. This is just an
% example for why one could want to do read and write audio files!

[audiodata, srate] = audioread('Rammstein - Ich Will.mp3');

size(audiodata)

freqs = [100 1000];

% plot the spectrogram and dB in chosen frequencies
audiospectrogram(audiodata(:,1),srate,1000,freqs);

% filter
bpFilt = designfilt('bandpassfir','FilterOrder',500, ...
	'CutoffFrequency1',freqs(1),'CutoffFrequency2',freqs(2), ...
	'SampleRate',srate);
fvtool(bpFilt)
audiofiltered = filter(bpFilt,audiodata);

% plot filtered
figure(5);clf
plot(audiofiltered(:,1))
title('filtered data')

% write the filtered data again as .wav file to be able to listen to it
audiowrite('Rammstein - Ich Will _ filtered.ogg',audiofiltered,srate);


%% Extra Special: Movies

figure(6); clf

% initialize the concept with the first frame
% we're going to draw a sinus function
i=2;
x=linspace(0,pi*2,200);
plot(x(i-1:i),sin(x(i-1:i)),'k');
axis([0 2*pi -1.1 1.1]);
hold on

movieMatrix(198) = struct('cdata',[],'colormap',[]);
movieMatrix(1)=getframe;

for i=3:200
	plot(x(i-1:i),sin(x(i-1:i)),'k');
	drawnow
	movieMatrix(i-2)=getframe;
end

figure(7); clf
% pause is necessary for MATLAB to not stumble. it just pauses any execution for 0.1s.
pause(0.1)
movie(movieMatrix)

% save as a MATLAB file
save movieMatrix movieMatrix;


%% Exercise
% load and play again 3 times with 120fps

load movieMatrix
figure(7),clf
pause(1)
movie(movieMatrix,3,120)

%% Now export as .avi movie

writer = VideoWriter('sinfulMovie.avi');
open(writer)
writeVideo(writer,movieMatrix)
close(writer)

% we can adjust settings in the writer
writer = VideoWriter('sinfulMovie_goodQuality.avi');
writer.Quality = 100;
open(writer)
writeVideo(writer,movieMatrix)
close(writer)

writer = VideoWriter('sinfulMovie_goodQuality_highFR.avi');
writer.Quality = 100;
writer.FrameRate = 120;
open(writer)
writeVideo(writer,movieMatrix)
close(writer)

%% gifs
h = figure(8);clf;set(gcf,'color','w')
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'XToThePowerofN.gif';
x = 0:0.01:1;

for n = 1:0.03:5
	
	% Draw plot for y = x.^n
	
	y = x.^n;
	plot(x,y)
	
	% {} after ^ set everything within as superscript
	% num2str can get a specific format, to ensure that it always displays
	% trailing zeros
	title(['f(x) = x^{' num2str(n,'%1.2f') '}'])
	
	drawnow
	
	% Capture the plot as an image
	frame = getframe(h);
	im = frame2im(frame);
	
	% this is necessary for gifs (see help below)
	[imind,cm] = rgb2ind(im,256);
	
	% Write to the GIF File
	if n == 1
		% start the image
		imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.016);
	else
		% fill the gif, delaytime is 1/framerate, so this would be 60hz
		imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.016);
	end
end

%WRITEGIF Write a GIF (Graphics Interchange Format) file to disk.
%	WRITEGIF(X,MAP,FILENAME) writes the indexed image X,MAP
%   to the file specified by the string FILENAME. The extension 
%   '.gif' will be added to FILENAME if it doesn't already 
%   have an extension.
%
%   X can be a single image (M-by-N) or a series of
%   frames(M-by-N-by-1-by-P).  X must be of type uint8, logical, or double.
%   If X is uint8 or logical, then colormap indexing starts at zero.  If X
%   is double, then colormap indexing starts at one.
%
%   MAP can be a single colormap (M-by-3) that is applied to all frames, or a series of colormaps
%   (M-by-3-by-P) where P is the number of frames specified in X.  
%
%   WRITEGIF(X,[],FILENAME) writes the grayscale image GRAY
%   to the file.
%
%   WRITEGIF(...,'writemode','append') appends a single image to a file existing
%   on disk.