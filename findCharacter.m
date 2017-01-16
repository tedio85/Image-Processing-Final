function MR3 = findCharacter(input)
%   find the average gray level of the main character

% k = edge(input, 'Canny',[0.05 0.80]);
% figure(1);
% title('Canny');
% imshow(k);


% [M,N] = size(input);
% 
% thresh = graythresh(input);
% 
% e = input;
% 
% for i=1:M
%     for j=1:N
%         if(e(i,j)>=thresh)
%             e(i,j) = 0;
%         else
%             e(i,j) = 1;
%         end
%     end
% end
% figure(2);
% title('Global threshold');
% imshow(e);

end

