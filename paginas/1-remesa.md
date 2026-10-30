
# 1 · La remesa nueva

## Qué llegó

El 11 de abril de 2026 recibimos una nueva remesa de trabajos de impresión 3D. Al analizarla, detectamos que algunos consumos de filamento de la impresora PRN-16 eran demasiado bajos, debido a un posible cambio de unidades en la báscula.

## Cómo lo descubrimos

Ejecutamos `dbt build` y el test `rango_consumo` detectó 9 registros incorrectos. Mediante consultas SQL con `dbt show`, comprobamos que todos pertenecían a la impresora PRN-16 y correspondían a trabajos realizados entre el 30 de marzo y el 10 de abril de 2026. También confirmamos que esos valores ya estaban presentes en los datos originales de bronce.

## Cómo lo arreglamos

Modificamos el modelo `stg_parte.sql` de la capa plata para convertir a gramos los consumos anormalmente bajos de la PRN-16, multiplicándolos por 1.000 cuando se cumplen las condiciones establecidas. Conservamos intactos los archivos originales de bronce. Después volvimos a ejecutar `dbt build` y las ocho comprobaciones pasaron correctamente.

## Resultado

La capa plata contiene ahora **{{ stg_parte.filas }} trabajos**, sin perder registros durante la limpieza. El test `rango_consumo`, que anteriormente detectaba 9 registros incorrectos, ahora se supera correctamente.
