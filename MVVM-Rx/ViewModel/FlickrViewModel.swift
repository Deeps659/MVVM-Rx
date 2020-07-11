//
//  FlickrViewModel.swift
//  MVVM-Rx
//
//  Created by DEEPALI MAHESHWARI on 08/01/20.
//  Copyright © 2020 Maheshwari, Deepali. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class FlickrViewModel {
    
    private let apiManager: APIManager
    private let disposeBag = DisposeBag()
    
    
    init(query: Driver<String>, apiManager: APIManager) {
        self.apiManager = apiManager
        query.drive(onNext: { [weak self] (query) in
                print(query)
                self?.requestData(for: query)
        }).disposed(by: disposeBag)
    }
    
    private let _flickrPhotos = BehaviorRelay<[FlickrPhoto]>(value: [])
   // private let _isFetching = BehaviorRelay<Bool>(value: false)
    //private let _error = BehaviorRelay<String?>(value: nil)
    
//    var isFetching: Driver<Bool> {
//        return _isFetching.asDriver()
//    }
    
    var flickrPhotos: Driver<[FlickrPhoto]> {
        return _flickrPhotos.asDriver()
    }
    
//    var error: Driver<String?> {
//        return _error.asDriver()
//    }
    
    public func requestData(for str : String){
        _flickrPhotos.accept([])
        //self.loading.onNext(true)
        APIManager.searchFlickr(for: str) { [weak self] searchResults in
            switch searchResults {
                case .error(let error) :
                  print("Error Searching: \(error)")
                case .results(let results):
                    let photos = results["photo"].arrayValue.compactMap {return FlickrPhoto(data: try! $0.rawData())}
                    self?._flickrPhotos.accept(photos)
                
            }
        
        }
    
    }

}
