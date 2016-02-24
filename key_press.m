load trees;imshow(X,map);
title('Press "*" to quit');
set(gcf,'position',[150 80 720 540]);


keyspressed = [];


k=0;
while ~k
    k = waitforbuttonpress;
    currkey = get(gcf,'currentcharacter');
    if strcmp(currkey,'*')
        k = 1;
        fprintf('KEYS PRESSED: %s\n',keyspressed);
        return
    else
        k = 0;
    end
    if isempty(keyspressed)
        keyspressed = currkey;
    end
    lastkey = keyspressed(end);
    fprintf('You pressed %s.\n',currkey);
    if ~strcmp(currkey,lastkey);
        keyspressed = [keyspressed,currkey];
    end
end
