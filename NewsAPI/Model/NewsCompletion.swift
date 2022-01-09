//
//  NewsCompletion.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-09.
//

import Foundation
import Combine

struct NewsCompletion {
    var success : Bool
    var error : ErrorModel?
}

typealias NewsCompletionResponse = NewsCompletion

