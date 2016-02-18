global sequences window_pointer

% this script corresponds to the encode phase of the experiment, in which
% the participant is presented with both sequences of words and jumbles of
% characters to type on either the standard keyboard or the jumbled keyboard, 
% depeding on the value of session_number

while(KbCheck);end % clear keyboard buffer

Screen('FillRect', window_pointer); % clear Screen

% Here, we place on-screen instructions for the participant. Waiting on
% Janna to draft these up.

% variables to keep track of
time_per_trial = zeros(1, sequences);
num_incorrect_keys = zeros(1, sequences);

% Begin experiment

for n = 1:length(sequences)
    
    while(KbCheck); end % clear keyboard buffer
    Screen('FillRect', window_pointer); % clear Screen  
    
    sequence = sequences{n};

    textSize = 75; % make the text BIG!
    Screen('TextSize', window_pointer, textSize);
    DrawFormattedText(window_pointer, sequence, 'center', 'center', black);
    Screen('Flip', window_pointer, 0, 2);
    
    sequence_correct = false;
    while (sequence_correct == false)
        string = GetEchoString(window_pointer, '>', 875, 675, black, [255 255 255]);
        if strcmp(string, sequence)
            sequence_correct = true;
        end
    end
    
    pause(2);
end



