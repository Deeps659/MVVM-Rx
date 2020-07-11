//
//  APIManager.swift
//  MVVM-Rx
//
//  Created by DEEPALI MAHESHWARI on 08/01/20.
//  Copyright © 2020 Maheshwari, Deepali. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class APIManager {
    

    static let apiKey = "f4f9421f6b6a93c817dc871ca09611f5"
    public static let shared = APIManager()

   
      enum Error: Swift.Error {
        case unknownAPIResponse
        case generic
      }
      
    static func searchFlickr(for searchTerm: String, completion: @escaping (Result) -> Void) {
        
        guard let searchURL = flickrSearchURL(for: searchTerm) else {
          completion(Result.error(Error.unknownAPIResponse))
          return
        }
        
        let searchRequest = URLRequest(url: searchURL)
        
        
        URLSession.shared.dataTask(with: searchRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion(Result.error(error))
            }else if let data = data ,let responseCode = response as? HTTPURLResponse {
                do {
                    let responseJson = try JSON(data: data)
                    print("responseCode : \(responseCode.statusCode)")
                    print("responseJSON : \(responseJson)")
                    switch responseCode.statusCode {
                    case 200:
                        completion(Result.results(responseJson["photos"]))
                    default:
                        completion(Result.error(Error.generic))
                        break
                    }
                }
                catch let parseJSONError {
                    completion(Result.error(Error.unknownAPIResponse))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            }
        }.resume()
       
        
        
            
            
            
          
      }
      
      private static func flickrSearchURL(for searchTerm:String) -> URL? {
        guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
          return nil
        }
        
        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1"
        return URL(string:URLString)
      }
    
}
