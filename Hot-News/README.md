#  Description 
<div align='left'>
Esta Aplicacion esta construida en base una API pública, el proyecto consta de 3 modulos: La Home la cual muestra los posts de todos los usuarios y da la opcion de dar like a un post, ofrece la facilidad de ver a en completo el detalle de un post seleccionando cualquiera de sus celdas; el segundo modulo es el detalle de un post el cual muestra al completo la informacion del post, informacion del usuario que lo realizó y todos los comentarios del mismo, y el perfil el cual muestra informacion del usuario como la cantidad de post que este realizó y los posts a los que les ha dado like junto con una lista con todos los posts que éste ha realizado, para este proyecto se realizaron llamados a 4 servicios diferentes: 
 
 1) Todos los posts de todos los usuarios. 
 2) Los comentarios de un post segun su id. 
 3) La informacion del usuario que realizo el post. 
 4) Todos los posts realizados por un usuario

 
 # Requerimientos
 
 <div align='center'>
<a href="url"><img src="https://github.com/YormanColina/Hot-News/blob/main/Hot-News/resources/Requerimientos.png" align="center" height=500></a>
 </div>
 
# Herramientas:
 
 - UIKit: Para la construcccion de vistas
 - RXSwift y RXCocoa: Para la comunicación reactiva entre las partes de la arquitectura
 - Alamofire: Para la conexion de red con la API pública
 - ObjectMapper: Para el mapeo de datos
 - UserDefautls: Para guardar informacion en la memoria de la aplicacion
 - Cocoapods: Importacion de librerias externas
 
# Arquitecrura:
 Use la arquitectura MVVM(Modelo - Vista - VistaModelo) para la aplicacion por el alcance del proyecto al no ser de una funcionalidad tan extendida es mas sencilla la comunicacion entre las distintas partes de un modulo es de fail lectura y comprension
 
# Como esta estructurado el proyecto:
- Hot-News : Carpeta base del proyecto
  - Resources : Todas las imagenes y colores
  - Base: AppDelegate, SceneDelegate, LaunchScreen
  - Modulos 
    - Core: Contiene logica que puede ser usada para todos los modulos
    - Onboarding : Todo lo referente a la vista del OnBoarding
    - Profile : Todo lo referente a la vista del perfil
    - Comments : Todo lo refernte a la vista de los comentarios
    - Home : Todo lo referente a la vista de la Home
 - Hot-NewsTests : Tests Unitarios
 
 # Como esta estructurado cada modulo:
- View: Contiene todo lo referente a la UI
- ViewModel: Contiene toda la logica del modulo
- Models: Contiene los modelos de datos
- ApiService(extension de la arquitectura): Contiene los llamados a la red

 
 # Como correr el proyecto:
 - git clone git@github.com:YormanColina/Hot-News.git
 - cd path del proyecto
 - pod install
 - open .workspace
 - command + R
 
