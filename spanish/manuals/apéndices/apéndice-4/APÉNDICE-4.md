## Apéndice 4: Sistema Nervioso de Red (NNS)
<p align="center"> <img src="assets/nns_home.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> Página principal del NNS</p>

El DAO más desarrollado que opera en IC (¡hasta ahora!) es el que administra la propia red. Este DAO se llama **Sistema Nervioso de Red** y es responsable de tomar decisiones sobre el futuro de la red, coordinar varias partes y organizar la estructura de la red.

Típicamente, cuando se necesita actualizar una cadena de bloques, el proceso tarda unas pocas semanas o meses en completarse. Esto requiere que los operadores de nodos actualicen su software. Si algunos operadores de nodos se niegan a actualizar o si un grupo de ellos instala una versión diferente, puede resultar en un "fork", donde la cadena de bloques se divide en dos cadenas separadas, creando dos redes completamente diferentes de menor tamaño.

<p align="center"> <img src="assets/hard_fork.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> El fork de Bitcoin de 2017 dividió la comunidad, algunos abogando por un aumento en el tamaño de los bloques, lo que llevó a la creación de dos versiones: el Bitcoin original y Bitcoin Cash con nuevas reglas.</p>

En Internet Computer, las actualizaciones son votadas por el **Sistema Nervioso de Red** (NNS, por sus siglas en inglés). Si las actualizaciones son aceptadas, el software de los nodos se actualiza directamente, lo que mitiga la posibilidad de un fork.
<br/>
El NNS está gobernado por una democracia líquida, en la que los titulares de ICP apuestan sus ICP para crear neuronas. El poder de voto de estas neuronas se basa en:
- La cantidad de ICP apostados.
- La duración de la apuesta.
- La antigüedad de la neurona.

<p align="center"> <img src="assets/neuron_recap.png" width="800px" style="border: 2px solid black;"> </p>

Las propuestas que pueden ser votadas por el **NNS** (**Sistema Nervioso de Red**) se agrupan en diferentes categorías, como:

- 💸 Economía de la red: propuestas relacionadas con la determinación de las recompensas pagadas a los operadores de nodos.
- 👨‍💼 Administración de nodos: propuestas relacionadas con la administración de las máquinas de nodos, incluyendo la actualización o configuración del sistema operativo, el marco de la máquina virtual o el software de réplica del nodo.
- 🌏 Administración de subredes: propuestas relacionadas con la administración de subredes de la red, como la creación de nuevas subredes, la adición y eliminación de nodos de subred o la división de subredes.
- 🧑‍⚖️ Gobernanza: propuestas relacionadas con la administración de la gobernanza, como mociones y la configuración de ciertos parámetros.

Para obtener más información sobre el increíble poder del NNS, consulte la [Wiki de Internet Computer](https://wiki.internetcomputer.org/wiki/Network_Nervous_System).

El NNS está constituido por **diferentes canisters**. Cada canister se implementa en la misma subred que también se llama la [subred NNS](https://dashboard.internetcomputer.org/subnet/tdb26-jop6k-aogll-7ltgs-eruif-6kk7m-qpktf-gdiqx-mxtrf-vb5e6-eqe).

<p align="center"> <img src="assets/nns_recap.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> Resumen de los canisters que ejecutan el NNS</p>

-  🏦 [Ledger](https://icscan.io/canister/ryjl3-tyaaa-aaaaa-aaaba-cai): Este canister es responsable de controlar el balance de ICP para todos los usuarios, procesar transacciones, acuñar y quemar ICP.
- 🏛️ [Gobernanza](https://icscan.io/canister/rrkah-fqaaa-aaaaa-aaaaq-cai): Este canister es responsable de hacer un seguimiento de las neuronas, propuestas y votos y, en última instancia, tomar acciones cuando las propuestas son aceptadas o rechazadas.
- 🏭[Registro](https://icscan.io/canister/rwlgt-iiaaa-aaaaa-aaaaa-cai): Este canister es responsable de almacenar y modificar la configuración de Internet Computer (Agregar o eliminar nodos, agregar o eliminar subredes, almacenar claves públicas de subredes, asignar nodos a subredes, almacenar identificadores de canisters y a qué subred pertenecen...)
- 🪟 [NNS-UI](https://icscan.io/canister/qoctq-giaaa-aaaaa-aaaea-cai): Este canister es responsable de almacenar la interfaz oficial que proporciona a los usuarios una forma de interactuar con los otros 3 canisters. 

> **NNS-UI** es la interfaz principal para interactuar con el **NNS**, pero se pueden crear otras interfaces amigables para el usuario. La comunidad ya ha creado una [interfaz que permite la creación de propuestas sin usar una terminal](https://nnsproposal.icp.xyz/), una función faltante en la interfaz principal del **NNS-UI**.

Como hemos visto con el ejemplo del **NNS**, construir un **DAO** puede implicar la implementación y gestión de varios canisters.
