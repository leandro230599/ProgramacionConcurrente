### Suponga que existe un antivirus distribuido que se compone de R procesos robots
Examinadores y 1 proceso Analizador. Los procesos Examinadores están buscando
continuamente posibles sitios web infectados; cada vez que encuentran uno avisan la
dirección y luego continúan buscando. El proceso Analizador se encarga de hacer todas las 
pruebas necesarias con cada uno de los sitios encontrados por los robots para determinar si
están o no infectados.

a) Analice el problema y defina qué procesos, recursos y comunicaciones serán
necesarios/convenientes para resolver el problema. ###


R procesos de robots examinadores, 1 de Analizador, y un admin


### b) Implemente una solución con PMS. ###

process Examinadores [ID:1..R] {
    texto url;

    while true {
        url = buscaSitiosInfectados();
        Admin!reporte(url);
    }
}

process Analizador {
    texto url;

    while true {
        Admin!pedido();
        Admin?analizar(url);
        analizaURL(url);
    }
}

process Admin {
    cola buffer;
    cola url;

    do  Examinadores[*]?reporte(url) → push(buffer, url);
    □ not empty(buffer); Analizador?pedido() →  pop(buffer, url);
                                                Analizador!analizar(url);
    od
}