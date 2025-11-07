# Proyecto 1: AdoptaDos

## Enunciado del proyecto

> La protectora AdoptaDos desea crear un portal web donde parejas puedan adoptar animales juntos.  
>   
> El objetivo es diseñar una estructura XML bien definida que almacene la información de las parejas registradas, los animales disponibles y las adopciones realizadas.  
>   
> A partir de estos datos, deberán generar una página web informativa que muestre la lista de animales, los datos de las parejas adoptantes y un registro de las adopciones, usando transformaciones XSLT.

## Descripción general

Portal web para la protectora **AdoptaDos**, donde parejas pueden adoptar animales juntos.

## Estructura del proyecto

- `data/`  
  Contiene los archivos XML con los datos estructurados:
  - `animales/animales.xml`
  - `parejas/parejas.xml`
  - `adopciones/adopciones.xml`

- `xsl/`  
  Transformaciones XSLT que convierten los datos XML en HTML.

- `resources/css/`  
  Hojas de estilo (CSS) para mejorar la presentación visual.

- `html/`  
  Página(s) HTML estática(s).

## Uso

1. Asegúrate de que los archivos XML están correctamente rellenados.
2. Abre `index.xml` (en la raíz del proyecto) con un navegador moderno (Chrome o Firefox recomendados).
3. La página se renderiza dinámicamente mediante la transformación XSLT definida en `xsl/index.xsl`.

## Autor
- Luis Miguel Pablos Orge
- Mario Rodriguez

## Fecha
Noviembre 2025