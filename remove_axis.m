function remove_axis(x_or_y)

axx=gca;
P = get(axx,'Position');
x_tick = get(axx,'XTick');
x_labels = get(axx,'XTicklabel');
x_lim = get(axx,'Xlim');
y_tick = get(axx,'YTick');
y_labels = get(axx,'YTicklabel');
y_lim = get(axx,'Ylim');


axis off
if strcmp(x_or_y,'x')
    axes('Position',[P(1:2) P(3)/10000 P(4)],'Color','none','YTick',y_tick,'YTicklabel',y_labels,'Ylim',y_lim);
elseif strcmp(x_or_y,'y')
    axes('Position',[P(1:2) P(3) P(4)/10000],'Color','none','XTick',x_tick,'XTicklabel',x_labels,'Xlim',x_lim);
elseif strcmp(x_or_y,'xy')
    %axes('Position',[P(1:2) P(3)/10000 P(4)],'Color','none','YTick',y_tick,'YTicklabel',y_labels,'Ylim',y_lim);
    %axes('Position',[P(1:2) P(3) P(4)/10000],'Color','none','XTick',x_tick,'XTicklabel',x_labels,'Xlim',x_lim);
end
