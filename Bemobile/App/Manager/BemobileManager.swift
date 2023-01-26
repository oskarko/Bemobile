//
//  BemobileManager.swift
//  Bemobile
//
//  Created by Guadalupe Morales carmona on 26/1/23.
//

import Foundation

protocol BemobileManagerDelegate {
    
    func didUpdateInfo(info: [BemobileModel])
    func didUpdateRate(info: [RateModel])
}
class BemobileManager {
    let bemobileURL: String = "https://android-ios-service.herokuapp.com/transactions"
    let rateURL: String = "https://android-ios-service.herokuapp.com/rates"
    var delegate: BemobileManagerDelegate?
    
    func fetchInfo() {
        
        performRequest(with: bemobileURL)
   
    }
    func fetchRate(){
        performRequest(with: rateURL)
    }
    
    private func performRequest(with urlString: String){
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error:")
                } else {
                    
                    if let safeData = data {
                        if urlString == self.bemobileURL {
                            if let info = self.parseJSON(bemobileData: safeData) {
                                DispatchQueue.main.async {
                                    self.delegate?.didUpdateInfo(info: info)
                                    print(info)
                                     }
                             
                            }
                        } else {
                            if let info = self.parseJSONRate(bemobileData: safeData) {
                                self.delegate?.didUpdateRate(info: info)
                                print("rate: ", info)
                            }
                        }
                    }
                }
                
            }
            task.resume()
        }
    }
    private func parseJSON(bemobileData: Data) -> [BemobileModel]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode([BemobileModel].self, from: bemobileData)
            let info = decodeData.map{
                BemobileModel(sku: $0.sku, amount: $0.amount, currency: $0.currency)
            }
           return info
            
        } catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
    private func parseJSONRate(bemobileData: Data) -> [RateModel]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode([RateModel].self, from: bemobileData)
            let info = decodeData.map{
                RateModel(from: $0.from, to: $0.to, rate: $0.rate)
            }
           return info
            
        } catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
}
