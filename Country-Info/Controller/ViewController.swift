import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate=self
        countryAPI.delegate=self
        locationManeger.delegate=self
    }

    var countryAPI = CountryAPI()
    
    var locationManeger = CLLocationManager()
    var geoCoder = CLGeocoder()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        updateUI()
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
   
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.requestAlwaysAuthorization()
        locationManeger.requestLocation()
    }
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
   
    func updateUI(){
        countryAPI.fetchData(countryName: searchTextField.text!)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateUI()
        return true
    }
}

extension ViewController: CountryAPIDelegate{
   
    func didRetrieveCountryInfo(country: Country) {
      
        DispatchQueue.main.async {
            self.countryLabel.text=country.name?.common
            self.capitalLabel.text=country.capital?.first
            self.regionLabel.text=country.region
            self.populationLabel.text=String((country.population!))
           
        }
    }
    
    
}

extension ViewController: CLLocationManagerDelegate{
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        let location = locations.last
        geoCoder.reverseGeocodeLocation(location!) { places, error in
            let cName = places?.last?.country
            self.countryAPI.fetchData(countryName: cName!)

        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

