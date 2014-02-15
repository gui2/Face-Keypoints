function showboxes(im, boxes, posemap, directoryout,w)

imagesc(im);
hold on;
axis tight;
set(gca,'visible','off')
m=1;


for b = boxes,
    folder = [directoryout num2str(posemap(b.c))];
    if  ~exist(folder);
         mkdir(folder);
    end;
    %print the box of the face 
    minX=min(b.xy(:,1));
    maxX=max(b.xy(:,3));
    minY=min(b.xy(:,2));
    maxy=max(b.xy(:,4));
    width = maxX-minX;
    heith = maxy-minY;
    % i build the rectangle containing the image
    rect =[minX,minY,width,heith];
    I2 = imcrop(im,rect);
    image=[folder '/' sprintf('%0.7d-%d.jpg',w,m)];
    imwrite(I2, image);
    
   % line([minX minX maxX maxX minX]', [minY maxy maxy minY minY]', 'color', 'y', 'linewidth', 0.5);    
    partsize = b.xy(1,3)-b.xy(1,1)+1;
    tx = (min(b.xy(:,1)) + max(b.xy(:,3)))/2;
    ty = min(b.xy(:,2)) - partsize/2;
    text(tx+width/2,ty+heith/2-30, 'angle:','fontsize',20,'color','y');
    text(tx+width/2,ty+heith/2, num2str(posemap(b.c)),'fontsize',35,'color','y');
    
   
    for i = size(b.xy,1):-1:1;
       x1 = b.xy(i,1);
       y1 = b.xy(i,2);
       x2 = b.xy(i,3);
       y2 = b.xy(i,4);
      % line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'r', 'linewidth', 1);      
      text((x1+x2)/2+2,(y1+y2)/2, num2str(i),'fontsize',13,'color','k');
      plot((x1+x2)/2,(y1+y2)/2,'r.','markersize',10);
    end
    m=m+1;
end

set(gca,'units','pixels') % set the axes units to pixels
x = get(gca,'position') % get the position of the axes
set(gcf,'units','pixels') % set the figure units to pixels
y = get(gcf,'position') % get the figure position
set(gcf,'position',[y(1) y(2) x(3) x(4)])% set the position of the figure to the length and width of the axes
set(gca,'units','normalized','position',[0 0 1 1]) % set the axes units to pixels

drawnow;
