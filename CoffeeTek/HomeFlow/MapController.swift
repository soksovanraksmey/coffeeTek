//
//  GoogleMapController.swift
//  CoffeeTek
//
//  Created by ZED on 6/5/21.
//

import UIKit
import FloatingPanel
import Alamofire
import MapKit
import CoreLocation
//import SwiftyJSON
//import PhoneNumberKit
//import GoogleMaps
//import GooglePlaces

//MARK:- struct

struct DataModels:Decodable {
    let _id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let status: Int
    let __v: Int
}

class MapController: UIViewController ,FloatingPanelControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var currentLocationMarker: MKMarkerAnnotationView?
    var locationManager = CLLocationManager()
    var dataModel: [DataModels] = []
    var arrayMarker: [MKMarkerAnnotationView] = []
    var floatPanel : ContentController? = nil
    
    var distanceInMeters = CLLocationDistance()
    var coordinate0 = CLLocationCoordinate2D()
    var coordinate1 = CLLocationCoordinate2D()
    
    var pin: AnnotationPin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getShopLocation()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
//        tabBarController?.tabBar.isHidden = false
//        navigationController?.isNavigationBarHidden = true
        self.mapView.delegate = self
        
        // floatingPanel
        let fpc = FloatingPanelController()
        fpc.delegate = self
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentController") as? ContentController else {
            return
            }
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        
        // mapkit
        let coordinates = CLLocationCoordinate2D(latitude: 11.5527, longitude: 104.8446)
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 250, longitudinalMeters: 250)
        
        
        mapView.setRegion(region, animated: true)
        pin = AnnotationPin(title: "Phnom Penh", subtitle: "king Dom Cambodia", coordinate: coordinates)
        mapView.addAnnotation(pin)
        mapView.delegate = self
        
    }// viewcontroller
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "Phnom penh")
        annotationView.image = UIImage(named: "Pin-2")
        let tranform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            annotationView.transform = tranform
        annotationView.canShowCallout = true

       
        return annotationView
    }
//    override func viewDidAppear(_ animated: Bool) {
////        tabBarController?.tabBar.isHidden = false
//              navigationController?.isNavigationBarHidden = true
//
//    }

    override func viewDidLayoutSubviews() {
        navigationController?.isNavigationBarHidden = true
  
    }
//     func mapView(_ mapView: MKMapView, didTap marker: MKMarkerAnnotationView) -> Bool {
//        // index data from API
//        guard let index = arrayMarker.firstIndex(of: marker) else { return true }
//        let tappedState = dataModel[index]
//
//        marker.image =  #imageLiteral(resourceName: "Pin 1 tapped")
//        let camera = MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)
//
//        arrayMarker.forEach { pin in
//            pin.image = #imageLiteral(resourceName: "Pin 2")
//        }
//        if floatPanel == nil {
//            buttomSheet()
//
//            self.floatPanel!.locationAddress.text = tappedState.address
//            self.floatPanel!.cofeNameText.text = tappedState.name
//            // calculator
//            coordinate0 = CLLocationCoordinate2D(latitude: 0.20, longitude: 0.20)
//            coordinate1 = CLLocationCoordinate2D(latitude: 0.20, longitude: 0.20)
//            self.distanceInMeters = distance(from: coordinate0, to: coordinate1)
//
//            self.floatPanel?.KGmatter.text = String(format: " %.01fkm", distanceInMeters)
//            print("if  distance ==\(distanceInMeters) KM")
//
//            marker.image =  #imageLiteral(resourceName: "Pin 2")
////            let camera = GMSCameraPosition.camera(
////                withLatitude: marker.position.latitude,
////                longitude: marker.position.longitude, zoom: 17.5)
////            mapView.animate(to: camera)
//            let camera = MKCoordinateSpan(latitudeDelta: 17.5, longitudeDelta: 00)
//        } else {
//            self.floatPanel?.locationAddress.text = tappedState.address
//            self.floatPanel?.cofeNameText.text = tappedState.name
////           //MARK:- calculator
////            coordinate0 = CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude)
////            coordinate1 = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//            coordinate0 = CLLocationCoordinate2D(latitude: 0.20, longitude: 0.20)
//            coordinate1 = CLLocationCoordinate2D(latitude: 0.20, longitude: 0.20)
//            self.distanceInMeters = distance(from: coordinate0, to: coordinate1)
//            self.floatPanel?.KGmatter.text = String(format: " %.01fkm", distanceInMeters)
//            print("else  distance ==\(distanceInMeters) KM")
//
//            marker.image =  #imageLiteral(resourceName: "Pin 1 ")
////            let camera = GMSCameraPosition.camera(
////                withLatitude: marker.position.latitude,
////                longitude: marker.position.longitude, zoom: 17.5)
////            mapView.animate(to: camera)
//            let camera = MKCoordinateSpan(latitudeDelta: 17.5, longitudeDelta: 00)
//        }
//        return true
//     }
    
//    func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
//            let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
//            let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
//            return from.distance(from: to)
//        }
    
//        func buttomSheet() {
//            let floatingPanel = FloatingPanelController()
//                floatingPanel.delegate = self
//            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            floatPanel = storyboard.instantiateViewController(withIdentifier: "ContentController") as? ContentController
//            floatPanel?.finalModel = dataModel
//            floatingPanel.set(contentViewController: floatPanel!)
//            floatingPanel.addPanel(toParent: self)
//            // floatingPanel.isRemovalInteractionEnabled = true
//
//            floatPanel?.callback = {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let newController = storyboard.instantiateViewController(withIdentifier: "ContentController") as! ContentController
//                self.navigationController?.pushViewController(newController, animated: true)
//                // send title to table
//                newController.cofeNameText.text = self.floatPanel?.cofeNameText.text ?? ""
//            }
//        }
        
//    func getShopLocation() {
//        let request = AF.request("https://coffeetek.herokuapp.com/shop")
//        request.responseDecodable(of: [DataModels].self) { (response) in
//            guard let films = response.value else { return}
//            self.dataModel = films
//            print(self.dataModel.last)
//                // get latitude and longitude
//                let marker = MKMapView()
//                marker.position = CLLocationCoordinate2D(
//                    latitude:  data.latitude,
//                    longitude: data.longitude)
//                marker.map = self.mapView
//                marker.icon =  #imageLiteral(resourceName: "Pin 2")
//                marker.appearAnimation = .pop
//
//                self.arrayMarker.append(marker)
//            }
//        }
//    }// func getShop
    
}
     
