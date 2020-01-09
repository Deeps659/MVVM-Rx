//
//  Result.swift
//  MVVM-Rx
//
//  Created by DEEPALI MAHESHWARI on 08/01/20.
//  Copyright © 2020 Maheshwari, Deepali. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Result {
  case results(JSON)
  case error(Error)
}
