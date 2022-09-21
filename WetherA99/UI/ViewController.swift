
import UIKit
import CoreLocation
class ViewController: UIViewController {
  
    @IBOutlet var buttonToFavorite: UIButton!
    @IBOutlet var buttonToSearch: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var currentTemp: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    var weather :  Weather?
    
//    var locationLat = 0.0
//    var locationLon = 0.0
  
    private let locationManager = CLLocationManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        currentLocation()
//        locationManager.delegate = self
        let nib = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "WeatherTableViewCell")
        table.delegate = self
        
        table.dataSource = self
        
   
        label.isHidden = true
        currentTemp.isHidden = true
        table.layer.cornerRadius = 15
        
        
        currentLocationUrl()
        setupUI()
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        Core.shared.setistwutNewUser()
        if Core.shared.isNewUser () {
            let vc = storyboard?.instantiateViewController(identifier: "welcome") as! WelcomeViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    func setupUI() {
       
     //   nameLabel.text = "nameLabel".localized()
       
    }
    func currentLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100

        
    }
    
    func currentLocationUrl() {
        let factURL = URL(string:
                            "https://api.weatherapi.com/v1/forecast.json?key=f13d318f41a047e7840191932222406&q=\(Settings.locationLat),\(Settings.locationLon)&days=7&aqi=no&alerts=no")!
        let session = URLSession(configuration: .default)

        let dataTask =  session.dataTask(with: factURL) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(Weather.self, from: data)
                self.weather = weatherResponse
                DispatchQueue.main.async {
                    self.label.text = weatherResponse.location.name
                    self.currentTemp.text = "\(Int(weatherResponse.current.temp_c)) °"
                    self.label.isHidden = false
                    self.currentTemp.isHidden = false
                    self.table.reloadData()
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }

        dataTask.resume()
    }
    @IBAction func buttonToSearchPressed(_ sender: Any) {
        let searchViewController = SearchViewController.instantiate()
        searchViewController.modalPresentationStyle = .fullScreen
        present(searchViewController, animated: true)
    }
    
    @IBAction func buttonToFavoritePressed(_ sender: Any) {
        let favoriteViewController = FavoriteViewController.instantiate()
        favoriteViewController.modalPresentationStyle = .fullScreen
        present(favoriteViewController, animated: true)
    }
    
    
}
//extension ViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locationValue : CLLocationCoordinate2D = manager.location?.coordinate else{
//            return
//        }
//        Settings.locationLat = locationValue.latitude
//        locationLon = locationValue.longitude
//        print (locationLon)
//    }
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print(status)
//        if status == .authorizedAlways ||
//            status == .authorizedWhenInUse {
//            manager.startUpdatingLocation()
//        }
//
//    }
//}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather?.forecast.forecastday.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = table.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as!
        WeatherTableViewCell
        if let weather = weather {
            cell.configure(with: weather, index: indexPath.row)
        }

        cell.backgroundColor = UIColor(red: 51/255.0, green: 109/255.0, blue: 150/255.0, alpha: 1.0)

       return cell
    }


    }


class Core {
    static let shared = Core()
    func isNewUser()-> Bool {
        
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }

    func setistwutNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
