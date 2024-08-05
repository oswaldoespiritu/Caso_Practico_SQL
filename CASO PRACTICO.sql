/*b) Explorar la tabla “menu_items” para conocer los productos del menú.*/

SELECT * FROM menu_items;

--1.- Realizar consultas para contestar las siguientes preguntas:
--● Encontrar el número de artículos en el menú.
SELECT COUNT (item_name) AS "Número de artículos en el menú" FROM menu_items;
--● ¿Cuál es el artículo menos caro y el más caro en el menú?
-- Artículo menos caro
SELECT item_name, price
FROM menu_items
ORDER BY price ASC
LIMIT 1;
-- Artículo más caro
SELECT item_name, price
FROM menu_items
ORDER BY price DESC
LIMIT 1;

--● ¿Cuántos platos americanos hay en el menú?
SELECT COUNT (*) AS "Número de platos americanos"
FROM menu_items WHERE category = 'American';
--● ¿Cuál es el precio promedio de los platos?*/
SELECT AVG (price) AS "Precio promedio de los platos"
FROM menu_items;

--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
SELECT * FROM order_details;

--1.- Realizar consultas para contestar las siguientes preguntas:
--● ¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT (DISTINCT order_id) AS "# de pedidos únicos" FROM order_details;

--● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT order_id, COUNT (item_id)
FROM order_details
GROUP BY order_id
ORDER BY COUNT (item_id) DESC
LIMIT 5;

--● ¿Cuándo se realizó el primer pedido y el último pedido?
--Primer pedido
SELECT order_date 
FROM order_details
ORDER BY order_date ASC
LIMIT 1;
--Último pedido
SELECT order_date 
FROM order_details
ORDER BY order_date DESC
LIMIT 1;

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
SELECT COUNT (DISTINCT order_id) AS "Número de pedidos entre el 1 y 5 de Enero"
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

--d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
--1.- Realizar un left join entre entre order_details y menu_items con el identificador
--item_id(tabla order_details) y menu_item_id(tabla menu_items).
SELECT *
FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id=mi.menu_item_id;

--e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
--preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
--objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
--restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
--utiliza los resultados obtenidos para llegar a estas conclusiones

--1.- Los artículos más vendidos
SELECT mi.item_name, COUNT(od.item_id) AS "Cantidad Vendida"
FROM order_details AS od
LEFT JOIN menu_items AS mi ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY "Cantidad Vendida" DESC
LIMIT 5;

--2 Los que más generan ingresos
SELECT mi.item_name, SUM(mi.price) AS "Ingreso Generado"
FROM order_details AS od
LEFT JOIN menu_items AS mi ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY "Ingreso Generado" DESC
LIMIT 5;

--3.- Categoría de platillo más popular
SELECT mi.category, COUNT(od.item_id) AS "Cantidad Vendida"
FROM order_details AS od
LEFT JOIN menu_items AS mi ON od.item_id = mi.menu_item_id
GROUP BY mi.category
ORDER BY "Cantidad Vendida" DESC
LIMIT 1;

--4.- Precio promedio de los más vendidos
SELECT mi.item_name, AVG(mi.price) AS "Precio Promedio"
FROM order_details AS od
LEFT JOIN menu_items AS mi ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY "Precio Promedio" DESC
LIMIT 5;

--5.- Ventas totales por cada artículo
SELECT mi.item_name, SUM(mi.price * od.item_id) AS "Ventas Totales"
FROM order_details AS od
LEFT JOIN menu_items AS mi ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY "Ventas Totales" DESC;



