# Apéndice 2: Desbloqueando el poder de los DAOs con canisters.
## 🧩 ¿Qué es un DAO?
> Durante esta semana, tendrás la oportunidad de construir un prototipo para una Organización Autónoma Descentralizada (DAO, por sus siglas en inglés). Es por eso que queremos responder una pregunta importante: **¿Qué es un DAO?**

## 🏛️ ¿Una nueva forma de gobernanza? Organización Autónoma Descentralizada

<p align="center"> <img src="./assets/dao_icon.png" width="300px" style="border: 2px solid black;"> </p>

A lo largo de la historia, los humanos han encontrado diferentes formas creativas de organizarse en grupos y estructuras sociales. Lo han hecho por diferentes razones, como la seguridad, el apoyo, la identidad social, el trabajo, el poder o incluso lo económico. Algunos grupos comunes incluyen: la unidad familiar, las tribus, los clanes, los estados, los gremios, las sociedades secretas, los partidos políticos...

Con la aparición de Internet, las redes sociales, las criptomonedas y los contratos inteligentes, muchos creen que un nuevo tipo de organización está a punto de comenzar un nuevo capítulo en la historia humana: **DAO**.

Una Organización Autónoma Descentralizada (DAO) es una organización digital compuesta por miembros que viven en todo el mundo, y está gobernada y organizada por contratos inteligentes.

Debido a que los contratos inteligentes se ejecutan automáticamente, son descentralizados, transparentes, no pueden ser censurados ni modificados por ningún individuo, lo mismo se aplica a los **DAO** en el sentido de que no están controlados por ningún individuo o entidad individual, sino que operan en función de la toma de decisiones colectivas de sus miembros.

Algunos casos de uso para los DAO incluyen:

- **Capital de riesgo descentralizado**: Los DAO se pueden utilizar para habilitar fondos de capital de riesgo descentralizados, en los que los miembros pueden proponer y votar sobre inversiones en proyectos. [The DAO](https://en.wikipedia.org/wiki/The_DAO_(organization)) fue uno de los primeros DAOs en ser creado y fue diseñado para ser un fondo de capital de riesgo descentralizado, aunque fue controvertido y finalmente fracasó debido a un hackeo.

- **Toma de decisiones**: Los DAO se pueden utilizar para permitir que los miembros tomen decisiones sobre la dirección de un proyecto u organización. Por ejemplo, MakerDAO es una plataforma de finanzas descentralizadas (DeFi) que se construye en la cadena de bloques Ethereum y está gobernada por un DAO, en el que los miembros pueden votar sobre propuestas para cambiar los parámetros del sistema MakerDAO, como las tasas de interés en los préstamos.

## 🙁 Limitaciones de los DAOs
Como hemos dicho, los DAO se forman a través de contratos inteligentes. Sin embargo, los contratos inteligentes son bastante limitados:
- No pueden almacenar una cantidad significativa de datos (fotos, videos, archivos...). [Se ha estimado que el costo de almacenar 1 GB de datos en la cadena de bloques Ethereum ronda los $5.5 millones](https://steemit.com/ethereum/@suryanshkumr/you-need-usd5-5m-to-save-1gb-data-in-ethereum-blockchain-d)
- No es posible interactuar directamente con los contratos inteligentes desde un navegador. Es necesario instalar un monedero y que actúe como intermediario.
- Los contratos inteligentes dependen de los oráculos para obtener información del mundo exterior y facilitar la comunicación con él, ya que no pueden interactuar con nada fuera de la cadena de bloques por sí mismos.
- Los contratos inteligentes tienen limitaciones en términos de poder computacional al que tienen acceso.

Estas limitaciones técnicas dan lugar a acciones concretas que un DAO no podría realizar:
- 🌳 **Interactuar con el mundo físico**: Los DAO se limitan al mundo digital y no pueden interactuar con el mundo físico. Un DAO no podría plantar un árbol, encender un interruptor de luz o entregar una carta física.
- 📲 **Acceder a fuentes de datos externas**: Por ejemplo, un DAO no podría recuperar la temperatura actual de un sitio web de clima o el precio actual de las acciones de un sitio web financiero.
- 🔮 **Utilizar potencia computacional avanzada**: Por ejemplo, un DAO no podría ejecutar simulaciones para predecir el resultado de un sistema complejo, como la propagación de una pandemia o el rendimiento de una cartera financiera.
- 🗂️ **Manejar grandes cantidades de datos**: Por ejemplo, un DAO no podría almacenar y procesar los registros médicos completos de millones de pacientes.

Estas importantes limitaciones impiden que los DAO tengan un impacto significativo en el mundo.

## 🚀 Desde los contratos inteligentes hasta los canisters
Imagina que los contratos inteligentes pudieran:
- Almacenar una cantidad ilimitada de datos y ejecutar cualquier cálculo.
- Ser accesibles directamente desde cualquier navegador.
- Comunicarse con el mundo exterior a través de solicitudes HTTP.
- Crear y firmar transacciones en cualquier cadena de bloques (Bitcoin, Ethereum...).
- Ser actualizables para agregar constantemente nuevas funciones y solucionar posibles errores.
- Eliminar las comisiones y permitir que cualquier persona interactúe con ellos.

¿Suena interesante? ¡Bienvenido al fabuloso mundo de **canisters**! <br/>

<p align="center"> <img src="assets/canister.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> ¡Imagina lo que los DAO podrán lograr usando canisters!</p>
Al utilizar canisters, los DAO ahora pueden controlar aplicaciones web completas.

Esto significa que los futuros servicios web (redes sociales, motores de búsqueda, juegos, clientes de correo electrónico, aplicaciones de mensajería, etc.) pueden ejecutarse completamente en un conjunto de canisters, donde la gobernanza de esos canisters está garantizada mediante un canister de gobernanza pública tokenizado.  <br/>

<p align="center"> <img src="assets/ois.png" width="800px" style="border: 2px solid black;"> </p>

Este concepto se llama Servicios de Internet Abiertos. El objetivo es acabar con el actual monopolio de las grandes empresas tecnológicas (Facebook, Google, Apple, Twitter, Microsoft, Tiktok...) que se benefician del aspecto centralizado de Internet. Al alinear los incentivos entre inversores, usuarios y desarrolladores, se espera que estos servicios operen de manera más transparente, respetuosos de la privacidad y cooperativa.

<p align="center"> <img src="assets/web2_web3.jpeg" width="400px" style="border: 2px solid black;"> </p>

> **¿Una predicción?** <br/> Los servicios de Internet Abiertos son poderosos y no se detendrán en las redes sociales o las aplicaciones de mensajería. Están aquí para revolucionar la forma en que trabajamos y vivimos juntos. Con la escalabilidad sin precedentes del trabajo colaborativo habilitado por el poder combinado de los DAO y los OISs, ¡el cielo es el límite! Imagina el impacto positivo en la humanidad con proyectos como la conservación del medio ambiente, la investigación médica y la educación siendo amplificados por este nuevo nivel de coordinación y colaboración. Y esto es solo la punta del iceberg, ya que esta nueva tecnología podría abrir la puerta a soluciones aún más innovadoras para algunos de los problemas más apremiantes del mundo.
> **Prepárate ¡el futuro está aquí!**
