CoinTrackr
CoinTrackr es una aplicación de seguimiento de criptomonedas desarrollada en Flutter que utiliza Firebase para la autenticación y Firestore para almacenar los datos de los usuarios. La aplicación sigue la arquitectura limpia y utiliza pruebas unitarias para garantizar la calidad del código.

Características
Registro y autenticación de usuarios utilizando Firebase.
Seguimiento de criptomonedas con listado y búsqueda.
Posibilidad de marcar criptomonedas como favoritas.
Gestión de estado con Provider.
Arquitectura limpia para mantener la separación de responsabilidades.
Pruebas unitarias para casos de uso y repositorios.
Tecnologías Utilizadas
Flutter: Framework de desarrollo de aplicaciones móviles.
Firebase Authentication: Para la autenticación de usuarios.
Firestore: Base de datos en la nube para almacenar los datos de los usuarios y sus criptomonedas favoritas.
Provider: Gestión del estado.
get_it: Para la inyección de dependencias.
Mockito: Para pruebas unitarias con mocks.
Flare: Para animaciones.
Configuración del Proyecto
Requisitos Previos
Tener instalado Flutter.
Tener configurado un proyecto de Firebase.
Tener configurado un editor de texto como VS Code o Android Studio.
Instalación
Clonar el repositorio:

bash
Copiar código
git clone https://github.com/SebastianVargas98/coin_trackr
cd cointrackr
Instalar las dependencias:

bash
Copiar código
flutter pub get
Configurar Firebase:

Descarga el archivo google-services.json desde la consola de Firebase para Android y colócalo en el directorio android/app.

bash
Copiar código
flutter run
Estructura del Proyecto
El proyecto sigue la arquitectura limpia, separando las responsabilidades en core, features, y common. A continuación, una descripción de la estructura del proyecto:

core: Contiene elementos comunes del proyecto como entidades, errores y repositorios principales.
features: Cada característica tiene su propio subdirectorio con los elementos específicos (data, domain, presentation).
common: Contiene utilidades comunes, widgets compartidos, y otros elementos que pueden ser utilizados en todo el proyecto.
Pruebas
El proyecto incluye pruebas unitarias para los casos de uso y repositorios. Para ejecutarlas:

bash
Copiar código
flutter test
Inyección de Dependencias
Se utiliza get_it para manejar la inyección de dependencias en todo el proyecto. Las dependencias se configuran en el archivo lib/injection_container.dart.

Contribuciones
Las contribuciones son bienvenidas. Por favor, sigue estos pasos para contribuir:

Haz un fork del proyecto.
Crea una nueva rama para tu funcionalidad (git checkout -b feature/tu-funcionalidad).
Haz commit de tus cambios (git commit -am 'Añade nueva funcionalidad').
Sube tu rama (git push origin feature/tu-funcionalidad).
Crea un Pull Request.