
% compile.m should work for Linux and Mac.
% To Windows users:
% If you are using a Windows machine, please use the basic convolution (fconv.cc).
% This can be done by commenting out line 13 and uncommenting line 15 in
% compile.m
compile;

% load and visualize model
% Pre-trained model with 146 parts. Works best for faces larger than 80*80
%  load /afs/.ir/users/p/u/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/face_p146_small.mat
load /home/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/face_p146_small.mat
% % Pre-trained model with 99 parts. Works best for faces larger than 150*150
% load face_p99.mat

% % Pre-trained model with 1050 parts. Give best performance on localization, but very slow
%load /afs/.ir/users/p/u/pusiol/prototypes-vision-ai/trunk/face-release1.0-basic/multipie_independent.mat

%disp('Model visualization');
%visualizemodel(model,1:13);
%disp('press any key to continue');
%pause;


% 5 levels for each octave
model.interval = 5;
% set up the threshold
%model.thresh = min(-0.65, model.thresh);
model.thresh = min(-0.65, model.thresh);

%directoryin='../FaceInput/';
%directoryout= '../FaceResult/';
%directoryin='/hsgs/projects/mcfrank/Guido/Data/Face/XS_2010_objs/';
%directoryout='/hsgs/projects/mcfrank/Guido/Data/Face/XS_2010_objs-Results/';

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
ims = dir([directoryin '*.jpg']);
%ims = getAllFiles(directoryin);

for i = 1:length(ims),
    if ~exist(sprintf([directoryout '/q%0.7d.jpg'],i));  
     
    fprintf('testing: %d/%d\n', i, length(ims));
    im = imread([directoryin ims(i).name]);
     imwrite(im,sprintf([directoryout '/q%0.7d.jpg'],i));
    %clf; imagesc(im); axis image; axis off; drawnow;
    
    tic;
    bs = detect(im, model, model.thresh);
    bs = clipboxes(im, bs);
    bs = nms_face(bs,0.3);
    dettime = toc;
    
    % Show highest scoring one
    im3=figure,showboxes(im,bs,posemap, directoryout, i);
    saveas(im3,[directoryout sprintf('%0.7d.jpg', i)],'jpg');
   
    saveresults(im,bs,posemap,directoryout,i);

    end
     close all;
end
disp('done!');
