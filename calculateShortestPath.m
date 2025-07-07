
function shortest_path_length = calculateShortestPath(k1, k2, r1, r2)
    % Radii of the spheres

    % Calculate the Euclidean distance between k1 and k2
    d = norm(k2 - k1);
    
    % Check if the line segment intersects with the spheres
    % Calculate the perpendicular distance from the origin to the line segment
    origin = [0, 0, 0];
    line_vec = k2 - k1;
    t = dot(origin - k1, line_vec) / dot(line_vec, line_vec);
    projection = k1 + t * line_vec;
    dist_to_origin = norm(projection);
    
    if (dist_to_origin >= r1) && (dist_to_origin <= r2)
        % The line segment does not intersect with the spherical shells
        shortest_path_length = d;
    else
        % The line segment intersects with the spherical shells
        % Calculate the path length by going around the spheres
        
        % Calculate the intersection points with the inner sphere (r1)
        theta1 = acos(dist_to_origin/r1);
        intersect1_a = projection + r1 * [cos(theta1), sin(theta1), 0];
        intersect1_b = projection - r1 * [cos(theta1), sin(theta1), 0];
        
        
        % Calculate the arc lengths on the spheres
        arc_length_r1 = 2*r1 * theta1;
        
        % Calculate the total path length
        % Choose the shorter path around the spheres
        shortest_path_length = norm(k1 - intersect1_a) + arc_length_r1 + norm(intersect1_b - k2);
    end
end
 