% compile.m should work for Linux and Mac.
% To Windows users:
% If you are using a Windows machine, please use the basic convolution (fconv.cc).
% This can be done by commenting out line 13 and uncommenting line 15 in
% compile.m
%compile;
%path ../distributions/Base_MVN_DC/;
%path ../util;
% load and visualize model
% Pre-trained model with 146 parts. Works best for faces larger than 80*80
% load /afs/.ir/users/p/u/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/face_p146_small.mat
%load face_p146_small.mat
% % Pre-trained model with 99 parts. Works best for faces larger than 150*150
addpath  mmread
load face_p99.mat

% % Pre-trained model with 1050 parts. Give best performance on localization, but very slow
%load /afs/.ir/users/p/u/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/multipie_independent.mat

%disp('Model visualization');
%visualizemodel(model,1:13);
%disp('press any key to continue');
%pause;

% Read one frame at a time.
% 5 levels for each octave
model.interval = 10;
% set up the threshold
model.thresh = min(-0.75, model.thresh);
%model.thresh = min(-0.80, model.thresh);
%directoryin='/Users/Gui/Images/FXS_TRACK/INPUT';
out ='/OUT/';
%
ims = getAllFiles(directoryin);
% define the mapping from view-specific mixture id to viewpoint
if length(model.components)==13 
    posemap = 90:-15:-90;
elseif length(model.components)==18
    posemap = [90:-15:15 0 0 0 0 0 0 -15:-15:-90];
else
    error('Can not recognize this model');
end

   im = zeros(250,250,3);
  
for i = 1:length(ims), % for each video 
    
    %Create 
          p= char(ims(i,1));
          [pathstr, name, ext] = fileparts(p);
          name=[name ext];
     
          directoryout =[directoryin out name '/'];
     
          if ~exist(directoryout);
          mkdir(directoryout);
          end;
          
    xyloObj = VideoReader(p); % open the fucker
    get(xyloObj)
    nFrames = xyloObj.NumberOfFrames;

    for k = 1 :25: nFrames
     im = read(xyloObj, k);
     
    if ~exist(sprintf([ directoryout  name '-%d' '.jpg'],k));  
  
    % im = imread(p); 
     %[m n r]=size(im)
     %rgb=zeros(m,n,3);
     %rgb(:,:,1)=im;
     %rgb(:,:,2)=rgb(:,:,1);
     %rgb(:,:,3)=rgb(:,:,1);
     %im=rgb/255; 
  
     imwrite(im,sprintf([ directoryout  name  '-%d' '.jpg'],k));
    
     tic;
     bs = detect(im, model, model.thresh);
     bs = clipboxes(im, bs);
     bs = nms_face(bs,0.3);
     dettime = toc;
    
     iptsetpref('ImshowBorder','tight');
     % Show highest scoring one
     im3=figure,showboxes(im,bs,posemap,directoryout,k);


     set(gca,'visible','off')
     nametosave =sprintf([directoryout   name '-%d'],k);
     saveas(im3, [nametosave '.jpg']);
     saveresults(im,bs,posemap,nametosave,k);
    
     %end
     close all;
    end
    end
end
disp('done!');



