//
//  ForecastViewController.swift
//  WetherA99
//
//  Created by Владислав Квинто on 18/09/2022.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet var table: UITableView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    var forecastUrl = URL(string: "")
    var weather :  Weather?
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "WeatherTableViewCell")
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 15
        table.backgroundColor = .tintColor
        cityNameLabel.isHidden = true
        currentTempLabel.isHidden = true
        forecast()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func forecast() {
        
        let session = URLSession(configuration: .default)

        let dataTask =  session.dataTask(with: forecastUrl!) { data, response, error in
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


extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {

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
