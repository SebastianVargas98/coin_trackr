# CoinTrackr

CoinTrackr es una aplicación de seguimiento de criptomonedas desarrollada en Flutter que utiliza Firebase para la autenticación y Firestore para almacenar los datos de los usuarios. La aplicación sigue la arquitectura limpia y utiliza pruebas unitarias para garantizar la calidad del código.

## Características

- Registro y autenticación de usuarios utilizando Firebase.
- Seguimiento de criptomonedas con listado y búsqueda.
- Posibilidad de marcar criptomonedas como favoritas.
- Gestión de estado con Provider.
- Arquitectura limpia para mantener la separación de responsabilidades.
- Pruebas unitarias para casos de uso y repositorios.

## Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo de aplicaciones móviles.
- **Firebase Authentication**: Para la autenticación de usuarios.
- **Firestore**: Base de datos en la nube para almacenar los datos de los usuarios y sus criptomonedas favoritas.
- **Provider**: Gestión del estado.
- **get_it**: Para la inyección de dependencias.
- **Mockito**: Para pruebas unitarias con mocks.
- **Flare**: Para animaciones.

## Configuración del Proyecto

### Requisitos Previos

- Tener instalado [Flutter](https://flutter.dev/docs/get-started/install).
- Tener configurado un proyecto de Firebase.
- Tener configurado un editor de texto como VS Code o Android Studio.

### Instalación

1. **Clonar el repositorio**:

   ```bash
   git clone https://github.com/tu-usuario/cointrackr.git
   cd cointrackr
