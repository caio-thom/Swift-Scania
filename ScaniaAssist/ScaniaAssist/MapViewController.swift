//
//  MapViewController.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 26/09/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        //Pedir que o mapa use a localizacao do usuario
        mapView.showsUserLocation = true
        
        //pelo userTrackingMode é definido que o mapa ira rastrear o usuario e centraliza-lo
        mapView.userTrackingMode = .follow
        
        mapView.delegate = self
        
        requestAuthorization()
        
     //   func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //   if let vc = segue.destination as? SiteViewController {
        //       vc.site = sender as! String
         //  }
    //    }

        
    }
    
    func requestAuthorization() {
        // kCLLocationAccuracyBest fornece a melhor precisao possivel para a localizacao
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //Metodo que utilia a autorizacao
        locationManager.requestWhenInUseAuthorization()
    }
    
    func showRoute(to destination: CLLocationCoordinate2D) {
        
        //objet de requisicao de rota
        let request = MKDirections.Request()
        
        //configura a origem e o destino, estes objetos sao do tipo MKMapItem e para crirar um MKMapItem precisa criar um MKPlacemark que pode ser criado a partir de uma coodernada
        request.source = MKMapItem(placemark: MKPlacemark(coordinate:mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        //MKDirections é o objeto que faz o calulo de rota p
        let directions = MKDirections(request: request)
        directions.calculate { (response,error) in
            if error == nil {
                
                //desenbrulhamos o response e tabem recupera a primeira rota da lista de rotas
                //presentes no respose
                guard let response = response, let route = response.routes.first else {return}
                
                //é possivel recupear uma serie de informacoes sobre a rota, nome, distancia, tempo, etc
                print("Nome:", route.name, "- distancia:", route.distance, "- duração:", route.expectedTravelTime)
                
                //recupera todos os passos a passos da rota
                for step in route.steps {
                    print("Em", step.distance, "metros, ", step.instructions)
                }
                
                //antes de add o overlay é preciso remover qualquer outra rota apresentada
                self.mapView.removeOverlays(self.mapView.overlays)
                
                //add a rota ao mapa isso é feito utilizando o overlay
                //propriedade polyline da a linha poligonal, é o que representa a rota(linha) que iremos colocar por cima do mapa
                //sera colocado a rota por cima das ruas e abaixo dos nomes das ruas
                self.mapView.addOverlays([route.polyline], level: .aboveRoads)
            }
        }
        
    }
    
  
}

extension MapViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Aqui é onde implementa o pontos de pesquisa de interrese
        //Tira o foco da Search Bar para esnconder o teclado
        searchBar.resignFirstResponder()
        
        //objto que configura os parametros da pesquisa
        let request = MKLocalSearch.Request()
        
        // naturalLanguageQuery contem o texto que sera utilizado na busca
        request.naturalLanguageQuery = searchBar.text
        
        //Define a regiao que sera usada para buscarmos pontos de interresse
        request.region = mapView.region
        
        //objeto que realiza a busca
        let search = MKLocalSearch(request: request)
        
        //pelo metodo start realiza a busca
        search.start {(response, error ) in
            if error == nil {
                
                // se nao tiver erro, sera recuperado os elementos solicitados
                guard let response = response else {return}
                
                // o objeto response possui propriedades cha,ada mapItems, onde contem todos os locais encontrados na pesquisa
                //antes de add novas, remove todos as annotations presente no mapa
                self.mapView.removeAnnotations(self.mapView.annotations)
                
                for item in response.mapItems {
                    
                    //Cria uma annotation
                    let annomation = MKPointAnnotation()
                    
                    //Denife a coodernda, titulo  e subtitulp
                    annomation.coordinate = item.placemark.coordinate
                    annomation.title = item.name
                    annomation.subtitle = item.url?.absoluteString
                    
                    self.mapView.addAnnotation(annomation)
                }
                
            }
        }
    }
}


extension MapViewController:MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // se o overlay for uma MKPolyline, usa o renderer correspondente
        if overlay is MKPolyline {
            //cria um renderer para polylines
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            //define sua espressura e a cor
            renderer.lineWidth = 8.0
            renderer.strokeColor = .red
            
            return renderer
        }
        else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
    
    //Metodo é chamado quando o Annotation View é selecionada
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        //Recuperando annotation e nome
        guard let annotation = view.annotation, let name = annotation.title else {return}
        
        let alert = UIAlertController(title: name, message: "O que deseja fazer?", preferredStyle: .actionSheet)
        
        //Action para traçar a rota
        let routeAction = UIAlertAction(title: "Traçar rota", style: .default) {(action) in
                //chama metodo que ira mostrar a rota
            self.showRoute(to:annotation.coordinate)
        }
        
        alert.addAction(routeAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        present(alert,animated: true,completion: nil)
    }
    
}



