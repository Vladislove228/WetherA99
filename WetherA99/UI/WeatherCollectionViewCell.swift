//
//  WeatherCollectionViewCell.swift
//  WetherA99
//
//  Created by Владислав Квинто on 17/09/2022.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var tempretureCurrent: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(with model: Weather){
        self.cityName.text = model.location.name
        self.tempretureCurrent.text = "\(Int(model.current.temp_c)) °"
        self.humidityLabel.text =  "\(Int(model.current.humidity)) "
        self.windLabel.text =  "\(Int(model.current.wind_kph)) km/h"
        
     
    }
    
//    func configure(with model: Weather, index: Int){
//
//        self.tempretureMinLabel.text = "\(Int(model.forecast.forecastday.mintemp_c)) °"
//        self.tempretureMaxLabel.text = "\(Int(model.forecast.forecastday[index].day.maxtemp_c)) °"
//        self.humidityLabel.text =  "\(Int(model.forecast.forecastday[index].day.avghumidity)) "
//        self.windLabel.text =  "\(Int(model.forecast.forecastday[index].day.maxwind_kph)) km/h"
//
//
//    }
}
