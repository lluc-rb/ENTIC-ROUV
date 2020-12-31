function distance = coord2m(lat1, lon1, lat2, lon2, radius)
    % This function calculates the distance between two points in a sphere
    % given latitude and longitude using the Haversine fromula
    % Haversine formula: https://en.wikipedia.org/wiki/Haversine_formula
    %
    % Args:
    % (double) lat1   := latitude of first point
    % (double) lon1   := longitude of first point
    % (double) lat2   := latitude of second point
    % (double) lon2   := longitude of second point
    % (double) radius := radii of the sphere
    %
    % Return:
    % (double) distance := distance between two points given latitiude and longitude
   
    % Formulation (extracted from wikipedia):
    % let the central angle (theta) between any two points on a sphere be:
    % 		theta = d/r 	(2)
    % where:
    % d is the distance between two points along a great circle
    % r is the radius of the sphere
    %
    % 		hav(theta) = hav(phi2-phi1) + cos(phi1)*cos(phi2)*hav(lamb2-lamb1)		(2)
    % where:
    % phi1, phi2 are the latitudes of points 1 and 2
    % lamb1, lamb2 are the longitudes of points 1 and 2 
    % hav(th) is the haversine function:
    % 		hav(th) = sin(th/2)^2		(3)
    %
    % d = r*archav(hav(theta)) = r*archav(h)
    % h = hav(theta) = eq. (2)
    %
    % finally:
    % 		d = 2*r*arcsin(sqrt(h))
    %		h is eq. (3)


    % just apply the formula
    dlat = deg2rad(lat2-lat1);
    dlon = deg2rad(lon2-lon1);
    
    h = sin(dlat/2).^2 + cos(lat1).*cos(lat2).*sin(dlon/2).^2;
    distance = 2*radius*asin(sqrt(h));
end

