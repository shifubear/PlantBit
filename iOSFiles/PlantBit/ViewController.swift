//
//  ViewController.swift
//  PlantBit
//
//  Created by Shion Fukuzawa on 2/9/19.
//  Copyright © 2019 Shion Fukuzawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import CoreFoundation

struct PlantBitModel : Codable {
    struct Exception : Codable {
        var exception : Int
    }
    struct Plant_Health :Codable {
        var soil_moisture : Int
    }

    var exception : Exception
    var plant_health : Plant_Health
    
}


class ViewController: UIViewController {

    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    var model:PlantBitModel?
    var onTimeUnix:time_t
    var offTimeUnix:time_t
    var nowTimeUnix:time_t
    @IBOutlet weak var onTimeWheel: UIDatePicker!
    @IBOutlet weak var offTimeWheel: UIDatePicker!
    
    @IBOutlet weak var onTimeLabel: UILabel!
    @IBOutlet weak var offTimeLabel: UILabel!
    @IBAction func SetOnTimer(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strdate = dateFormatter.string(from: onTimeWheel.date)
        onTimeUnix = time_t(onTimeWheel.date.timeIntervalSince1970)
        onTimeLabel.text = String(onTimeUnix)
    }
    @IBAction func SetOffTimer(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strdate = dateFormatter.string(from: offTimeWheel.date)
        offTimeUnix = time_t(offTimeWheel.date.timeIntervalSince1970)
        offTimeLabel.text = String(offTimeUnix)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.onTimeUnix = 0
        self.offTimeUnix = 0
        self.nowTimeUnix = 0
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        nowTimeUnix = Int(NSDate().timeIntervalSince1970 - 5 * 86400)

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? [String:Any] {
                //Do not cast print it directly may be score is Int not string
                print(userDict["plant_health"])
            }
        })
        //updateData()
    }
    
    func updateDatabase() {
        if (lightstatus()) {
            self.ref.child("power").setValue(["on" : 1])
        } else {
            self.ref.child("power").setValue(["off" : 0])
        }
    }
    
    func lightstatus() -> Bool {
        if (onTimeUnix > offTimeUnix && offTimeUnix > nowTimeUnix) {
            return true
        } else if (offTimeUnix > onTimeUnix && onTimeUnix > nowTimeUnix) {
            return false
        } else {
            return true
        }
    }

//    func updateData() {
//        ref = Database.database().reference()
//        ref.child("exception").observeSingleEvent(of: .value, with: { (snapshot) in
//            let value = snapshot.value as? NSDictionary
//            let exception = value?["exception"] as? Int ?? 0
//            print(value!)
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//
//    }
//    func updateData() {
//        ref = Database.database().reference()
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let userDict = snapshot.value as? [String:Any] {
//                //Do not cast print it directly may be score is Int not string
//
//                let jsonEncoder = JSONEncoder()
//                let jsonData = try jsonEncoder.encode(userDict)
//
//                print(jsonData)
//
//
//            }
//        })
//    }

    @IBAction func setExceptionZero(_ sender: Any) {
        self.ref.child("exception").setValue(["exception" : 0])
    }
    @IBAction func setExceptionOne(_ sender: Any) {
        self.ref.child("exception").setValue(["exception" : 1])
    }
    @IBAction func setExceptionTwo(_ sender: Any) {
        self.ref.child("exception").setValue(["exception" : 2])
    }
    
        
}

