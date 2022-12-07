### En un estadio de fútbol hay una máquina expendedora de gaseosas que debe ser usada por
E Espectadores de acuerdo al orden de llegada. Cuando el espectador accede a la máquina
en su turno usa la máquina y luego se retira para dejar al siguiente. Nota: cada Espectador
una sólo una vez la máquina. ###

process Espectadores [ID:1..E] {
    Admin!encolar(ID);
    Maquina?permitido();
    usaMaquina();
    Maquina!termine();
}

process Maquina {
    int idEspectador;

    while true {
        Admin!pedido();
        Admin?turnoEspectador(idEspectador);
        Espectadores[idEspectador]!permitido();
        Espectadores[idEspectador]?termine();
    }


}

process Admin {
    cola buffer;
    int idEspectador;

    do Espectador[*]encolar(idEspectador) → push(buffer, idEspectador);
    □ not empty (buffer); Maquina?pedido() → pop(buffer, idEspectador);
                                                Maquina!turnoEspectador(idEspectador);
}