use universidad;
-- 1.Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
select  p.apellido1, p.apellido2, p.nombre from persona p where p.tipo = 'alumno' order by p.apellido1,p.apellido2,p.nombre;
-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
select  p.nombre, p.apellido1, p.apellido2 from persona p where p.tipo = 'alumno' and p.telefono is null;
-- 3. Retorna el llistat dels alumnes que van néixer en 1999
select * from persona p where p.tipo = 'alumno' and p.fecha_nacimiento between '1999/01/01' and '1999/12/31';
-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
select * from persona p where p.tipo = 'profesor' and p.telefono is null and p.nif like '%K';
-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
select * from asignatura a where a.cuatrimestre = 1 and a.curso = 3 and a.id_grado=7;
-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
select p.apellido1, p.apellido2 , p.nombre, d.nombre as nombre_departamento from persona p left join profesor pro on p.id = pro.id_profesor left join departamento d on d.id = pro.id_departamento order by p.apellido1 ,p.apellido2 ,p.nombre ; -- com diu que retorni el llistat de professors junt amb nom de dept al que pertanyen, jo he interpretat que he de mostrar també els professors que no tenen dept
-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
select a.nombre, c.anyo_inicio, c.anyo_fin from asignatura a join  alumno_se_matricula_asignatura aa on a.id = aa.id_asignatura join persona p on p.id = aa.id_alumno join curso_escolar c on c.id = aa.id_curso_escolar where p.nif= '26902806M';
-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
select distinct d.nombre from departamento d  join profesor pro on d.id =pro.id_departamento  join asignatura a on pro.id_profesor = a.id_profesor  join grado g on a.id_grado= g.id where g.nombre =  'Grado en Ingeniería Informática (Plan 2015)';
-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
select distinct p.apellido1,p.apellido2,p.nombre from persona p join alumno_se_matricula_asignatura aa on p.id = aa.id_alumno join curso_escolar ce on aa.id_curso_escolar= ce.id where ce.anyo_inicio = 2018 and ce.anyo_fin= 2019;

-- usant left join
-- 1.Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
select d.nombre as nombre_dep, p.apellido1,p.apellido2, p.nombre from persona p left join profesor pro on p.id = pro.id_profesor left join departamento d on pro.id_departamento = d.id where p.tipo = "profesor" order by d.nombre, p.apellido1,p.apellido2,p.nombre;
-- 2.Retorna un llistat amb els professors/es que no estan associats a un departament.
select p.apellido1, p.apellido2, p.nombre from persona p left join profesor pro on p.id = pro.id_profesor left join departamento d on pro.id_departamento = d.id where d.nombre is null ;
-- 3.Retorna un llistat amb els departaments que no tenen professors/es associats.
select *  from departamento d left join profesor pro on d.id = pro.id_departamento  where pro.id_profesor is null;
-- 4.Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
select * from persona p left join asignatura a on p.id = a.id_profesor where p.tipo ='profesor' and a.id_profesor is null ; 
-- 5.Retorna un llistat amb les assignatures que no tenen un professor/a assignat
select * from asignatura a left join persona p on a.id_profesor = p.id where p.id is null;
-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
select distinct d.nombre from departamento d left join profesor pro on d.id = pro.id_departamento left join asignatura a on pro.id_profesor = a.id_profesor left join alumno_se_matricula_asignatura aa on a.id = aa.id_asignatura left join curso_escolar ce on aa.id_curso_escolar = ce.id where ce.id is null and a.id is null;

-- consultes resum
-- 1.Retorna el nombre total d'alumnes que hi ha.
select count(p.tipo = 'alumno') as total_alumnos from persona p;
-- 2.Calcula quants alumnes van néixer en 1999.
select count(p.tipo = 'alumno') as total_alumnos_nacidos1999 from persona p where p.fecha_nacimiento between '1999/01/01' and '1999/12/31';
-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
select d.nombre as departament , count(id_profesor) as profesors from departamento d left join profesor pro on d.id = pro.id_departamento where pro.id_profesor is not null group by d.nombre order by profesors desc;
-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
select d.nombre as departament , count(id_profesor) as profesors from departamento d left join profesor pro on d.id = pro.id_departamento group by d.nombre;
-- 5.Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
select g.nombre as grau, count(a.id ) as numero_asignaturas  from grado g left join asignatura a on g.id = a.id_grado group by g.nombre order by numero_asignaturas desc;
-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
select g.nombre as grau, count(a.id ) as numero_asignaturas  from grado g left join asignatura a on g.id = a.id_grado  group by g.nombre having numero_asignaturas>40 ;
-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
select g.nombre as grau, a.tipo , count(a.creditos) as creditos from grado g left join asignatura a on g.id = a.id_grado group by a.tipo; --  si no vols la que té tipo null pues where a.tipo is not null
-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
select ce.anyo_inicio, count(distinct aa.id_alumno) As alumnos_matriculados from curso_escolar ce left join alumno_se_matricula_asignatura aa on ce.id = aa.id_curso_escolar group by ce.anyo_inicio; -- numero de alumnos matriculados ese año (distinct), que no numero de matriculaciones a asignaturas en cada año
-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
select p.id, p.nombre, p.apellido1,p.apellido2,count(a.id) as numero_asignaturas from persona p left join asignatura a on p.id = a.id_profesor  where p.tipo = 'profesor'group by p.id order by numero_asignaturas DESc;
-- 10. Retorna totes les dades de l'alumne/a més jove.
select * from persona p where tipo = 'alumno' AND p.fecha_nacimiento = (select max(p2.fecha_nacimiento) from persona p2);
-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
select * from persona p left join profesor pro on p.id = pro.id_profesor left join departamento d on pro.id_departamento = d.id left join asignatura a on p.id = a.id_profesor where d.id is not null and a.id is null;