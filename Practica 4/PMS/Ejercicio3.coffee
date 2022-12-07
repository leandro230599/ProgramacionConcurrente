### En un examen final hay N alumnos y P profesores. Cada alumno resuelve su examen, lo
entrega y espera a que alguno de los profesores lo corrija y le indique la nota. Los
profesores corrigen los exámenes respectando el orden en que los alumnos van entregando.
a) Considerando que P=1. ###

process Alumnos [ID:1..N] {
    texto examen;
    int nota;

    examen = realizaExamen();
    Admin!enviaExamen(examen, ID);
    Profesores?enviarNota(nota);
}

process Profesores {
    texto examen;
    int nota;
    int idAlumno;

    while true {
        Admin!pedido();
        Admin?corregir(examen, idAlumno);
        nota = corregirExamen(examen);
        Alumnos[idAlumno]!enviarNota(nota);
    }

}

process Admin {
    cola buffer;
    texto examen;
    int idAlumno;

    do Alumnos[*]?enviaExamen(examen, idAlumno) → push(buffer, examen, idAlumno);
    □ not empty (buffer); Profesores?pedido() → pop(buffer, examen, idAlumno);
                                                Profesores!corregir(examen, idAlumno);
}

# b) Considerando que P>1.

process Alumnos [ID:1..N] {
    texto examen;
    int nota;

    examen = realizaExamen();
    Admin!enviaExamen(examen, ID);
    Profesores[*]?enviarNota(nota);
}

process Profesores [ID:1..P] {
    texto examen;
    int nota;
    int idAlumno;

    while true {
        Admin!pedido(ID);
        Admin?corregir(examen, idAlumno);
        nota = corregirExamen(examen);
        Alumnos[idAlumno]!enviarNota(nota);
    }

}

process Admin {
    cola buffer;
    texto examen;
    int idAlumno;
    int idProfesor;

    do Alumnos[*]?enviaExamen(examen, idAlumno) → push(buffer, examen, idAlumno);
    □ not empty (buffer); Profesores[*]?pedido(idProfesor) → pop(buffer, examen, idAlumno);
                                                Profesores[idProfesor]!corregir(examen, idAlumno);
}

# Ídem b) pero considerando que los alumnos no comienzan a realizar su examen hasta
# que todos hayan llegado al aula.

process Alumnos [ID:1..N] {
    texto examen;
    int nota;

    Admin!llegue();
    Admin?iniciarExamen();
    examen = realizaExamen();
    Admin!enviaExamen(examen, ID);
    Profesores[*]?enviarNota(nota);
}

process Profesores [ID:1..P] {
    texto examen;
    int nota;
    int idAlumno;

    while true {
        Admin!pedido(ID);
        Admin?corregir(examen, idAlumno);
        nota = corregirExamen(examen);
        Alumnos[idAlumno]!enviarNota(nota);
    }

}

process Admin {
    cola buffer;
    texto examen;
    int idAlumno;
    int idProfesor;
    int contador = 0;

    while (contador<N) {
        Alumnos?llegue();
        contador++;
    }
    for (int i = 1; i <= N; i++){
        Alumnos[i]!iniciarExamen();
    }
    do Alumnos[*]?enviaExamen(examen, idAlumno) → push(buffer, examen, idAlumno);
    □ not empty (buffer); Profesores[*]?pedido(idProfesor) → pop(buffer, examen, idAlumno);
                                                Profesores[idProfesor]!corregir(examen, idAlumno);
}