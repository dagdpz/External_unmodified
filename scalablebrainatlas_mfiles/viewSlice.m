% modified by audv, original was baaaaaaaaaaaaad

function A=viewSlice(template,sliceNo)
% A=viewSlice('CBCetal15' ,'93');

web(['https://scalablebrainatlas.incf.org/cache/' template '_slice' sliceNo 'L.svg'])
[A map] = imread(['https://scalablebrainatlas.incf.org/cache/' template '_slice' sliceNo 'L.png']);

% a=A;
% for r=1:size(a,1)
%     b(r,:)=[0, diff(a(r,:))];
% end
% b=im2double(b);
% b(b==0)=10000;
% b(b~=0 & b~=10000)=0;
% b(b==10000)=255;
% b=uint8(b);



