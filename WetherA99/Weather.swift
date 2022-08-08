

import Foundation


struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}


struct Current: Codable {
    let temp_c: Int
    let is_day: Int
    let condition: Condition
    let wind_kph: Double
    let humidity, uv: Int
}



struct Condition: Codable {
  
}

struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String


}

struct Forecast: Codable {
    let forecastday: [Forecastday]
}

struct Forecastday: Codable {
    let date: String
    let date_epoch: Int
    let day: Day

}


struct Day: Codable {
    let maxtemp_c, mintemp_c, maxwind_kph: Double
    let avghumidity: Double
    let condition: Condition

    
}

