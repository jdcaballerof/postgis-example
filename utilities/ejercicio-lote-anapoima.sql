-- EJERCICIO 
	-- Se requiere un lote de
	-- 1) area > 5,000 m^2
	-- 2) > 300 m alejado de una primaria
	-- 3) > 200 m alejado de equipamientos
	-- 4) ubicado en zona residencial

--- 1)
CREATE MATERIALIZED VIEW manzanas_5000 AS
SELECT * 
FROM manzanas mz
WHERE ST_Area(mz.geom) > 5000;

-- REFRESH MATERIALIZED VIEW manzanas_5000;



--- 2) MAS DE 300 m alejado de una primaria
-- Para esto se crea un buffer de 300 m 
-- A manera de ejercicio, se unen las 3 shapes en 1 sola 
-- y serian las manzanas que no se intersecten con la shape creada

CREATE VIEW buffer_colegios_primaria AS
SELECT 
	--nombre, ST_Buffer(geom, 300)
	ST_Union(ST_Buffer(geom, 300)) as geom
FROM colegios
WHERE categoria = 'Primaria'; 

CREATE MATERIALIZED VIEW manzanas_5000_lejanas AS
SELECT mz5.* FROM manzanas_5000 mz5, buffer_colegios_primaria bfc
--WHERE ST_Intersects( mz5.geom, bfc.geom ) = FALSE;
WHERE ST_Disjoint( mz5.geom, bfc.geom );
--UNION (select geom from buffer_colegios_primaria);



--- 3)  (similar al 2)

-- Aunque se vea muchos poligonos por seapara se trata de 1 sola geometria (compleja) llamada multipoligono
CREATE VIEW buffer_equipamientos AS
SELECT ST_Union( ST_Buffer(e.geom, 200) ) as geom 
FROM equipamientos e 

CREATE MATERIALIZED VIEW manzanas_5000_lejanas2 AS
SELECT mz.* 
FROM manzanas_5000_lejanas mz, buffer_equipamientos bf
WHERE ST_Disjoint( mz.geom, bf.geom ) ;  



--- 4) 
CREATE MATERIALIZED VIEW uso_residencial AS
SELECT * 
FROM usodelsuelo
WHERE tipo_uso = 'RESIDENCIAL';  



--- manzanas candidatas
-- GET multipoligono 
CREATE VIEW uso_residencial_union AS
SELECT ST_Union(r.geom) AS geom FROM uso_residencial r;

SELECT * 
FROM manzanas_5000_lejanas2 mz, uso_residencial_union r
WHERE ST_Contains( r.geom, mz.geom );
