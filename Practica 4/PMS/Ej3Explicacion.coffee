### En una empresa de software hay N empleados Testeo que prueban un nuevo
producto para encontrar errores, cuando encuentra uno generan un reporte para
que otro empleado Mantenimiento corrija el error y le responda. El empleado
Mantenimiento toma los reportes para evaluarlos de acuerdo al orden de llegada,
hace las correcciones necesarias y le responde al empleado Testeo
correspondiente (el que hizo el reporte). ###

Process Admin { 
    cola Fila; texto R; int idT;
    do Testeo[*]?reporte(R, idT) → push (Fila, (R,idT));
    □ not empty(Fila); Mantenimiento?pedido() →     pop (Fila, (R, idT))
                                                    Mantenimiento!reporte (R, idT);
    od
} 

Process Testeo[id: 0 ..N-1] { 
    texto R, Res;
    while (true) { 
        R = generarReporteConProblema;
        Admin!reporte(R, id);
        Mantenimiento?respuesta(Res);
    }
}

Process Mantenimiento { 
    texto Rep, Res; int idT;
    while (true) { 
        Admin!pedido();
        Admin?reporte(Rep, idT);
        Res = resolver(Rep);
        Testeo[idT]!respuesta(Res);
    }
}