import Foundation
import CoreLocation

protocol WeatherModelDelegate {
    
    func getWeatherData(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didGetError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherModelDelegate?
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=9bbca2072b1a1514fce804c07191a15e&units=metric"
    func fetchWeather(city: String) {
        
        let url = "\(baseUrl)&q=\(city)"
        
        performRequest(with: url)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
        let url = "\(baseUrl)&lat=\(lat)&lon=\(lon)"
        print(url)
        performRequest(with: url)
    }
    
    func performRequest(with urlString : String) {
        
        //Create URL
        if let url = URL(string: urlString) {
            
            //Create URL Session
            
            let session = URLSession(configuration: .default)
            
            //Give Session a Task
            
            
            let task = session.dataTask(with: url, completionHandler:  { (data, urlResponse, error) in
                
                if error != nil {
                    
                    self.delegate?.didGetError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJson(safeData) {
                        
                        self.delegate?.getWeatherData(self, weather: weather)
                    }
                    
                }
                
            })
            
            //Start task
            
            task.resume()
            
        }
        
    }
    
    func parseJson(_ wearherData: Data) -> WeatherModel?{
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: wearherData)
            
            let weatherId = decodedData.weather[0].id
            let cityName = decodedData.name
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            
            let weatherModel = WeatherModel(conditionId: weatherId, cityName: cityName, weatherDescription: description, tempreature: temp)
            
            return weatherModel
            
        } catch{
            self.delegate?.didGetError(error: error)
            return nil
        }
    }
    
    
}
