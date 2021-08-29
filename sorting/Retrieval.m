function [images, nImages, precision, recall, AP] = Retrieval(trainingFeatures, trainingLabels, testFeatures, testLabels, numReturnedImages, similarity, weight)

if nargin == 4
    numReturnedImages = 20;
    similarity = 'euclidean';
    weight = 0;
elseif nargin == 5
    similarity = 'euclidean';
    weight = 0;
elseif nargin == 6
    weight = 0;
end

N = size(trainingLabels,1);
M = size(testLabels,1);

if nargin==7 && strcmp(similarity,'euclidean')
    [~,images] = pdist2(trainingFeatures, testFeatures,'seuclidean', weight,'Smallest',N);
else
    if strcmp(similarity,'camberra')
        [~,images] = camberra(trainingFeatures, testFeatures);
    elseif strcmp(similarity,'D1')
        [~,images] = D1(trainingFeatures, testFeatures);
    elseif strcmp(similarity,'chi2')
        [~,images] = chi2(trainingFeatures, testFeatures);
    elseif strcmp(similarity,'KLDiv')
        [~,images] = KLDiv(trainingFeatures, testFeatures);
    else
        [~,images] = pdist2(trainingFeatures, testFeatures, similarity, 'Smallest', N);
    end
end

nImages = images(1:numReturnedImages,:);

retrievedClasses = trainingLabels(images);
testClasses = repmat(testLabels',N,1);
relevantImages = retrievedClasses == testClasses;
numRelevantImages = sum(relevantImages);
numRetrievedRelevantImages = cumsum(relevantImages);
precision= numRetrievedRelevantImages(numReturnedImages,:)/numReturnedImages;
recall = numRetrievedRelevantImages(numReturnedImages,:)./numRelevantImages;
n = repmat((1:N)',1,M);
t = relevantImages;
AP = sum((numRetrievedRelevantImages./n).*t)./numRelevantImages;

precision = mean(precision);
recall = mean(recall);
AP = mean(AP);

%-------------------------------------------------------------------------

function check(P, Q)
% P =  n x nbins
% Q =  1 x nbins or n x nbins(one to one)

if size(P,2)~=size(Q,2)
    error('the number of columns in P and Q should be the same');
end

if sum(~isfinite(P(:))) + sum(~isfinite(Q(:)))
   error('the inputs contain non-finite values!') 
end

%-------------------------------------------------------------------------

function [dist, index] = camberra(P, Q)
% P =  n x nbins
% Q =  1 x nbins or n x nbins(one to one)
% dist = n x 1

check(P, Q);

[n, ~]= size(P);

dist = zeros(n,1);
for i= 1: n
    dist(i) = sum(abs(Q-P(i,:))./abs(Q+P(i,:)));  
end

[~, index] = sort(dist);

%-------------------------------------------------------------------------

function [dist, index] = D1(P, Q)
% P =  n x nbins
% Q =  1 x nbins or n x nbins(one to one)
% dist = n x 1

check(P, Q);

[n, ~]= size(P);

dist = zeros(n,1);
for i= 1: n
    dist(i) = sum( abs((Q-P(i,:)) ./ (1+Q+P(i,:)) ));
end

[~, index] = sort(dist);

%-------------------------------------------------------------------------

function [dist, index] = chi2(P, Q)
% P =  n x nbins
% Q =  1 x nbins or n x nbins(one to one)
% dist = n x 1

check(P, Q);

[n, ~]= size(P);

dist = zeros(n,1);
for i= 1: n
    dist(i) = sum( ((Q-P(i,:)).^2) ./ (Q+P(i,:)) / 2);
end

[~, index] = sort(dist);

%-------------------------------------------------------------------------

function [dist, index] = KLDiv(P,Q)
%  dist = KLDiv(P,Q) Kullback-Leibler divergence of two discrete probability
%  distributions
%  P and Q  are automatically normalised to have the sum of one on rows
% have the length of one at each 
% P =  n x nbins
% Q =  1 x nbins or n x nbins(one to one)
% dist = n x 1

check(P, Q);

% normalizing the P and Q
if size(Q,1)==1
    Q = Q ./sum(Q);
    P = P ./repmat(sum(P,2),[1 size(P,2)]);
    temp =  P.*log(P./repmat(Q,[size(P,1) 1]));
    temp(isnan(temp))=0;% resolving the case when P(i)==0
    dist = sum(temp,2);    
elseif size(Q,1)==size(P,1)
    Q = Q ./repmat(sum(Q,2),[1 size(Q,2)]);
    P = P ./repmat(sum(P,2),[1 size(P,2)]);
    temp =  P.*log(P./Q);
    temp(isnan(temp))=0; % resolving the case when P(i)==0
    dist = sum(temp,2);
end

[~, index] = sort(dist);



