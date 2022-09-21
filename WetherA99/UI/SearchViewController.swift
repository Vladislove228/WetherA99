

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var addButton: UIButton!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var table: UITableView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    var weather :  Weather?
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.layer.cornerRadius = 15
        let nib = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "WeatherTableViewCell")
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 15
        table.backgroundColor = .tintColor
        cityNameLabel.isHidden = true
        currentTempLabel.isHidden = true
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveCityArray(cityArray: Settings.cityFavoriteArray)
        
    }
    func filterCity() {
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        if cityNameLabel.isHidden == false {
            Settings.cityFavoriteArray.append(cityNameLabel.text!)
            
        }
    }
    private func saveCityArray(cityArray: Array<Any>?){
        guard let cityArray = cityArray else {
            return
        }
        UserDefaults.standard.set(cityArray, forKey: .enteredCityArray)
    }

}
extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        table.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
        let cityForUrl = searchBar.text!.replacingOccurrences(of: " ", with: "%20")
        let factURL = URL(string:
            "https://api.weatherapi.com/v1/forecast.json?key=f13d318f41a047e7840191932222406&q=\(cityForUrl)&days=7&aqi=no&alerts=no")!
        
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
                   
                    self.cityNameLabel.text = weatherResponse.location.name
                    self.currentTempLabel.text = "\(Int(weatherResponse.current.temp_c)) °"
                    self.cityNameLabel.isHidden = false
                    self.currentTempLabel.isHidden = false
                    self.table.reloadData()
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
    
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

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
