//
//  BoredModel.swift
//  Projeto-integrador-2
//
//  Created by Daniel De Andrade Souza on 08/09/22.
//

import Foundation

struct BoredModel: Codable {
    
    let activity: String
    let type: String
    var participants: Int
    let price: Double
    
    init(_ activity: String, _ type: String, _ participants: Int, _ price: Double){
        self.activity = activity
        self.type = type
        self.participants = participants
        self.price = price
    }
}
