//
//  DataTaskManager.swift
//  ImageRenderer
//
//  Created by Taral Rathod on 04/10/20.
//

import Foundation

struct DataTaskManager {
    func executeRequest(For url: URL, completion: @escaping (_ model: DataModel?, _ error: Error? ) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                guard let data = data else {print("No Data"); return}
                do {
                    let decoder = JSONDecoder()
                    let dataModel = try decoder.decode(DataModel.self, from: data)
                    print(dataModel)
                    completion(dataModel, nil)
                } catch {
                    print(error)
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        })
        task.resume()
    }
}
