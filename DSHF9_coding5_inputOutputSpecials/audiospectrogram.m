function audible_scaled = audiospectrogram(audiodata,srate,time_resolution_ms,freqs)

figure(1);clf 
plot(audiodata)
title('Raw data')

%% compute spectral analysis

n_samples_per_sec = 1000/time_resolution_ms;
winlength = srate/(n_samples_per_sec/2);

[s,f,t,p] = spectrogram(audiodata',winlength,winlength/2,winlength,srate,'yaxis');
% transform to dB
res_spectrogram_dB = 10*log10(p);

figure(2); clf
plot(f,mean(res_spectrogram_dB,2))
title('Spectrum')

figure(3); clf

surf(t,f,res_spectrogram_dB)
shading interp
rotate3d on
title('Spectrogram')

xlabel('time')
ylabel('frequency')
%% plot dB values
audible = mean(res_spectrogram_dB(find(f>freqs(1),1,'first'):find(f<freqs(2),1,'last'),:),1);
figure(4);clf; 
plot(t,audible)
title('power (dB)')

xlabel('time')
%% scale the final results

audible_scaled = scale_to_range(audible,1,3999);

function res = scale_to_range(data,minval,maxval)
% this is a hidden subfunction just for making it easier to read

data = data - min(data);
data = data / max(data);
res = (data * (maxval - minval)) + minval;
