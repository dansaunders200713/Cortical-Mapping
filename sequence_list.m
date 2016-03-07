function sequences = sequence_list(sequence_index)
    word_sequences = fopen('word_sequences.txt')
    jumbled_sequences = fopen('jumbled_sequences.txt');

    sequences = cell(1, 200);
    
    if sequence_index == 1
        for n = 1:200
            if mod(n, 2) == 1 
                sequences{n} = fgetl(word_sequences);
            else
                sequences{n} = fgetl(jumbled_sequences);
            end
        end
    elseif sequence_index == 2
        for n = 1:400
            if n > 200 && mod(n, 2) == 0
                sequences{n - 200} = fgetl(word_sequences);
            elseif n > 200 && mod(n, 2) == 1
                sequences{n - 200} = fgetl(jumbled_sequences);
            else
                fgetl(fid);
            end
        end
    end
end