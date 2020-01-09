//
//  FlickrViewModel.swift
//  MVVM-Rx
//
//  Created by DEEPALI MAHESHWARI on 08/01/20.
//  Copyright © 2020 Maheshwari, Deepali. All rights reserved.
//

import Foundation

class FlickrViewModel {
    
    public func requestData(for str : String){
        
        //self.loading.onNext(true)
        APIManager.searchFlickr(for: str) { searchResults in
            switch searchResults {
                case .error(let error) :
                  print("Error Searching: \(error)")
                case .results(let results):
                    let photos = results["photo"].arrayValue.compactMap {return FlickrPhoto(data: try! $0.rawData())}
                
            }
        
        }
    
    }

}
