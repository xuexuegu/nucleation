function dist = calculateDistance_dynamic(p1, p2, Rv)
    % Dynamic-style path length around inner sphere of radius Rv:
    % - If segment p1->p2 NOT obstructed by inner sphere: dist = |p2-p1|
    % - Else: dist = |tangent from p1| + |tangent from p2| + Rv * arc_angle
    % Numerical safeties included.

    v = p2 - p1;
    v2 = dot(v,v);
    if v2 < eps
        dist = 0; return;
    end

    % Quick exit if no inner sphere
    if Rv < eps
        dist = sqrt(v2); return;
    end

    % Obstruction test via closest point to origin on segment
    t = -dot(p1, v) / v2; % param of closest point
    obstructed = false;
    if t >= 0 && t <= 1
        closest = p1 + t * v;
        if dot(closest, closest) < Rv^2
            obstructed = true;
        end
    end

    if ~obstructed
        dist = sqrt(v2);   % Euclidean length
        return;
    end

    % Otherwise: two tangents + spherical arc
    d1 = norm(p1);
    d2 = norm(p2);

    % distances along tangents
    dist_p1_to_tangent = sqrt(max(0, d1^2 - Rv^2));
    dist_p2_to_tangent = sqrt(max(0, d2^2 - Rv^2));

    % angles
    c12   = max(-1, min(1, dot(p1,p2) / (max(d1*d2, eps))));
    ang12 = acos(c12);

    c1t = max(-1, min(1, Rv / max(d1, eps)));
    c2t = max(-1, min(1, Rv / max(d2, eps)));
    ang1 = acos(c1t);
    ang2 = acos(c2t);

    arc_angle = ang12 - ang1 - ang2;
    if arc_angle < 0
        arc_angle = 0; % safeguard
    end

    arc_dist = Rv * arc_angle;

    dist = dist_p1_to_tangent + dist_p2_to_tangent + arc_dist;
end

function vec = getRandomPerpendicularVector(reference)
    if all(reference == 0)
        vec = [1, 0, 0];
        return;
    end
    rand_vec = rand(1, 3);
    proj = dot(rand_vec, reference) / max(norm(reference)^2, eps) * reference;
    vec = rand_vec - proj;
    nrm = norm(vec);
    if nrm < eps
        % fallback perpendicular
        r = reference / norm(reference);
        if abs(r(1)) < 0.9
            vec = cross(r, [1 0 0]);
        else
            vec = cross(r, [0 1 0]);
        end
        vec = vec / norm(vec);
    else
        vec = vec / nrm;
    end
end
