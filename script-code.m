clc; clear; close all;

I = imread('img.tif');


%image size
imH = size(I, 1);
imW = size(I, 2);

%sliding window size
windowWidth = 525;
windowHeight = 525;

%step
step = 525;

%introducing temporary variables
temp1 = [];
temp2 = [];
temp3 = [];

tic;

%loop through each pixel in the image
for row = 1:step:imH 
    for col = 1:step:imW 
       
     r = (row - 1) / imH + 1;
     c = (col - 1) / imW + 1;
     
        %sliding window value
        W = I(row:min(end,row+imH-1), col:min(end,col+imW-1));
       
        %creating a mask
        mask = ones(65, 65, 3);
        mask(33:33, 33:33, 1) = 0.5;
        
        
        %rectangle (window) position
        pos = [c r windowHeight windowWidth];
        
          R = W(:,:,1);
          G = W(:,:,2);
          B = W(:,:,3);
          
        % RGB intervals for every sliding window
matchNh = (R > 45 & R < 180)&...
          (G > 50 & G < 185)&...
          (B > 160 & B < 215);  
 
matchNd = (R > 40 & R < 115)&...
          (G > 6 & G < 80)&...
          (B > 10 & B < 75);
    
       
          % counting number of nonzeros for pixels calculation PIc
 Nh = nnz(matchNh);
 Nd = nnz(matchNd);


 temp1 = [temp1, Nh];
 temp2 = [temp2, Nd];
 temp3 = [temp3, pos];
 
 pic = Nd / (Nh + Nd);
 

   if pic > 0.666
       
   subplot(121); imshow(I); title 'Image';
   hold on;      
    
   rectangle('Position', pos, 'FaceColor', '(0 0 1)');
   
  
   elseif pic < 0.666
       
   subplot(121); imshow(I); title 'Image';
   hold on;  
   
   rectangle('Position', pos, 'FaceColor', '(1 1 0)');
   
   %imageobj = imhandles(gcf)
    
   else
   subplot(121); imshow(I); title 'Image';
   hold on;  
     
   rectangle('Position', pos, 'EdgeColor', 'r')
   hold off;   
   end
   
   
    subplot (122); imshow(W); title(pic);
    drawnow;
    pause(0.0001);
   
 
    end 
    
end
toc;

sumNh = sum(temp1)
sumNd = sum(temp2)

%index proliferation
PIc = sumNd / (sumNd+sumNh)

