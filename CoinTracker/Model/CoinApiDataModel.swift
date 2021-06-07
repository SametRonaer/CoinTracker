//
//  CoinApiDataModel.swift
//  CoinTracker
//
//  Created by Samet on 3.06.2021.
//

import Foundation

struct CoinApiDataModel: Codable{
    var asset_id_base:String
    var asset_id_quote:String
    var rate:Double
}
