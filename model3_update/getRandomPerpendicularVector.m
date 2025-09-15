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
