//
//  ProductTourScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import SwiftUI

struct ProductTourScreen: View {
    
    @StateObject var viewModel = ProductTourViewModel()
    
    @State var goToSignInOptions : Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                        Image(AppAssets.SplashScreen.text)
                    
                    Spacer()
                    Text("Skip")
                        .modifier(FontModifier(color: .cBlueMedium, size: .label, type: .medium))
                        .padding()
                        .onTapGesture {
                            goToSignInOptions.toggle()
                            
                        }
                        .fullScreenCover(isPresented: $goToSignInOptions, onDismiss: {
                            
                        }, content: {
                            LoginOptionScreen(dismiss: $goToSignInOptions)
                        })
                }
                .padding(.bottom)
                
                ZStack {
                    Image(viewModel.highlightedImage)
                        .resizable()
                    .cornerRadius(30)
                    
                    VStack  {
                        
                        Spacer()
                        
                        Group {
                            if viewModel.index == 1 {
                                    TourMessage0()
                            }
                            
                            if viewModel.index == 2 {
                                    TourMessage1()
                            }
                            
                            if viewModel.index == 3 {
                                    TourMessage2()
                            }
                            
                        }
                        
                        
                        ProgressBar(index: viewModel.index)
                        
                        Button(action: {
                            
                            withAnimation  (.easeIn(duration: 0.4)) {
                                
                                viewModel.changeIndex()
                            }
                            
                        }, label: {
                            CTA(label: viewModel.buttonLabel)
                                .frame(width: K.Dimensions.frameWidth / 2)
                        })
                            
                            
                    }
                    .padding(.bottom)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ProductTourScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductTourScreen()
    }
}


fileprivate struct TourMessage0: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Get the latest news from ")
                    .modifier(FontModifier(color: .cWhite, size: .h1, type: .bold))
                Text("reliable sources")
                    .modifier(FontModifier(color: .cRed, size: .h1, type: .bold))
            }
            Spacer()
        }
        .frame(maxWidth: K.Dimensions.frameWidth * 0.75)
    }
}

fileprivate struct TourMessage1: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Up to date ")
                    .modifier(FontModifier(color: .cRed, size: .h1, type: .bold))
                Text("news from all around the world")
                    .modifier(FontModifier(color: .cWhite, size: .h1, type: .bold))
            }
            
            Spacer()
        }
        .frame(maxWidth: K.Dimensions.frameWidth * 0.75)
    }
}

fileprivate struct TourMessage2: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("From art to politics,")
                    .modifier(FontModifier(color: .cWhite, size: .h1, type: .bold))
                Text("all News")
                    .modifier(FontModifier(color: .cRed, size: .h1, type: .bold))
            }
            
            Spacer()
        }
        .frame(width: K.Dimensions.frameWidth * 0.75)
    }
}

fileprivate struct ProgressBar: View {
    
    var index : Int
    
    var body: some View {
        ZStack {
            Color.cWhite.opacity(0.4)
                .frame(width: K.Dimensions.frameWidth * 0.3)
            HStack {
                Color.cRed
                    .frame(width: K.Dimensions.frameWidth * CGFloat((Double(index) * 0.1)))
                    .cornerRadius(5)
                
                
                if index < 3 {
                    Spacer()
                }
                
            }
            
        }
        .frame(width: K.Dimensions.frameWidth * 0.3)
        .frame(height: 5)
        .cornerRadius(5)
        .padding(.vertical, 35)
    }
}
