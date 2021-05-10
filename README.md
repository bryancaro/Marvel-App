![](https://imagenes.20minutos.es/files/image_656_370/uploads/imagenes/2014/10/28/marvel.jpg)

# Marvel App

La aplicación permite a los usuarios visualizar algunos personajes de Marvel con sus respectivos detalles (Comics, series y eventos destacados donde aparece el personaje).

![Swift](https://img.shields.io/badge/Swift-5.0-blue.svg)
 ![No Storyboards](https://img.shields.io/badge/No-Storyboards-lightgrey.svg?style=flat)

#### Características: 
     
- Escrito en Swift 5 & Xcode 12.5
- iOS 14 & No Storyboards
- Arquitectura Model View ViewModel (MVVM)
- Datos suministrados por la API de Marvel (http://developer.marvel.com)
- UIPageViewController
- UICollectionView
- CocoaTouch librerías de terceros (TinyConstraints, RevealingSplashView, SDWebImage, CryptoSwift)

#### Requisitos: 

- iOS 13.0+
- Xcode 12

### Integración

#### CocoaPods (iOS 9+)

Puede usar CocoaPods para agregarlos a tu Podfile e instalar las librerías :

```swift
platform :ios, '13.0'

target 'mobile-test' do
  use_frameworks!

  # Pods for mobile-test
  pod 'TinyConstraints'
  pod 'RevealingSplashView'
  pod 'SDWebImage'

end
```

Tenga en cuenta que esto requiere la versión 36 de CocoaPods y que su destino de implementación de iOS sea al menos 9.0

#### Instalación con Swift Package Manager (Xcode 11+)

Swift Package Manager (SwiftPM) es una herramienta para administrar la distribución de código Swift, así como la dependencia de la familia C. Desde Xcode 11, SwiftPM se integró de forma nativa con Xcode.

CryptoSwift es compatible con SwiftPM desde la versión 5.1.0. Para usar SwiftPM, debe usar Xcode 11 para abrir su proyecto. Haga clic en Archivo -> Paquetes Swift -> Agregar dependencia de paquete, ingrese la URL del repositorio de CryptoSwift.

```swift
.package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.4.0"))
```

### Walkthrough:
 
![IMG_2662](https://user-images.githubusercontent.com/58017823/117590861-b4d05c80-b131-11eb-834e-c37154e730c5.PNG)![IMG_2660](https://user-images.githubusercontent.com/58017823/117590865-bef25b00-b131-11eb-8bac-ba6397f4d5bc.PNG)![IMG_2661](https://user-images.githubusercontent.com/58017823/117590870-c74a9600-b131-11eb-8bf3-d4b0fe68bc14.PNG)

### Developer: 
     
- Bryan Caro Monsalve
