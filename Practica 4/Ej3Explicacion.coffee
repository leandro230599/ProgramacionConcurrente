### En una empresa de software hay N personas que prueban un nuevo producto
para encontrar errores, cuando encuentran uno generan un reporte para que
alguno de los 3 empleados corrija el error y esperan la respuesta del mismo. Los
empleados toman los reportes de acuerdo al orden de llegada, los evalúan, hacen
las correcciones necesarias y le responden a la persona que hizo el reporte. ###

chan Reportes(int, texto);
chan Respuestas[N](texto);

Process Persona[id: 0..N-1] { 
    texto R, Res;
    while (true) { 
        R = generarReporteConProblema;
        send Reportes ( id , R );
        receive Respuestas[id] ( Res );
    };
}

Process Empleado [id: 0..2] { 
    texto Rep, Res;
    int idP;
    while (true) { 
        receive Reportes ( idP , Rep );
        Res = resolver (Rep);
        send Respuestas[idP] ( Res );
    };
}