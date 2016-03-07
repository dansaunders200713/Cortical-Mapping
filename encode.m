global sequences window_pointer resolution

% this script corresponds to the encode phase of the experiment, in which
% the participant is presented with both sequences of words and jumbles of
% characters to type on either the standard keyboard or the jumbled keyboard, 
% depeding on the value of session_number

while(KbCheck); end % clear keyboard buffer

Screen('FillRect', window_pointer); % clear Screen

% Here, we place on-screen instructions for the participant. Waiting on
% Janna to draft these up.

% variables to keep track of
trial_times = zeros(1, length(sequences));
trial_incorrect_keys = zeros(1, length(sequences));
trial_incorrect_sequences = zeros(1, length(sequences));
trial_num_characters = zeros(1, length(sequences));
trial_num_tokens = zeros(1, length(sequences));
trial_is_jumble = zeros(1, length(sequences));

% Begin experiment

Screen('FillRect', window_pointer); % clear Screen

while(KbCheck); end % Wait for all keys to be released (clear keyboard buffer)

Screen('TextSize', window_pointer, 75);
DrawFormattedText(window_pointer, 'Standard Keyboard Portion', 'center', 'center', black);
Screen('TextSize', window_pointer, 30);
DrawFormattedText(window_pointer, 'To begin, press any key.', 'center', (resolution.height / 2) + 100, black);
Screen('Flip', window_pointer);
Screen('TextSize', window_pointer, 26);

keyIsDown = 0;
while(keyIsDown == 0)
    [keyIsDown, ~, ~] = KbCheck;
end

% Begin standard keyboard portion

start_time = clock; % start timer for standard keyboard block

for n = 1:75
    % start timer
    trial_start_time = clock;
    
    % run trial
    [ trial_incorrect_keys(n), trial_incorrect_sequences(n) ] = standard_keyboard_trial(sequences{n});
    
    % end timer
    trial_end_time = clock;
    
    % set trial execution time
    trial_times(n) = etime(trial_end_time, trial_start_time);
    
    % set other metrics
    trial_num_characters(n) = length(find(~isspace(sequences{n})));
    trial_num_tokens(n) = length(strsplit(sequences{n}));
    if mod(n, 2) == 1
        trial_is_jumble(n) = 0;
    else
        trial_is_jumble(n) = 1;
    end
    
    % let the participant breathe
    pause(2);
    
    if etime(clock, start_time) > 300 % if the timer exceeds 5 minutes
        break % the block has completed
    end
end

% end standard keyboard portion

Screen('FillRect', window_pointer); % clear Screen

while(KbCheck); end % Wait for all keys to be released (clear keyboard buffer)

Screen('TextSize', window_pointer, 75);
DrawFormattedText(window_pointer, 'Jumbled Keyboard Portion', 'center', 'center', black);
Screen('TextSize', window_pointer, 30);
DrawFormattedText(window_pointer, 'To begin, press any key.', 'center', (resolution.height / 2) + 100, black);
Screen('Flip', window_pointer);
Screen('TextSize', window_pointer, 26);

keyIsDown = 0;
while(keyIsDown == 0)
    [keyIsDown, ~, ~] = KbCheck;
end

% Begin jumbled keyboard portion

start_time = clock; % start timer for jumbled keyboard block

for n = 76:200
    % start timer
    trial_start_time = clock;
    
    % run trial
    [ trial_incorrect_keys(n), trial_incorrect_sequences(n) ] = jumbled_keyboard_trial(sequences{n});
    
    % end timer
    trial_end_time = clock;
    
    % set trial execution time
    trial_times(n) = etime(trial_end_time, trial_start_time);
    
    % set other metrics
    trial_num_characters(n) = length(find(~isspace(sequences{n})));
    trial_num_tokens(n) = length(strsplit(sequences{n}));
    if mod(n, 2) == 1
        trial_is_jumble(n) = 0;
    else
        trial_is_jumble(n) = 1;
    end
    
    % let the participant breathe
    pause(2);
    
    if etime(clock, start_time) > 900 % if the timer exceeds 15 minutes
        break % the block has finished
    end
end

Screen('FillRect', window_pointer); % clear Screen
Screen('Flip', window_pointer, 0, 2);

% filenames to save the data to
encode_filename = ['encode' subject_code '.txt'];

% write the info to file
fid = fopen(encode_filename, 'w');

fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %s\n', 'Incorrect Keys', 'Trial Time', 'Incorrect Entries', 'Number of Characters', 'Number of Tokens', 'Is Jumble');

for i = 1:length(sequences)
    fprintf(fid, '%d\t %s\t %d\t %d\t %d\t %d\n', trial_incorrect_keys(i), num2str(trial_times(i), '%4.2f'), trial_incorrect_sequences(i), trial_num_characters(i), trial_num_tokens(i), trial_is_jumble(i));
end

fclose(fid);


