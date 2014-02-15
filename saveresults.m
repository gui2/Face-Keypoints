function saveresults(im, boxes, posemap, path, i)
%UNTITLED Summary of this function goes here
%Detailed explanation goes here

% showboxes(im, boxes)
% Draw boxes on top of image.

imagesc(im);
hold on;
axis image;
axis off;


%if  ~exist(resultfolder);
% mkdir(resultfolder);
%end;

m=1;
for b = boxes,
   % fName=sprintf('%0.7d-%d-result.txt',i,m);
    saveallto= [path '.txt'];
    partsize = b.xy(1,3)-b.xy(1,1)+1;
   
    tx = (min(b.xy(:,1)) + max(b.xy(:,3)))/2;
    ty = min(b.xy(:,2)) - partsize/2;
    %print the box of the face 
    minX=min(b.xy(:,1));
    maxX=max(b.xy(:,3));
    minY=min(b.xy(:,2));
    maxy=max(b.xy(:,4));
    width = maxX-minX;
    heith = maxy-minY;
   
     
    
    fid = fopen(saveallto,'w') %Open file. Note that this will discard existing data! 
    image =  [path '.jpg']; %sprintf('%0.7d.jpg',i);
   [pathstr, name, ext] = fileparts(image);
   name=[name ext];
    f = [num2str(i) ' '  name ' ' num2str(floor(minX)) ' ' num2str(floor(minY)) ' ' num2str(floor(width)) ' ' num2str(floor(heith)) ' ' num2str(posemap(b.c)) ];
   fwrite(fid, f, 'uchar'); %write data
   fprintf(fid, '\n', 'uchar'); %write data
    for i = size(b.xy,1):-1:1;
       x1 = b.xy(i,1);
       y1 = b.xy(i,2);
       x2 = b.xy(i,3);
       y2 = b.xy(i,4);
       dd =sprintf('%d  %d   %d \n',i, int32((x1+x2)/2),int32((y1+y2)/2));
       fprintf(fid,dd, 'int16'); %write data
    end   
    fclose(fid); %close file, so you wont have problems later  
    m=m+1;
end
end

