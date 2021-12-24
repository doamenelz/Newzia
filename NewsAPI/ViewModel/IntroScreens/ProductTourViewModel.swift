//
//  ProductTourViewModel.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import Foundation
import SwiftUI

class ProductTourViewModel : ObservableObject {
    
    @Published var index : Int = 1
    
    @Published var highlightedImage : String = AppAssets.SplashScreen.productTour1
    
    @Published var buttonLabel : String = "Next"
    
    
    func changeIndex () {
        
        if index < 3 {
            index += 1
        }
        
        
        switch index {
            case 1:
                highlightedImage = AppAssets.SplashScreen.productTour1
                buttonLabel = "Next"
            case 2:
                highlightedImage = AppAssets.SplashScreen.productTour2
                buttonLabel = "Next"
            case 3:
                buttonLabel = "Sign In"
                highlightedImage = AppAssets.SplashScreen.productTour3
                
            default:
                highlightedImage = AppAssets.SplashScreen.productTour1
                buttonLabel = "Next"
        }
    }
    
}


