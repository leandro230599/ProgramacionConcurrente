###
A una cerealera van T camiones a descargarse trigo y M camiones a descargar maíz. Sólo
hay lugar para que 7 camiones a la vez descarguen, pero no pueden ser más de 5 del mismo
tipo de cereal. Nota: no usar un proceso extra que actué como coordinador, resolverlo
entre los camiones.
###

sem espacioCamiones = 7;
sem maxTrigo = 5;
sem maxMaiz = 5;

process CamionesTrigo [ID: 0..T-1]{
    while true {
        P(maxTrigo);
        P(espacioCamiones);
        # Descarga
        V(espacioCamiones);
        v(maxTrigo)
    }
}

process CamionesCereales [ID: 0..M-1]{
    while true {
        P(maxMaiz);
        P(espacioCamiones);
        # Descarga
        V(espacioCamiones);
        V(maxMaiz);
    }
}