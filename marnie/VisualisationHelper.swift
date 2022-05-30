//
//  VisualisationHelper.swift
//  marnie
//
//  Created by Daniya on 31/05/2022.
//

import Foundation

struct GoogleResponse: Decodable {
    let items: [ImageItem]
}

struct ImageItem: Decodable {
    let link: String
    let image: ImageDict
}

struct ImageDict: Decodable {
    let thumbnailLink: String
}

struct GenericError: Error {
    
    enum ErrorType {
        case urlInitialization
        case response
        case dataInitialize
        case decodable
    }
    
    let type: ErrorType
    let description: String
}


class VisualizerHelper: NSObject {
    
    static let shared = VisualizerHelper()
    
    typealias ImageItemHandler = (GoogleResponse?,GenericError?) -> ()
    
    func requestImagesFromGoogle(querry: String, handler: @escaping ImageItemHandler ) {
        
        let apiKey = "AIzaSyCvE3uKIcCwAfJzJ-268weZvVWjF5f_fyU"
        let searchEngineId = "017099167182805412267:f-ibulgyu30"
        let serverAddress = String(format: "https://www.googleapis.com/customsearch/v1?q=%@&cx=%@&key=%@&searchType=image&safe=active&imgSize=xlarge",querry ,searchEngineId, apiKey)
        
        
        let url = serverAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let finalUrl = URL(string: url!)
        let request = NSMutableURLRequest(url: finalUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            do{
                
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print("asyncResult\(jsonResult)")
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode >= 400 {
                    let statusMsg = String(describing: type(of: self)) + "response error: status code \(response.statusCode)"
                    handler(nil, GenericError(type: .response, description: statusMsg))
                    return
                }
                
                guard let data = data else {
                    let statusMsg = String(describing: type(of: self)) + " couldn't initialize data"
                    handler(nil, GenericError(type: .dataInitialize, description: statusMsg))
                    return
                }
                
                do {
                    let json = try JSONDecoder().decode(GoogleResponse.self, from: data)
                    // store the most recent data for offline access
                    handler(json, nil)
                    
                } catch {
                    handler(nil, GenericError(type: .decodable, description: error.localizedDescription ))
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
            
            }.resume()
    }
    
}

