USE tienda;
-- 1. Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;
-- 2.Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio FROM producto;
-- 3. Llista totes les columnes de la taula producto.
SELECT* FROM producto;
-- 4. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, precio, precio*1.04 FROM producto;
-- 5.Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre AS nom_de_producto, precio AS euros, precio*1.04 AS dolars FROM producto;
-- 6.Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UCASE(nombre), precio FROM producto;
-- 7. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LCASE(nombre), precio FROM producto;
-- 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UCASE(LEFT(nombre,2)) FROM fabricante;
-- 9. Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre, ROUND(precio) AS Precio_redondo FROM producto;
-- 10. Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio, 0) AS Precio_truncado FROM producto;
-- 11. Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT codigo_fabricante FROM producto;
-- 12 Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT codigo_fabricante FROM producto;
-- 13 Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
-- 14 Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;
-- 15 Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;
-- 16 Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 5 ;
-- 17 Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 3,2;
-- 18 Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;
-- 19 Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio  DESC LIMIT 1;
-- 20 Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante=2;
-- 21 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT p.nombre, p.precio, f.nombre AS "nombre fabricante"  FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo;
-- 22 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT p.nombre, p.precio, f.nombre AS "nombre fabricante"  FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo ORDER BY f.nombre;
-- 23 Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT p.codigo, p.nombre, f.codigo, f.nombre AS "nombre fabricante"  FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo;
-- 24 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT p.nombre,p.precio, f.nombre FROM producto p  JOIN fabricante f ON p.codigo_fabricante=f.codigo ORDER BY p.precio LIMIT 1;
-- 25 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT p.nombre,p.precio, f.nombre FROM producto p  JOIN fabricante f ON p.codigo_fabricante=f.codigo ORDER BY p.precio DESC LIMIT 1;
-- 26 Retorna una llista de tots els productes del fabricant Lenovo.
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre="Lenovo";
-- 27 Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre="Crucial" AND p.precio>200;
-- 28 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre="Asus" OR f.nombre= "Hewlett-Packard" OR f.nombre = "Seagate";
-- 29 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN.
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre IN ("Asus","Hewlett-Packard","Seagate");
-- 30 Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre LIKE '%e';
-- 31 Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre LIKE '%w%';
-- 32 Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE p.precio>=180 ORDER BY p.precio DESC,  p.nombre ASC;
-- 33 Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT DISTINCT f.codigo, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante=f.codigo;
-- 34 Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT f.codigo AS codigo_fabricante,f.nombre AS nombre_fabricante,p.codigo AS codigo_producto,p.nombre AS nombre_producto,p.precio FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante= f.codigo; -- mostra tots els productes(tots els camps) 
-- 35 Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT f.codigo,f.nombre FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante= f.codigo WHERE p.codigo IS NULL;
-- 36 Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT p.codigo,p.nombre,p.precio FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante= f.codigo WHERE f.nombre = 'Lenovo'; -- aqui puc buscar directament per el codigo_fabricante=2 sense fer joins?
-- 37 Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
SELECT * FROM producto p  WHERE p.precio = (SELECT MAX(precio)  FROM producto prod LEFT JOIN fabricante f ON prod.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo'); -- aqui tambe em podria estalviar el join bucant pel codi oi? 
-- 38 Llista el nom del producte més car del fabricant Lenovo.
SELECT p.nombre, MAX(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante= f.codigo WHERE f.nombre = 'Lenovo';
-- 39 Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT p.nombre, MIN(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante= f.codigo WHERE f.nombre = 'Hewlett-Packard';
-- 40 Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT * FROM producto p  WHERE p.precio >= (SELECT MAX(precio)  FROM producto prod  JOIN fabricante f ON prod.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');
-- 41 Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT * FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante= f.codigo WHERE f.nombre = 'Asus' AND p.precio > (SELECT AVG(prod.precio)  FROM producto prod JOIN fabricante f ON prod.codigo_fabricante = f.codigo WHERE f.nombre="Asus");