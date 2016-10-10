function [channel1, channel2] = allignChannels(channel1, channel2, displacementRange)

% Initialize temporary variables:
bestChannel2Shifted = channel2;
bestScore = 0;

% Iterate through the window of displacements. For example, if
% 'displacementRange' = [-15, 15], then iterate 'x' from -15 to 15, and 'y' from
% -15 to 15:
for x = displacementRange(1) : displacementRange(2)
    for y  = displacementRange(1) : displacementRange(2)
        
        % Circular shift 'channel2' in 'x' and 'y':
        shiftAmmount = [x, y];
        channel2Shifted = circshift(channel2, shiftAmmount);
        
        % Calculate correlation between the 'channel1' and
        % 'channel2Shifted':
        score = corr2(channel1, channel2Shifted);
        
        % If this shifted channel is more simillar to the 'channel1' than
        % the previous shifts, then cache it:
        if(score > bestScore)
            
            bestScore = score;
            bestChannel2Shifted = channel2Shifted;
            
        end
        
    end
end

% Output the result of the best shifted 'channel2':
channel2 = bestChannel2Shifted;

end