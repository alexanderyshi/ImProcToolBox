% expects a normalized grayscale double input image
% colors come in a 1x3 format
% returns an unbounded RGB image

% TODO: need to handle the edges
function colored_edges = ColoredEdges(image, color1, color2, color3)
    % remove noise ahead of edge detection    
    gaussian_blur_kernel = (1 / 16) * [1 2 1;2 4 2;1 2 1];
    image_blur = conv2(image, gaussian_blur_kernel); 

    edge_detect_1 = [-1 0 1; 0 0 0 ; 1 0 -1];
    edge_detect_2 = [1 0 -1; 0 0 0 ; -1 0 1];
    edge_detect_3 = [0 1 0; 1 -4 1 ; 0 1 0];

    gain_1 = 10;
    gain_2 = 10;
    gain_3 = 10;

    edge_1 = conv2(image_blur, edge_detect_1)*gain_1;
    edge_2 = conv2(image_blur, edge_detect_2)*gain_2;
    edge_3 = conv2(image_blur, edge_detect_3)*gain_3;

    color_edge_1 = cat(3,edge_1*color1(1), edge_1*color1(2),edge_1*color1(3));
%     color_edge_1 = 0;
    color_edge_2 = cat(3,edge_2*color2(1), edge_2*color2(2),edge_2*color2(3));
%     color_edge_2 = 0;
    color_edge_3 = cat(3,edge_3*color3(1), edge_3*color3(2),edge_3*color3(3));
%     color_edge_3 = 0;
    colored_edges = color_edge_1 + color_edge_2 + color_edge_3;