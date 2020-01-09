//
//  Photos.swift
//  MVVM-Rx
//
//  Created by DEEPALI MAHESHWARI on 09/01/20.
//  Copyright © 2020 Maheshwari, Deepali. All rights reserved.
//

import Foundation

struct Photos: Codable {
    
    let photo: [FlickrPhoto]
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case photo
        case stat
    }
}

extension Photos {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Photos.self, from: data)
            self = me
        }
        catch {
            print(error)
            return nil
        }
    }
}
