//
//  Extensions.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-09.
//

import Foundation
import SwiftUI

extension URL {
    
    func loadImage(_ image: inout UIImage?) {
            if let data = try? Data(contentsOf: self), let loaded = UIImage(data: data) {
                image = loaded
            } else {
                image = nil
            }
        }
    
}

