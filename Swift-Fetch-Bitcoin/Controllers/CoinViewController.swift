//
//  CoinViewController.swift
//  Swift-Fetch-Bitcoin
//
//  Created by Bahittin on 12.07.2023.
//

import UIKit

class CoinViewController: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
        
        coinManager.delegate = self
        
        // Do any additional setup after loading the view.
    }
   

}
//MARK: - UIPickerViewDelegate
extension CoinViewController : UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("deneme")
        let selectedCoin = coinManager.currencyArray[row]
        let returnRate = coinManager.getCoinPrice(for: selectedCoin)
        
    }
}
//MARK: - CoinManagerDelegate
extension CoinViewController: CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

