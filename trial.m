function [ num_incorrect_keys ] = trial(sequence)

    global window_pointer red blue black
    
    while(KbCheck); end % clear keyboard buffer
    Screen('FillRect', window_pointer); % clear Screen  
    
    keys_pressed = [];

    textSize = 75; % make the text BIG!
    Screen('TextSize', window_pointer, textSize);
    
    sequence_correct = false;
    
    while (sequence_correct == false)
        DrawFormattedText(window_pointer, sequence, 'center', 'center', black);
        string = GetEchoString(window_pointer, '>', 700, 675, black, [255 255 255]);
        if strcmp(string, sequence)
            sequence_correct = true;
        else
            Screen('FillRect', window_pointer); % clear Screen  
            Screen('DrawText', window_pointer, 'TRY AGAIN', 100, 200, red);
        end
    end
    
    Screen('FillRect', window_pointer); % clear Screen
    Screen('DrawText', window_pointer, 'CORRECT', 100, 200, blue); 
    Screen('Flip', window_pointer, 0, 2);

    num_incorrect_keys = length(keys_pressed) - length(sequence);
end

