//
//  ViewController.swift
//  Beating Heart Model
//
//  Created by Krish Kapoor on 7/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var bpm: UITextField!
    @IBOutlet weak var toggleIrregular: UISwitch!
    
    let heart_color_animation = [UIImage(named: "heart 1")!, UIImage(named: "heart 2")!, UIImage(named: "heart 3")!, UIImage(named: "heart 4")!, UIImage(named: "heart 5")!, UIImage(named: "heart 6")!, UIImage(named: "heart 7")!, UIImage(named: "heart 8")!, UIImage(named: "heart 9")!, UIImage(named: "heart 10")!]
    
    var data: [String : Any] = [
        "bpm": 0,
        "condition": "Regular"
    ]
    
    var condition = "Regular"
    var bpmVal = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        heartImage.image = UIImage(named: "heart 1")
        heartImage.animationImages = heart_color_animation
        
        sendData(bpm: 0, condition: condition)
    }
    
    @IBAction func heartButtonClicked(_ sender: Any) {
        
        if bpm.isFirstResponder && bpm.hasText {
            bpm.resignFirstResponder()
            bpmVal = Int(bpm.text!)!
            
            if (bpmVal > 0 && bpmVal <= 200) {
                if heartImage.image == UIImage(named: "heart 1") {
                    heartImage.animationDuration = 0.5
                    heartImage.animationRepeatCount = 1
                    heartImage.startAnimating()
                    heartImage.image = UIImage(named: "heart 10")
                }
                sendData(bpm: bpmVal, condition: condition)
            }
            else {
                heartImage.image = UIImage(named: "heart 1")
            }
        }
    }
    
    @IBAction func toggleIrregular(_ sender: Any) {
        if toggleIrregular.isOn {
            condition = "Irregular"
        }
        else {
            condition = "Regular"
        }
        sendData(bpm: bpmVal, condition: condition)
    }
    
    func api_post() {
        let url = URL(string: "http://192.168.1.56/heart")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if (data != nil && error == nil) {
                print(data as Any)
                print(response as Any)
            }
            else {
                print("Error:", error as Any)
            }
        }
        task.resume()
    }
    
    func sendData(bpm: Int, condition: String) {
        data["bpm"] = bpm
        data["condition"] = condition
        
        api_post()
        
        print("BPM:", bpm)
        print("Condition:", condition)
    }
}
