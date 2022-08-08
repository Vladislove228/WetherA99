//
//  ViewController.swift
//  WetherA99
//
//  Created by Владислав Квинто on 24/06/2022.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var currentTemp: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    var weather :  Weather?
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        let nib = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "WeatherTableViewCell")
        table.delegate = self
        
        table.dataSource = self
        
   
        label.isHidden = true
        currentTemp.isHidden = true
        table.layer.cornerRadius = 15
        searchBar.layer.cornerRadius = 20
        setupUI()
    }

    func setupUI() {
       
    //    nameLabel.text = "nameLabel".localized()
       
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        

        let factURL = URL(string:
            "https://api.weatherapi.com/v1/forecast.json?key=f13d318f41a047e7840191932222406&q=\(searchBar.text!)&days=7&aqi=no&alerts=no")!
        
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
}


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
