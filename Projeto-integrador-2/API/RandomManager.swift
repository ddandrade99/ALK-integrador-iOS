//
//  APIManager.swift
//  Projeto-integrador-2
//
//  Created by Daniel De Andrade Souza on 08/09/22.
//

import Foundation


protocol BoredManagerDelegate {
    func updateModel(_ boredManager: BoredManager, bored: BoredModel)
    func didFailWithError(error: Error)
}

struct BoredManager {
    let boredRandomURL = "http://www.boredapi.com/api/activity?participants="
    let boredTypedURL1 = "http://www.boredapi.com/api/activity?type="
    let boredTypedURL2 = "&participants="
    
    var delegate: BoredManagerDelegate?

    func fetchBored(_ participants: Int, _ type: String = "nil") {
        var newURL = ""
        if type == "nil"{
            newURL = boredRandomURL+String(participants)
        } else {
            newURL = boredTypedURL1+type+boredTypedURL2+String(participants)
        }
        
        if let url = URL(string: newURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let model = self.parseJSON(safeData) {
                        self.delegate?.updateModel(self, bored: model)
                    }
                }
            }
            task.resume()
        }
    }

//    func performRequest(with urlString: String) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                    return
//                }
//                if let safeData = data {
//                    if let model = self.parseJSON(safeData) {
//                        self.delegate?.updateModel(self, bored: model)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }

    func parseJSON(_ boredData: Data) -> BoredModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BoredModel.self, from: boredData)
            let activity = decodedData.activity
            let type = decodedData.type
            let participants = decodedData.participants
            let price = decodedData.price
            let bored = BoredModel(activity, type, participants, price)
            return bored
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


