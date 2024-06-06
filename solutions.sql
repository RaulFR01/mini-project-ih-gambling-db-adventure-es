use ironhack_gambling;

-- Pregunta 01: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre Título, 
-- Nombre y Apellido y Fecha de Nacimiento para cada uno de los clientes. No necesitarás hacer nada en Excel para esta.

SELECT 
	Title,
	FirstName,
    LastName,
    DateOfBirth
FROM
	customer;
    
-- Pregunta 02: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre el número de clientes en cada grupo de clientes (Bronce, Plata y Oro). 
-- Puedo ver visualmente que hay 4 Bronce, 3 Plata y 3 Oro pero si hubiera un millón de clientes ¿cómo lo haría en Excel?

SELECT 
	CustomerGroup,
    Count(*) AS Numero_clientes
FROM 
	customer
GROUP BY
	CustomerGroup;
    
-- Pregunta 03: El gerente de CRM me ha pedido que proporcione una lista completa de todos los datos para esos clientes en la tabla de clientes pero necesito añadir el código de moneda de cada jugador para que pueda enviar la oferta correcta en la moneda correcta. Nota que el código de moneda no existe en la tabla de clientes sino en la tabla de cuentas. 
-- Por favor, escribe el SQL que facilitaría esto. ¿Cómo lo haría en Excel si tuviera un conjunto de datos mucho más grande?

SELECT
	c.*,
    a.CurrencyCode
FROM 
	customer c
JOIN
	account a
ON
	c.CustId = a.CustId;
    
-- Pregunta 04: Ahora necesito proporcionar a un gerente de producto un informe resumen que muestre, por producto y por día, cuánto dinero se ha apostado en un producto particular. 
-- TEN EN CUENTA que las transacciones están almacenadas en la tabla de apuestas y hay un código de producto en esa tabla que se requiere buscar (classid & categoryid) para determinar a qué familia de productos pertenece esto. Por favor, escribe el SQL que proporcionaría el informe. 
-- Si imaginas que esto fue un conjunto de datos mucho más grande en Excel, ¿cómo proporcionarías este informe en Excel?

SELECT 
	p.product,
    b.BetDate,
    count(*)
FROM
	betting b
JOIN
	product p
ON 
	b.ClassId = p.CLASSID AND b.CategoryId = p.CATEGORYID
GROUP BY p.product, b.BetDate;

-- Pregunta 05: Acabas de proporcionar el informe de la pregunta 4 al gerente de producto, ahora él me ha enviado un correo electrónico y quiere que se cambie. ¿Puedes por favor modificar el informe resumen para que solo resuma las transacciones que ocurrieron el 1 de noviembre o después y solo quiere ver transacciones de Sportsbook. 
-- Nuevamente, por favor escribe el SQL abajo que hará esto. Si yo estuviera entregando esto vía Excel, ¿cómo lo haría?

SELECT 
	p.product,
    b.BetDate,
    count(*)
FROM
	betting b
JOIN
	product p
ON 
	b.ClassId = p.CLASSID AND b.CategoryId = p.CATEGORYID

WHERE p.product = 'Sportsbook' AND b.BetDate > '2012-11-01 00:00:00'
GROUP BY p.product, b.BetDate;

-- Pregunta 06: Como suele suceder, el gerente de producto ha mostrado su nuevo informe a su director y ahora él también quiere una versión diferente de este informe. 
-- Esta vez, quiere todos los productos pero divididos por el código de moneda y el grupo de clientes del cliente, en lugar de por día y producto. 
-- También le gustaría solo transacciones que ocurrieron después del 1 de diciembre. Por favor, escribe el código SQL que hará esto.


SELECT 
    sub.CustomerGroup,
    sub.CurrencyCode,
    count(*)
FROM
	betting b
JOIN
	product p
ON 
	b.ClassId = p.CLASSID AND b.CategoryId = p.CATEGORYID
JOIN (
	SELECT 
		a.AccountNo,
        a.CurrencyCode,
        c.CustomerGroup
	FROM
		Account a
	JOIN
		Customer c
	ON 
		a.CustId = c.CustId
) sub
ON 
	b.AccountNo = sub.AccountNo
WHERE b.BetDate > '2012-12-01 00:00:00'
GROUP BY sub.CustomerGroup, sub.CurrencyCode;


-- Nuestro equipo VIP ha pedido ver un informe de todos los jugadores independientemente de si han hecho algo en el marco de tiempo completo o no. 
-- En nuestro ejemplo, es posible que no todos los jugadores hayan estado activos. 
-- Por favor, escribe una consulta SQL que muestre a todos los jugadores Título, Nombre y Apellido y un resumen de su cantidad de apuesta para el período completo de noviembre.

SELECT
	c.Title,
    c.FirstName,
    c.LastName,
    sub.AccountNo,
    sub.NumeroTransacciones
FROM
	customer c
JOIN
	account a
ON 
	c.CustId = a.CustId
JOIN (
	SELECT 
		AccountNo,
        SUM(Bet_Amt) AS NumeroTransacciones
	FROM
		betting
	GROUP BY AccountNo
) sub
ON
	a.AccountNo = sub.AccountNo;
    
-- Nuestros equipos de marketing y CRM quieren medir el número de jugadores que juegan más de un producto. 
-- ¿Puedes por favor escribir 2 consultas, una que muestre el número de productos por jugador y otra que muestre jugadores que juegan tanto en Sportsbook como en Vegas?

SELECT 
	a.CustId,
	p.product,
    COUNT(*)
FROM
	betting b
JOIN
	product p
ON 
	b.ClassId = p.CLASSID AND b.CategoryId = p.CATEGORYID
JOIN
	account a
ON 
	b.AccountNo = a.AccountNo
GROUP BY p.product, a.CustId;

SELECT 
	a.CustId,
	p.product
FROM
	betting b
JOIN
	product p
ON 
	b.ClassId = p.CLASSID AND b.CategoryId = p.CATEGORYID
JOIN
	account a
ON 
	b.AccountNo = a.AccountNo
WHERE 
	p.product = 'Sportsbook' OR p.product = 'Vegas'
GROUP BY p.product, a.CustId;

-- Ahora nuestro equipo de CRM quiere ver a los jugadores que solo juegan un producto, por favor escribe código SQL que muestre a los jugadores que solo juegan en sportsbook, usa bet_amt > 0 como la clave. 
-- Muestra cada jugador y la suma de sus apuestas para ambos productos.

-- Me dan los id de las personas que solo han apostado en un tipo de producto.

SELECT distinct a.CustId
FROM
	account a
JOIN(
	SELECT 
		a.CustId,
		count(DISTINCT p.product) AS TOTAL_PRODUCTS
	FROM
		betting b
	JOIN
		product p
	ON 
		b.ClassId = p.CLASSID AND b.CategoryId = p.CATEGORYID
	JOIN
		account a
	ON 
		b.AccountNo = a.AccountNo
	GROUP BY a.CustId
	HAVING count(DISTINCT p.product) = 1
) sub
ON 
	a.CustId = sub.CustId
JOIN 
	Betting b
ON 
	a.AccountNo = b.AccountNo
WHERE
	b.product = 'Sportsbook';
    
--  La última pregunta requiere que calculemos y determinemos el producto favorito de un jugador. Esto se puede determinar por la mayor cantidad de dinero apostado. 
-- Por favor, escribe una consulta que muestre el producto favorito de cada jugador

SELECT a.CustId, sub.product
FROM account a
JOIN(
SELECT b.AccountNo, max(b.Bet_Amt), max(b.product) AS product
FROM betting b
GROUP BY b.AccountNo
) sub
ON 
a.AccountNo = sub.AccountNo;

-----------------------------------------------------------------------------

-- Escribe una consulta que devuelva a los 5 mejores estudiantes basándose en el GPA

SELECT s.student_name, s.student_id, s.GPA
FROM student s
ORDER BY s.GPA DESC
LIMIT 5;

--  Escribe una consulta que devuelva el número de estudiantes en cada escuela. (¡una escuela debería estar en la salida incluso si no tiene estudiantes!)


SELECT s.school_id, max(sc.school_name), count(*)
FROM student s
JOIN school sc
ON s.school_id = sc.school_id
GROUP BY s.school_id;

-- Escribe una consulta que devuelva los nombres de los 3 estudiantes con el GPA más alto de cada universidad.

SELECT s.student_name, sc.school_name,  s.GPA,sub.ranking
FROM student s
JOIN (
SELECT s.student_name,s.school_id,  s.GPA, RANK() over (PARTITION BY s.school_id ORDER BY s.GPA desc) as ranking
FROM student s) sub
ON s.student_name = sub.student_name
JOIN school sc
ON s.school_id = sc.school_id
WHERE sub.ranking <= 3
ORDER BY s.school_id ASC;
