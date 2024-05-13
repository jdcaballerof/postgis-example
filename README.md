# Iniciar la DB

- Levantar el servicio con docker
- Inicar sesion con las credenciales puestas en el docker compose
- Conectarse al servidor usando el nombre del servicion como host ('myDB') y las credenciales expuestas en el docker compose
- Crear la DB
- Instalar las [extensiones](./utilities/dowload_extensions.sql)
    - ```sql 
        -- Enable PostGIS (as of 3.0 contains just geometry/geography)
        CREATE EXTENSION postgis;
        -- enable raster support (for 3+)
        CREATE EXTENSION postgis_raster;
        -- Enable Topology
        CREATE EXTENSION postgis_topology;
        -- Enable PostGIS Advanced 3D and other geoprocessing algorithms
        -- sfcgal not available with all distributions
        CREATE EXTENSION postgis_sfcgal;
        -- fuzzy matching needed for Tiger
        CREATE EXTENSION fuzzystrmatch;
        -- rule based standardizer
        CREATE EXTENSION address_standardizer;
        -- example rule data set
        CREATE EXTENSION address_standardizer_data_us;
        -- Enable US Tiger Geocoder
        CREATE EXTENSION postgis_tiger_geocoder;
        ```
- Restablecer el [backup](./utilities/nyc_data.backup) 
  - copiar el archivo dentro de `/pgadmin/storage/{user}`
  - en pgadmin (navegador) dar clic derecho en la DB y 'Restore'
  - Seleccionar el archivo backup y en Data Options activar 'Do not save'-'Owner'
-  Realizar [queries](./utilities/some_queries.sql) para verificar la correcta instalación 


## Referencias
- [Introduccion a PostGIS.  5) Loading spatial data](https://postgis.net/workshops/es/postgis-intro/loading_data.html)
- [01 - PostGIS - Introducción](https://www.youtube.com/watch?v=oVEUcYKemXQ&list=PL_YyCdnLDJAjD4sfB3z2p_MOcleKUCVwy&index=1) by [GeoCositasParaDummies](https://www.youtube.com/@GeoCositasParaDummies)