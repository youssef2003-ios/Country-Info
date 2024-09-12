import Foundation

protocol CountryAPIDelegate{
    func didRetrieveCountryInfo (country: Country)
}

class CountryAPI {
    
    var delegate: CountryAPIDelegate?
    
    
    let urlBaseString = "https://restcountries.com/v3.1/name/"
    
    func fetchData(countryName: String){
        
        let urlString = "\(urlBaseString)\(countryName)"
        
        // 1.Create URL
        let url = URL(string: urlString)!
        
        // 2.Create URL Session
        let session = URLSession(configuration: .default)
        
        // 3.Create a Task
        let task = session.dataTask(with: url, completionHandler: taskHandler(data:urlResponse:error:))
        
        // 4. Start/Resume Task
        task.resume()
        
    }
    
    func taskHandler(data: Data?, urlResponse: URLResponse?, error: Error?) -> Void {
        
        do{
            
            let countries: [Country] = try JSONDecoder().decode([Country].self, from: data!)
            let firstCountry=countries[0]
            delegate?.didRetrieveCountryInfo(country: firstCountry)
            
        } catch{
            print(error)
        }
    }
    
}




