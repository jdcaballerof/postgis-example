-- VER EL NOMBRE Y LA GEOMETRIA DE LA TABLA nyc_neighborhoods (BARRIOS)
-- VER LOS NOMBRES DE LOS BARRIOS DE NEW YORK Y VISUALIZARLOS EN EL VISOR JUNTO CON UN MAPA BASE
SELECT name, ST_Transform(geom, 4326)
FROM nyc_neighborhoods;


-- VER LOS NOMBRES Y LA GEOMETRIA DE LOS BARRIOS DE NEW YORK QUE ESTAN EN EL DISTRITO DE Brooklyn
-- VER LOS NOMBRES DE LOS BARRIOS DE NEW YORK Y VISUALIZARLOS EN EL VISOR JUNTO CON UN MAPA BASE
SELECT name, ST_Transform(geom, 4326)
FROM nyc_neighborhoods
WHERE boroname = 'Brooklyn';