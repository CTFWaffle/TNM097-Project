function filtered=rgb_filter(img)
%   R = SNR(X, Y) computes the signal to noise ratio (SNR) in dB.
%   The signal X and the noise Y are first filtered by a filter
%   representing the eye.

f=MFTsp(15,0.0847,500);
% Denna funktion returnerar ett lågpass filter som representerar ögat. I
% detta fall betraktningsavståndet har satts till 500 mm och punkternas
% storlek till 0.0847. Observera att punktens storlek motsvarar ett tryck
% i 300 dpi. (0.0847 = 1/300 * 25.4 mm)

% Ögats filter är applicerat till signalen (originalbilden)
filtered=cat(3,conv2(img(:,:,1),f,'same'),conv2(img(:,:,2),f,'same'),conv2(img(:,:,3),f,'same'));


%Remove negative values
filtered=double(filtered>=0).*filtered;


% Man räknar snr mellan signalen och noise-en efter att de har gått genom
% ögats filter

end