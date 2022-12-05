### En una empresa de software hay N personas que prueban un nuevo producto
para encontrar errores, cuando encuentran uno generan un reporte para que un
empleado corrija el error (las personas no deben reciben ninguna respuesta). El
empleado toma los reportes de acuerdo al orden de llegada, los evalúan y hace
las correcciones necesarias. ###

chan Reportes(texto);

Process Persona[id: 0..N-1] { 
    texto R;
    while (true) { 
        R = generarReporteConProblema;
        send Reportes ( R );
    };
}

Process Empleado { 
    texto Rep;
    while (true) { 
        receive Reportes ( Rep );
        resolver (Rep);
    };
}