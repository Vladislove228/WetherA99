//
//  WeatherTableViewCell.swift
//  WetherA99
//
//  Created by Владислав Квинто on 24/06/2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var tableVIew: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempretureMinLabel: UILabel!
    @IBOutlet weak var tempretureMaxLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet var humidityView: UIView!
    @IBOutlet var windView: UIView!
    @IBOutlet weak var windLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        humidityView.layer.cornerRadius = 15
        windView.layer.cornerRadius = 15
       
        setupUI()
    }
    func setupUI() {
    
        humidityLabel.text = "humidityLabel".localized()
        windLabel.text = "windLabel".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func configure(with model: Weather, index: Int){
        self.dayLabel.text = "\(model.forecast.forecastday[index].date)"
        self.tempretureMinLabel.text = "\(Int(model.forecast.forecastday[index].day.mintemp_c)) °"
        self.tempretureMaxLabel.text = "\(Int(model.forecast.forecastday[index].day.maxtemp_c)) °"
        self.humidityLabel.text =  "\(Int(model.forecast.forecastday[index].day.avghumidity)) "
        self.windLabel.text =  "\(Int(model.forecast.forecastday[index].day.maxwind_kph)) km/h"
        
     
    }
    
}
