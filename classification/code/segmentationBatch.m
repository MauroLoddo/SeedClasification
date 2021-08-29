function results = segmentationBatch(im)
    %Image Processing Function
    %
    % IM      - Input image.
    % RESULTS - A scalar structure with the processing results.
    %

    if(size(im,3)==3)
        % Convert RGB to grayscale
        imgray = rgb2gray(im);
    else
        imgray = im;
    end

    %bw = imbinarize(imgray);
    [bw, ~] = segmentationCagliari(im);

    results.imgray = imgray;
    results.bw     = bw;
