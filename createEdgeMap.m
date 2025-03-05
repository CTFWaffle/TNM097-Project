function finalEdgeMap=createEdgeMap(imgray,strelSize)

if nargin<2
    strelSize=1;
end

% Create sobel filters
sobel=fspecial('sobel');
sobelInv=-sobel;
sobelT=fspecial('sobel')';
sobelInvT=-sobelT;

% Create prewitt filters
prewitt=fspecial('prewitt');
prewittT=prewitt';
prewittInv=-prewitt;
prewittInvT=-prewitt';

% Create 45-degree filters soft
ang45=[0 1 2;-1 0 1; -2 -1 0];
ang45T=ang45';
ang45Inv=[2 1 0;1 0 -1; 0 -1 -2];
ang45InvT=-ang45Inv;

% Create 45-degree filters hard
hang45=[0 1 1;-1 0 1; -1 -1 0];
hang45T=hang45';
hang45Inv=[1 1 0;1 0 -1; 0 -1 -1];
hang45InvT=-hang45Inv;

% Apply Sobel filters
output_sobel = imfilter(imgray, sobel);
output_sobelInv = imfilter(imgray, sobelInv);
output_sobelT = imfilter(imgray, sobelT);
output_sobelInvT = imfilter(imgray, sobelInvT);

% Apply Prewitt filters
output_prewitt = imfilter(imgray, prewitt);
output_prewittT = imfilter(imgray, prewittT);
output_prewittInv = imfilter(imgray, prewittInv);
output_prewittInvT = imfilter(imgray, prewittInvT);

% Apply Angle 45 filters
output_ang45 = imfilter(imgray, ang45);
output_ang45T = imfilter(imgray, ang45T);
output_ang45Inv=imfilter(imgray,ang45Inv);
output_ang45InvT=imfilter(imgray,ang45InvT);

% Apply Angle 45(hard) filters
output_hang45 = imfilter(imgray, hang45);
output_hang45T = imfilter(imgray, hang45T);
output_hang45Inv=imfilter(imgray,hang45Inv);
output_hang45InvT=imfilter(imgray,hang45InvT);

% Combine edges into a single map
edgeMap = abs(output_sobel) + abs(output_sobelInv) + abs(output_sobelT) + abs(output_sobelInvT) + abs(output_prewitt) + abs(output_prewittT) + abs(output_prewittInv) + abs(output_prewittInvT) + abs(output_ang45) + abs(output_ang45T) + abs(output_ang45Inv)+ abs(output_ang45InvT) + abs(output_hang45) + abs(output_hang45T) + abs(output_hang45Inv)+ abs(output_hang45InvT);

edgeMap = mat2gray(edgeMap); % Normalizes all values

% Use dilation to connect broken edges
dilatedEdgeMap = imdilate(edgeMap, strel('disk', strelSize));
finalEdgeMap=imclose(dilatedEdgeMap,strel('disk',strelSize));
figure; imshow(finalEdgeMap); title('Dilated Edge Map');

end