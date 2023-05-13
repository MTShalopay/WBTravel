//
//  DownLoadManager.swift
//  WBTravel
//
//  Created by Shalopay on 12.05.2023.
//

import Foundation
class DownLoadManager {
    let urlString = "https://vmeste.wildberries.ru/api/avia-service/twirp/aviaapijsonrpcv1.WebAviaService/GetCheap"
    
    func getTravel(comletion: ((Travel?) -> Void)?) {
        guard let urlRequest = URL(string: urlString) else {
            print("Невозможно получить данные по \(urlString)")
            return
        }
        var request = URLRequest(url: urlRequest)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters = ["startLocationCode":"LED"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR dataTask: \(error.localizedDescription)")
                comletion?(nil)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if statusCode != 200 {
                print("ERROR StatusCode: \(String(describing: statusCode)) \n")
                comletion?(nil)
                return
            }
            guard let data = data else {return print("OPS")}
            do {
                let result = try JSONDecoder().decode(Travel.self, from: data)
//                print(result)
                comletion?(result)
            } catch {
                print("ERROR data: \(error)")
                comletion?(nil)
            }
        }
        dataTask.resume()
    }
}
