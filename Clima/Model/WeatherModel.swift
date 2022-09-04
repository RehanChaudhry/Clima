//
//  WeatherModel.swift
//  Clima
//
//  Created by Rehan Chaudhry on 12/08/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let weatherDescription: String
    let tempreature: Double
    
    var tempreatureString: String {
        
        return String(format: "%.0f", tempreature)
    }
    
//     func getId() -> String{
//
//       return getWeatherCondition(id: conditionId)
//    }
    
    var weatherCondition: String {
        
        switch conditionId {
            
        case 200...232 : return "cloud.bolt.rain.fill"
            
        case 301...321 : return "cloud.drizzle.fill"
            
        case 500...531 : return "cloud.heavyrain.fill"
            
        case 600...622 : return "cloud.snow.fill"
            
        case 701 : return "cloud.fog.fill"
        case 711 : return "smoke.fill"
        case 721 : return "sun.haze.fill"
        case 731 : return "sun.dust.fill"
        case 741 : return "cloud.fog.fill"
        case 751 : return "aqi.medium"
        case 761 : return "sun.dust"
        case 762 : return "sun.dust"
        case 771 : return "aqi.low"
        case 781 : return "tornado"
            
        case 800 : return "sun.max"
            
        case 801...804 : return "cloud.fill"
            
        default:
            
            return "cloud"
            
        }
        
    }
    
    
}
