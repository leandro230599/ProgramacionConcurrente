###
En un vacunatorio hay un empleado de salud para vacunar a 50 personas. El empleado
de salud atiende a las personas de acuerdo con el orden de llegada y de a 5 personas a la
vez. Es decir, que cuando está libre debe esperar a que haya al menos 5 personas
esperando, luego vacuna a las 5 primeras personas, y al terminar las deja ir para esperar
por otras 5. Cuando ha atendido a las 50 personas el empleado de salud se retira. Nota:
todos los procesos deben terminar su ejecución; asegurarse de no realizar Busy Waiting;
suponga que el empleado tienen una función VacunarPersona() que simula que el empleado
está vacunando a UNA persona. 
###

cola C;
sem mutex = 1;
int cantidad = 0;
sem hayCinco = 0;
sem disponible = 1;
sem vacunado[50] = ([50],0);

process Persona [ID: 0..49]{
    # Llega la persona
    P(mutex);
    # Se encola
    push(ID,C);
    cantidad++;
    # Se verifica si hay 5 personas o no
    if (cantidad==5){
        # Si hay 5 personas se verifica que el vacunador este disponible
        P(disponible);
        # Se le avisa que hay 5 personas para vacunarse
        V(hayCinco);
        cantidad=0;
    }
    V(mutex);
    P(vacunado[id]);
}

process Vacunador {
    int i,j,idpaciente;
    for i = 1..10{
        # Espera a que haya 5 pacientes
        P(hayCinco);
        for j = 1..5{
            # Toma el primer paciente de acuerdo al orden de llegada y lo vacuna
            idpaciente = pop(C);
            VacunarPersona(idpaciente)
            V(vacunado[idpaciente])
        }
        # Notifica que termino de vacunar a los 5 y esta disponible
        V(disponible);
    }


}