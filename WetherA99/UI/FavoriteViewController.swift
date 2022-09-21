
import UIKit

class FavoriteViewController: UIViewController {
    var weather :  Weather?
    var cityNameMaped: [URL] = [].compactMap {URL(string: $0)}
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let array = UserDefaults.standard.array(forKey: .enteredCityArray) {
            Settings.cityFavoriteArray = array as! Array<String> 
        }
        setupCollectionView()
        collectionView.backgroundColor = .tintColor
        
        for name in Settings.cityFavoriteArray {
            
            cityNameMaped.append(URL(string: "https://api.weatherapi.com/v1/forecast.json?key=f13d318f41a047e7840191932222406&q=\(name)&days=7&aqi=no&alerts=no")!)
        }
    }
 

    private func setupCollectionView() {
       
        collectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as!
        WeatherCollectionViewCell
        let factURL = cityNameMaped[indexPath.item]

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
                DispatchQueue.main.async {
                   
                        cell.configure(with: weatherResponse)
                       // collectionView.reloadData()
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }

        dataTask.resume()
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Settings.cityFavoriteArray.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ForecastViewController", bundle: nil)
        switch Settings.cityFavoriteArray[indexPath.item]{
        case Settings.cityFavoriteArray[indexPath.item]:
            if let forecastViewController = storyboard.instantiateViewController(identifier: "ForecastViewController") as? ForecastViewController {
                forecastViewController.modalPresentationStyle = .fullScreen
                forecastViewController.forecastUrl = cityNameMaped[indexPath.item]
                present(forecastViewController, animated: true)
            }
        default:
            print("Not found")
            }
        }
    }

