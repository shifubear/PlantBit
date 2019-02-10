//
//  DataModel.swift
//  PlantBit
//
//  Created by Shion Fukuzawa on 2/9/19.
//  Copyright © 2019 Shion Fukuzawa. All rights reserved.
//

import Foundation

class DataModel {
    public var exception = 0
    public var plant_health : PlantHealth
    public var schedule : Schedule
    init() {
        plant_health = PlantHealth()
        schedule = Schedule()
    }
}

class PlantHealth {
    public var soil_health = 0
    init() {
        soil_health = 0
    }
}

class Schedule {
    public var on = [0, 0]
    public var off = [0, 0]
    init() {
        on = [0,0]
        off = [0,0]
    }
}
