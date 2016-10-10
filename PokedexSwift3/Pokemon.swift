//
//  Pokemon.swift
//  PokedexSwift3
//
//  Created by Alisson Chiquitto on 09/10/16.
//  Copyright © 2016 Alisson Chiquitto. All rights reserved.
//

import UIKit

class Pokemon {
    var number:Int
    var name:String
    var typeSlot1 = 0
    var typeSlot2 = 0
    
    init(number:Int, name:String) {
        self.number = number
        self.name = name
    }
}
