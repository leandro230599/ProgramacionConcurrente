### 
Una fábrica de piezas metálicas debe producir T piezas por día. Para eso, cuenta con E
empleados que se ocupan de producir las piezas de a una por vez (se asume T>E). La
fábrica empieza a producir una vez que todos los empleados llegaron. Mientras haya
piezas por fabricar, los empleados tomarán una y la realizarán. Cada empleado puede
tardar distinto tiempo en fabricar una pieza. Al finalizar el día, se le da un premio al
empleado que más piezas fabricó. 
###

sem mutex = 1;
sem llegaron = 0;
int cantidad = 0;
sem libre = 1;
sem sumaPieza = 1;
int piezas_Restantes = T;
int piezaXempleado[E] = ([E]0);
int idGanador;
int faltanTerminar = E;

process Empleados [ID: 0..E-1] {
    int i;
    P(mutex)
    cantidad++
    if (cantidad==E){
        for i = 1..E{
            V(llegaron)
        }
    }
    V(mutex)
    P(llegaron)
    P(libre)
    while (piezas_Restantes>0){
        piezas_Restantes--;
        # Toma la pieza
        V(libre)
        # Realiza la pieza
        P(sumaPieza)
        piezaXempleado[ID]++
        V(sumaPieza)
        P(libre)
    }
    V(libre)
    P(mutex)
    faltanTerminar--;
    if (faltanTerminar==0){
        idGanador = max(piezaXempleado);
        for i = 1..E{
            V(llegaron)
        }
    }
    V(mutex)
    P(llegaron)
    if (ID==idGanador){
        print("Recibi un premio por ser el que mayor piezas fabrico");
    }
}