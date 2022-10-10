###
En un entrenamiento de fútbol hay 20 jugadores que forman 4 equipos (cada jugador conoce
el equipo al cual pertenece llamando a la función DarEquipo()). Cuando un equipo está listo
(han llegado los 5 jugadores que lo componen), debe enfrentarse a otro equipo que también
esté listo (los dos primeros equipos en juntarse juegan en la cancha 1, y los otros dos equipos
juegan en la cancha 2). Una vez que el equipo conoce la cancha en la que juega, sus jugadores
se dirigen a ella. Cuando los 10 jugadores del partido llegaron a la cancha comienza el partido,
juegan durante 50 minutos, y al terminar todos los jugadores del partido se retiran (no es
necesario que se esperen para salir).
###

process jugadores [ID: 1..20]{
    int equipo;
    int cancha;

    Equipo.asignarEquipoYCancha(id,equipo,cancha);
    Cancha[cancha].jugarPartido();
}

process partido [ID: 1..2]{
    Cancha[ID].empezar();
    delay("50 minutos");
    Cancha[ID].terminar();
}

Monitor Equipo {
    cond cola[4]
    int cantEquipo[4] = 0;
    int canchaAsignada[4];
    int equipoLleno = 0;

    procedure asignarEquipo (id: in int, equipo: out int, cancha: out int;){

        equipo = DarEquipo();
        cantEquipo[equipo]++;
        if (cantEquipo[equipo] == 5){
            equipoLleno++;
            if (equipoLleno<=2){
                canchaAsignada[equipo] = 1;
            }else{
                canchaAsignada[equipo] = 2;
            }
            signal_all(cola[equipo]);
        } else{
            wait(cola[equipo]);
        }
        cancha = canchaAsignada[equipo];
    }
}

Monitor Cancha [ID: 1..2]{
    int jugadores = 0;
    cond cola;
    cond espera;
    bool listo = false;

    procedure jugarPartido () {
        jugadores++;
        if (jugadores = 10){
            signal(espera);
        }
        wait(cola);
    }

    procedure empezar () {
        if (jugadores < 10){
            wait(espera);
        }
    }

    procedure terminar () {
        signal_all(cola);
    }
}