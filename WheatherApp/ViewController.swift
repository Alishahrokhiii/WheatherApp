//
//  ViewController.swift
//  WheatherApp
//
//  Created by Seyed Ali Shahrokhi on 1/13/1399 AP.
//  Copyright © 1399 Seyed Ali Shahrokhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LocationLable: UILabel!
    @IBOutlet weak var DayLable: UILabel!
    @IBOutlet weak var ConditionImageView: UIImageView!
    @IBOutlet weak var ConditionLable: UILabel!
    @IBOutlet weak var ImageLable: UILabel!
    @IBOutlet weak var backgroundView: UIView!
        
      let apiKey = "e6057df6d4ee3afb8ec812e780d488b4"
    var lat = 33.487782
    var lon = 48.355831
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Khorramabad,state,IR&units=metric&appid=\(apiKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, erorr) in
            if let data = data, erorr == nil {
            
            do {
                
            
               guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)as? [String : Any] else {return}
                
               guard let weatherDetails = dictionary["weather"]as? [[String : Any]],
                     let weatherMain = dictionary["main"] as? [String : Any] else {return}
                
                
                let CityName = dictionary["name"]
                let discription = (weatherDetails.first?["description"] as? String)
                let Temp = weatherMain["temp"] as? Double
                let temp = Int(Temp!)
                
 
                DispatchQueue.main.async {
                    self.LocationLable.text = (CityName as! String)
                    self.ConditionLable.text = (discription)
                    self.ImageLable.text = (String(temp))
                }
             
                    
              
            } catch {
                print("we had an erorr retriving data")
                
                
            }
        }
        }
        task.resume()
      
        
        
    }


}

