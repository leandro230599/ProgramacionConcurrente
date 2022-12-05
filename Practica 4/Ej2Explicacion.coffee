### En una empresa de software hay N personas que prueban un nuevo producto
para encontrar errores, cuando encuentran uno generan un reporte para que un
empleado corrija el error y esperan la respuesta del mismo. El empleado
toma los reportes de acuerdo al orden de llegada, los evalúan, hace las
correcciones necesarias y le responde a la persona que hizo el reporte ###

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

Process Empleado { 
    texto Rep, Res;
    int idP;
    while (true) { 
        receive Reportes ( idP , Rep );
        Res = resolver (Rep);
        send Respuestas[idP] ( Res );
    };
}