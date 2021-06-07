//
//  ViewController.swift
//  CoinTracker
//
//  Created by Samet on 2.06.2021.
//

import UIKit

class ViewController: UIViewController {

    var coins = ["BTC","ETH","BNB","DOGE","LTC","USD","JPY"]
    var coinApiBrain = CoinApiBrain()
    var selectedFirstCoin:String = "BTC"
    var selectedSecondCoin:String = "USD"
    
    @IBOutlet weak var priceLabe: UILabel!
    @IBOutlet weak var firstCoinLabel: UILabel!
    @IBOutlet weak var secondCoinLabel: UILabel!
    
    
    // API Key: F4A0434C-FF68-45CC-BB1D-B73B42836ADB
    
    
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    
    
    override func viewDidLoad() {
        coinApiBrain.delegate = self
        picker.delegate = self
        picker.dataSource = self
        picker.setValue(UIColor.white, forKey: "textColor")
        picker2.delegate = self
        picker2.dataSource = self
        picker2.setValue(UIColor.white, forKey: "textColor")
        
        
        coinApiBrain.fetchPrice(firstCoin: selectedFirstCoin, secondCoin: selectedSecondCoin)
        super.viewDidLoad()
    }


}


// MARK: - Update Currency Delegate
extension ViewController:CoinApiDelegate{
    func updateCurrency(_ amount:Double) {
     
        DispatchQueue.main.async {
            self.priceLabe.text = String(format:"%.1f", amount)
        }
       
    }
}








// MARK: - PickerView Delegate and Datasource
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
   
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coins.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coins[row]
       
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if pickerView == picker{
            selectedFirstCoin = coins[row]
            firstCoinLabel.text = "1 "+coins[row]+":"
        }else{
            selectedSecondCoin = coins[row]
            secondCoinLabel.text = coins[row]
        }
 
        coinApiBrain.fetchPrice(firstCoin: selectedFirstCoin, secondCoin: selectedSecondCoin)
     
       
    }
}




