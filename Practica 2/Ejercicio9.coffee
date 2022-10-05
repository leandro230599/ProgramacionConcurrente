###
Resolver el funcionamiento en una fábrica de ventanas con 7 empleados (4 carpinteros, 1
vidriero y 2 armadores) que trabajan de la siguiente manera:
• Los carpinteros continuamente hacen marcos (cada marco es armando por un único
carpintero) y los deja en un depósito con capacidad de almacenar 30 marcos.
• El vidriero continuamente hace vidrios y los deja en otro depósito con capacidad para
50 vidrios.
• Los armadores continuamente toman un marco y un vidrio (en ese orden) de los
depósitos correspondientes y arman la ventana (cada ventana es armada por un único
armador).
###

sem topeMarcos = 30;
sem marcos = 0;
sem topeVidrios = 50;
sem vidrios = 0;
sem mutex = 1;
int ventanas = 0;

process Carpinteros[ID: 0..3]{
    while true {
        # Realiza marco
        P(topeMarcos);
        V(marcos)
    }
}

process Vidriero {
    while true {
        # Realiza vidrio
        P(topeVidrios);
        V(vidrios);
    }
}

process Armadores [ID: 0..2]{
    while true {
        P(marcos);
        V(topeMarcos);
        P(vidrios);
        V(topeVidrios);
        P(mutex);
        ventanas++;
        V(mutex);
    }
}