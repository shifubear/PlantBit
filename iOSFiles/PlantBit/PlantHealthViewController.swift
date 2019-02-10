//
//  PlantHealthViewController.swift
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

class PlantHealthViewController: UIViewController {
    
    var ref: DatabaseReference!
    var counter: Int
    
    required init?(coder aDecoder: NSCoder) {
        counter = 0
        super.init(coder: aDecoder)
    }

    @IBOutlet weak var SoilMoistureLevel: UILabel!
    
    @IBAction func lightSwitch(_ sender: Any) {
        if(counter % 2 == 0) {
            self.ref.child("power").setValue(["on" : 1])
        } else {
            self.ref.child("power").setValue(["on" : 0])
        }
        counter += 1
    }
    override func viewDidLoad() {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? [String:Any] {
                //Do not cast print it directly may be score is Int not string
                var s = userDict["plant_health"] as? String
                print(s?.westernArabicNumeralsOnly)
                print(userDict["plant_health"])
            }
        })
        super.viewDidLoad()
        //updateData()
    }
    
}

extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .flatMap { pattern ~= $0 ? Character($0) : nil })
    }
}
