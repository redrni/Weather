//
//  detailVC.swift
//  Weather
//
//  Created by Наталья Карпова on 15.10.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class detailVC: UIViewController {
    
    @IBOutlet weak var viewWeather: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temp_c: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var country: UILabel!
    var cityName = ""
    var CityNameLabel = "cityName"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWeather.layer.cornerRadius = 10.0
        
        // Do any additional setup after loading the view.
        
        let colorTop = UIColor(red: 89/255, green: 156/255, blue: 169/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func currentWeather(city: String) {
        let url = "http://api.weatherapi.com/v1/current.json?key=b25254773cc4458082b132129220810&q=\(city)"
        
        AF.request(url, method: .get).validate().response { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value!)
                let name = json["location"]["name"].stringValue
                let temp = json["current"]["temp_c"].doubleValue
                let country = json["location"]["country"].stringValue
                let weatherURLString = "http:\(json["location"][0]["icon"].stringValue)"
                
                self.cityNameLabel.text = name
                self.temp_c.text = String(temp)
                self.country.text = country
                
                let weatherURL = URL(string: weatherURLString)
                if let data = try? Data(contentsOf: weatherURL!) {
                    self.imageWeather.image = UIImage(data: data)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
