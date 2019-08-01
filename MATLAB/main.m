clear all;
close all;
clc;

x1 = 0; y1 = 370; x2 = 1280; y2 = 350;
lastLline=[0 0 0 0]; lastRline=[0 0 0 0]; pred_left = [0 0 0 0]; pred_right = [0 0 0 0];% Initialize past lines
slopes_l =[]; intercepts_l = [];
slopes_r =[]; intercepts_r = [];
n_predictions = 10;
videofile = VideoReader('/vid/car3.mp4');
videofile.CurrentTime = 260;
new_video = VideoWriter('newfile');
open(new_video)
j = 1;
while j < 2000
%while hasFrame(videofile)
    tic;
    % Get Frame
    actual_frame = readFrame(videofile);
    binarized = process_image(actual_frame, x1, y1, x2, y2);
    % Get lines with Hough Transform
    lines = hough_lines(binarized, 40, 300, 1, 50);
    if not(isempty(lines))
        % Filter Hough Lines, from filtered lines, return the best 2 for each side
        [left_parameters, right_parameters] = clear_lines(binarized, lines); 
        if not(isempty(left_parameters))
            % Average the lines on each side
            actual_left = average_lines(left_parameters);
            % Estimate line 
            [slopes_l,intercepts_l,line_l] = estimate_line(slopes_l, intercepts_l, actual_left(1), actual_left(2), n_predictions);
            % Draw the line across the ROI
            fitted_left = extrapolate_line(binarized, actual_left);
            % Match ROI coordinates with real size image coordinates
            resized_left = fitted_left + [x1 y1 x1 y1];
            lastLline = resized_left;
            pred_left = extrapolate_line(binarized, line_l);pred_left = pred_left + [x1 y1 x1 y1];
        end
        if not(isempty(right_parameters))
            actual_right = average_lines(right_parameters);
            % Estimate line 
            [slopes_r,intercepts_r,line_r] = estimate_line(slopes_r, intercepts_r, actual_right(1), actual_right(2), n_predictions);
            fitted_right = extrapolate_line(binarized, actual_right);
            resized_right = fitted_right + [x1 y1 x1 y1];
            lastRline = resized_right;
            pred_right = extrapolate_line(binarized, line_r);pred_right = pred_right + [x1 y1 x1 y1];
        end        
    end
    % Draw lines yellow are good lanes, red are detected lanes.
    %actual_frame = draw_lines(actual_frame, lastLline, 0, 0, 3, 'red');
    %actual_frame = draw_lines(actual_frame, lastRline, 0, 0, 3, 'red');
    actual_frame = draw_lines(actual_frame, pred_left, 0, 0, 5, 'magenta');
    actual_frame = draw_lines(actual_frame, pred_right, 0, 0, 5, 'magenta');
    % Write frame on video
    writeVideo(new_video, actual_frame);
    j = j+1;
    toc;
    disp(j);
end
close(new_video)
disp('final')