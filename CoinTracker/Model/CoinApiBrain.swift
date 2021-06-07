//
//  CoinApiBrain.swift
//  CoinTracker
//
//  Created by Samet on 3.06.2021.
//

import Foundation

struct CoinApiBrain {
    
    var urlFirstPart:String = "https://rest.coinapi.io/v1/exchangerate/"
    var urlSecondPart:String = "?apikey=F4A0434C-FF68-45CC-BB1D-B73B42836ADB"
    var delegate:CoinApiDelegate?
    
    func fetchPrice(firstCoin:String, secondCoin:String){
        let combineUrl:String = urlFirstPart+firstCoin+"/"+secondCoin+urlSecondPart
        performRequest(urlAdress: combineUrl)
    }
    
    func performRequest(urlAdress:String){
        if let url = URL(string: urlAdress){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                if let safeData = data{
                    if let currentPrice = parseJson(safeData){
                        delegate?.updateCurrency(currentPrice.price)
                    }
                }
            }
            task.resume()
            
        }
    }
    
    func parseJson(_ passedData:Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(CoinApiDataModel.self, from: passedData)
            let apiPrice = decodeData.rate
            let apiFirstCurrency = decodeData.asset_id_base
            let apiSecondCurrency = decodeData.asset_id_quote
            
            print(apiPrice)
            let currentPrice = CoinModel(firstCurrency: apiFirstCurrency, secondCurrency: apiSecondCurrency, price: apiPrice)
            return currentPrice
        }catch{
            return nil
        }
    }
    
}


// MARK: - CoinApiDelegate
protocol CoinApiDelegate {
    func updateCurrency(_ amount:Double)
}
