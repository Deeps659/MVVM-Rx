//
//  Result.swift
//  MVVM-Rx
//
//  Created by DEEPALI MAHESHWARI on 08/01/20.
//  Copyright © 2020 Maheshwari, Deepali. All rights reserved.
//

import Foundation

enum Result<ResultType> {
  case results(ResultType)
  case error(Error)
}
