
compile;
load /home/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/face_p146_small.mat


% 5 levels for each octave
model.interval = 10;
model.thresh = min(-0.65, model.thresh);

ims = getAllFiles(directoryin);
if ~exist(directoryout);
     mkdir(directoryout);
end;

% define the mapping from view-specific mixture id to viewpoint
if length(model.components)==13 
    posemap = 90:-15:-90;
elseif length(model.components)==18
    posemap = [90:-15:15 0 0 0 0 0 0 -15:-15:-90];
else
    error('Can not recognize this model');
end

im = zeros(250,250,3);
 
for i = 1:length(ims),
     p= char(ims(i,1));
     [pathstr, name, ext] = fileparts(p);
     name=[name ext];
    
    if ~exist(sprintf([directoryout name]));  
  
     im = imread(p); 
    % [m n r]=size(im)
    % rgb=zeros(m,n,3);
    % rgb(:,:,1)=im;
    % rgb(:,:,2)=rgb(:,:,1);
    % rgb(:,:,3)=rgb(:,:,1);
    % im=rgb/255; 
    % imshow(im);
     
  
     imwrite(im,sprintf([directoryout name],i));
    
     tic;
     bs = detect(im, model, model.thresh);
     bs = clipboxes(im, bs);
     bs = nms_face(bs,0.3);
     dettime = toc;
    
     % Show highest scoring one
     im3=figure,showboxes(im,bs,posemap,directoryout,i);
     saveas(im3,[directoryout 'bbox' name]);
     saveresults(im,bs,posemap,directoryout,i);
    
     end
     close all;
end
disp('done!');



