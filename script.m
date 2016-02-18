scanList = zeros(1, 256);
for i = 65:90
    scanList(i) = 1;
end
pause(1);
keyIsDown = 0;
while(keyIsDown == 0)
    [keyIsDown, secs, keyCode] = PsychHID('KbCheck', 0, scanList);
end

keyCode