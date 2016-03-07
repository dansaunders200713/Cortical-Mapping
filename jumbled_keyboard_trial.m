function [ trial_incorrect_keys, trial_incorrect_sequences ] = jumbled_keyboard_trial(sequence)

    global window_pointer red blue black
    
    while(KbCheck); end % clear keyboard bufferend
    Screen('FillRect', window_pointer); % clear Screen
    
    keys_pressed = 0;

    textSize = 75; % make the text big
    Screen('TextSize', window_pointer, textSize);
    
    sequence_correct = false; 
    trial_incorrect_sequences = 0; % the number of times the user pressed enter after entering an incorrect sequence
    
    while (sequence_correct == false)
        DrawFormattedText(window_pointer, sequence, 'center', 'center', black);
        [string, fullstring] = GetEchoString3(window_pointer, '>', 700, 675, black, [255 255 255], sequence);
        temp_keys_pressed = keys_pressed + length(strrep(fullstring, '?', ''));
        if strcmp(string, sequence) % if the entry is correct
            sequence_correct = true; % break out of this loop
            keys_pressed = keys_pressed + temp_keys_pressed; % set the number of keys_pressed equal to the number of keys pressed and the current input
        else
            Screen('FillRect', window_pointer); % clear Screen  
            Screen('DrawText', window_pointer, 'TRY AGAIN', 100, 200, red); % try again text
            trial_incorrect_sequences = trial_incorrect_sequences + 1; % increment number of incorrect entries
            keys_pressed = keys_pressed + strdist(string, sequence); 
        end
    end
    
    Screen('FillRect', window_pointer); % clear Screen
    Screen('DrawText', window_pointer, 'CORRECT', 100, 200, blue); 
    Screen('Flip', window_pointer, 0, 2);
    
    trial_incorrect_keys = keys_pressed - length(sequence);
end
