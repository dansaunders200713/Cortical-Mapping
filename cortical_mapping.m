global subject_code task sequences window_pointer white red black blue

%================ Get info =================
% get the subject/session info
subject_code = input('What is the subject code (3 letter string, please)?   ', 's');
task = input('Is this (1) encoding, or (2) recall?  ');

cd '/home/dan/MATLAB/Cortical Mapping';

% here, we set up some psychophysics toolbox objects for 
% drawing text to the screen.

try
    screens = Screen('Screens');
    screenNumber = max(screens);

    window_pointer = PsychImaging('OpenWindow', screenNumber);

    white = WhiteIndex(window_pointer);
    red = [255 0 0 255];
    black = BlackIndex(window_pointer);
    blue = [0 0 255 255];
    
    % White background:
    Screen('FillRect', window_pointer);
    % Show it by flipping the buffers:
    Screen('Flip', window_pointer);
    
catch
    % this "catch" section executes in case of an error in the "try" section
    % above. Importantly, it closes the onscreen window if it's open.

    RestoreCluts;
    Screen('CloseAll');
    Screen('Preference', 'SkipSyncTests', 0);
    psychrethrow(psychlasterror);

end

% randomize the presentation of the sequences of words / characters lists
assign_filename = ['assign' subject_code '.txt'];
if task == 1
    sequence_index = randsample(2,1);
    save assign_filename sequence_index
else
    load assign_filename sequence_index
    if sequence_index == 1
        sequence_index = 2;
    elseif sequence_index == 2
        sequence_index = 1;
    end
end

sequences = sequence_list(sequence_index);

% STARTING THE EXPERIMENT

while(KbCheck); end %Wait for all keys to be released (clear keyboard buffer)

Screen('TextSize', window_pointer, 30);
Screen('DrawText', window_pointer, 'Welcome to the my experiment!', 100, 200, black); 
Screen('DrawText', window_pointer, 'For instructions, please press a key.', 80, 400, black);
Screen('Flip', window_pointer);
Screen('TextSize', window_pointer, 26);

keyIsDown = 0;
while(keyIsDown == 0)
    [keyIsDown, ~, ~] = KbCheck;
end

% Here, we branch based on the user's input to the initial prompts
% (encode vs. recall)

if task == 1       % encode
    encode();
elseif task == 2   % recall
    recall();
end

fclose('all');
Screen('CloseAll');
clear;
