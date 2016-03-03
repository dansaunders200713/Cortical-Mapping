global sequences window_pointer

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

% Begin experiment

for n = 1:length(sequences)
    % start timer
    start_time = clock;
    
    % run trial
    [ trial_incorrect_keys(n), trial_incorrect_sequences(n) ] = trial(sequences{n});
    
    % end timer
    end_time = clock;
    
    % set trial execution time
    trial_times(n) = etime(end_time, start_time);
    
    % let the participant breathe
    pause(2);
end

Screen('FillRect', window_pointer); % clear Screen
Screen('Flip', window_pointer, 0, 2);

% filenames to save the data to
encode_filename = ['encode' subject_code '.txt'];

% write the info to file
fid = fopen(encode_filename, 'w');

for i = 1:length(sequences)
    fprintf(fid, '%s\t %d\t %d\t %d\n', sequences{i}, trial_incorrect_keys(i), trial_times(i), trial_incorrect_sequences(i));
end

fclose(fid);


