function sequences = sequence_list(sequence_index)
    fid = fopen('sequence_list.txt');
    sequences = cell(1, 2);
    
    if sequence_index == 1
        for n = 1:2
            sequences{n} = fgetl(fid);
        end
    elseif sequence_index == 2
        for n = 1:4
            if n > 2   
                sequences{n - 2} = fgetl(fid);
            else
                fgetl(fid);
            end
        end
    end
end