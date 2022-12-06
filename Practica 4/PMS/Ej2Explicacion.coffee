### En una empresa de software hay un empleado Testeo que prueba un nuevo
producto para encontrar errores, cuando encuentra uno generan un reporte para
que otro empleado Mantenimiento corrija el error (no requiere una respuesta
para seguir trabajando) y continua trabajando. El empleado Mantenimiento
toma los reportes para evaluarlos y hacer las correcciones necesarias. ###


Process Admin { 
    cola Buffer;
    texto R;
    do Testeo?reporte(R) → push (Buffer, R);
    □ not empty(Buffer); Mantenimiento?pedido() →   Mantenimiento!reporte (pop (Buffer));
    od
} 

Process Testeo { 
    texto R, Res;
    while (true) {
        R = generarReporteConProblema;
        Admin!reporte(R);
    }
}

Process Mantenimiento { 
    texto Rep, Res;
    while (true) { 
        Admin!pedido();
        Admin?reporte(Rep);
        Res = resolver(Rep);
    }
}