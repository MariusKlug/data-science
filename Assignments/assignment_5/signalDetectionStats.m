% signalDetectionStats 

function [hits, misses, FAs, block_names] = signalDetectionStats(input_events, n_blocks)

% parse all events

% initiate variables
[hits, misses, FAs] = deal(zeros(n_blocks,1));
block_names = cell(n_blocks,1);
current_block = 0;

% count