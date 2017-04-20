function [earthField] = getEarthField()
    totalEarthField = 4.5*10^-5;    %T
    dipEarthField = 60; %`
    inclinationEarthField = 30; %`

    earthField(1) = totalEarthField*cosd(dipEarthField)*cosd(inclinationEarthField);
    earthField(2) = totalEarthField*cosd(dipEarthField)*sind(inclinationEarthField);
    earthField(3) = totalEarthField*sind(dipEarthField);
end