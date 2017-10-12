function [edgeStruct]=CreateGridUGMModel(NumFils, NumCols, K )
%
% NumFils, NumCols: image dimension
% K: number of states




nNodes = NumFils*NumCols;


adj = sparse(nNodes,nNodes);

%BEGIN TODO
% Add Down Edges
ind = 1:nNodes;
exclude = sub2ind([NumFils NumCols],repmat(NumFils,[1 NumCols]),1:NumCols); % No Down edge for last row
ind = setdiff(ind,exclude);
adj(sub2ind([nNodes nNodes],ind,ind+1)) = 1;

% Add Right Edges
ind = 1:nNodes;
exclude = sub2ind([NumFils NumCols],1:NumFils,repmat(NumCols,[1 NumFils])); % No right edge for last column
ind = setdiff(ind,exclude);
adj(sub2ind([nNodes nNodes],ind,ind+NumFils)) = 1;

% Add Up/Left Edges
adj = adj+adj';

%End of TODO

% edgeStruct = UGM_makeEdgeStruct(adj,K,0);
edgeStruct = UGM_makeEdgeStruct(adj,K);