function [ Bf ] = computeBf( Bimage, Bhist )
    fismat = readfis('Bf.fis');
    Bf = evalfis([Bimage Bhist], fismat);
end

