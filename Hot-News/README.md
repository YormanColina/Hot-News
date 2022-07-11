<div align='center'>
 Home
<a href="url"><img src="https://github.com/YormanColina/Hot-News/blob/main/Hot-News/resources/Home.png" align="leading" height=500></a>
 Profile
<a href="url"><img src="https://github.com/YormanColina/Hot-News/blob/main/Hot-News/resources/Profile.png" align="center" height=500></a>
 PostDetail
<a href="url"><img src="https://github.com/YormanColina/Hot-News/blob/main/Hot-News/resources/Comments.png" align="trailing" height=500></a>
 </div>
  
  
#  Descripción 
<div align='left'>
Esta Aplicación esta construida en base una API pública, el proyecto consta de 3 módulos: La Home la cual muestra los posts de todos los usuarios y da la opción de dar like a un post, ofrece la facilidad de ver en completo el detalle de un post seleccionando cualquiera de sus celdas; el segundo módulo es el detalle de un post el cuál muestra al completo la información del post, información del usuario que lo realizó y todos los comentarios del mismo, y el perfíl el cual muestra información del usuario como la cantidad de post que este realizó y los posts a los que les ha dado like junto con una lista con todos los posts que éste ha realizado, para este proyecto se realizaron llamados a 4 servicios diferentes: 
 
 1) Todos los posts de todos los usuarios. 
 2) Los comentarios de un post según su id. 
 3) La información del usuario que realizó el post. 
 4) Todos los posts realizados por un usuario

 
 # Requerimientos
 
 <div align='center'>
<a href="url"><img src="https://github.com/YormanColina/Hot-News/blob/main/Hot-News/resources/Requerimientos.png" align="center" height=500></a>
 </div>
 
# Herramientas:
 
 - UIKit: Para la construccción de vistas
 - RXSwift y RXCocoa: Para la comunicación reactiva entre las partes de la arquitectura
 - Alamofire: Para la conexión de red con la API pública
 - ObjectMapper: Para el mapeo de datos
 - UserDefautls: Para guardar información en la memoria de la aplicación
 - Cocoapods: Importación de librerias externas
 
# Arquitectura:
 Use la arquitectura MVVM(Modelo - Vista - VistaModelo) para la aplicación por el alcance del proyecto al no ser de una funcionalidad tan extendida es mas sencilla la comunicacion entre las distintas partes de un módulo es de fácil lectura y comprensión
 
# Como está estructurado el proyecto:
- Hot-News : Carpeta base del proyecto
  - Resources : Todas las imágenes y colores
  - Base: AppDelegate, SceneDelegate, LaunchScreen
  - Modulos 
    - Core: Contiene lógica que puede ser usada para todos los módulos
    - Onboarding : Todo lo referente a la vista del OnBoarding
    - Profile : Todo lo referente a la vista del perfil
    - Comments : Todo lo refernte a la vista de los comentarios
    - Home : Todo lo referente a la vista de la Home
 - Hot-NewsTests : Tests Unitarios
 
 # Como esta estructurado cada módulo:
- View: Contiene todo lo referente a la UI
- ViewModel: Contiene toda la lógica del módulo
- Models: Contiene los modelos de datos
- ApiService(extension de la arquitectura): Contiene los llamados a la red

 
 # Como correr el proyecto:
 - git clone git@github.com:YormanColina/Hot-News.git
 - cd path del proyecto
 - pod install
 - open .workspace
 - command + R
 
