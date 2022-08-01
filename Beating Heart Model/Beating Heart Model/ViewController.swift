//
//  ViewController.swift
//  Beating Heart Model
//
//  Created by Krish Kapoor on 7/12/22.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var bpm: UITextField!
    @IBOutlet weak var toggleIrregular: UISwitch!
    @IBOutlet weak var slider: UISlider!
    
    let heart_color_animation = [UIImage(named: "heart 1")!, UIImage(named: "heart 2")!, UIImage(named: "heart 3")!, UIImage(named: "heart 4")!, UIImage(named: "heart 5")!, UIImage(named: "heart 6")!, UIImage(named: "heart 7")!, UIImage(named: "heart 8")!, UIImage(named: "heart 9")!, UIImage(named: "heart 10")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heartImage.image = UIImage(named: "heart 1")
        heartImage.animationImages = heart_color_animation
        
        setDataInt(NAME: "bpm", VAL: 0)
        setDataStr(NAME: "condition", VAL: "Regular")
    }
    
    func setDataInt(NAME: String, VAL: Int) {
        let ref: DatabaseReference! = Database.database().reference()
        ref.child(NAME).setValue(VAL)
    }
    func setDataStr(NAME: String, VAL: String) {
        let ref: DatabaseReference! = Database.database().reference()
        ref.child(NAME).setValue(VAL)
    }
    
    @IBAction func sliderUsed(_ sender: Any) {
        
        var bpmVal: Int = Int(bpm.text ?? "0") ?? 0
        bpmVal = Int(slider.value)
        bpm.text = "\(bpmVal)"
        
        if (bpmVal > 0 && bpmVal <= 200) {
            if heartImage.image == UIImage(named: "heart 1") {
                heartImage.animationDuration = 0.5
                heartImage.animationRepeatCount = 1
                heartImage.startAnimating()
                heartImage.image = UIImage(named: "heart 10")
            }
            setDataInt(NAME: "bpm", VAL: bpmVal)
        }
        else {
            heartImage.image = UIImage(named: "heart 1")
        }
    }
    
    @IBAction func heartButtonClicked(_ sender: Any) {
        if bpm.isFirstResponder && bpm.hasText {
            bpm.resignFirstResponder()
            let bpmVal: Int = Int(bpm.text!)!
            slider.value = Float(bpmVal)
            
            if (bpmVal > 0 && bpmVal <= 200) {
                if heartImage.image == UIImage(named: "heart 1") {
                    heartImage.animationDuration = 0.5
                    heartImage.animationRepeatCount = 1
                    heartImage.startAnimating()
                    heartImage.image = UIImage(named: "heart 10")
                }
                setDataInt(NAME: "bpm", VAL: bpmVal)
            }
            else {
                heartImage.image = UIImage(named: "heart 1")
            }
        }
    }
    
    @IBAction func toggleIrregular(_ sender: Any) {
        if toggleIrregular.isOn {
            setDataStr(NAME: "condition", VAL: "Irregular")
        }
        else {
            setDataStr(NAME: "condition", VAL: "Regular")
        }
    }
    
}
