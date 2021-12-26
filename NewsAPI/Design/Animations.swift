//
//  Animations.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import SwiftUI

struct Animations: View {
    var body: some View {
        CircularLoad()
    }
}

struct Animations_Previews: PreviewProvider {
    static var previews: some View {
        Animations()
    }
}

struct PulsatingLoad : View {
    
    @Binding var wave : Bool
    //var image : UIImage
    
    var body: some View {
        ZStack {
            Color.cBlueMedium
                .frame(width: K.Dimensions.frameWidth / 3, height: K.Dimensions.frameWidth / 3)
                .clipShape(Circle())
                .scaleEffect(wave ? 2 : 1)
                .opacity(wave ? 0.1 : 1)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).speed(0.8))
                .onAppear() {
                    self.wave.toggle()
                }
//            Image(uiImage: image)
//             .resizable()
//             .foregroundColor(.cGreyMedium)
//             .background(Color.cBlueMedium)
//             .frame(width: K.Dimensions.frameWidth / 3, height: K.Dimensions.frameWidth / 3)
//                       .clipShape(Circle())
        }
    }
}

struct CircularLoad : View {
    
    @State var degrees = 0.0
    
    var body: some View {
        VStack {
            
            Spacer()
            Circle()
                .trim(from: 0.0, to: 0.6)
                .stroke(Color.cRed, lineWidth: 5.0)
                .frame(width: K.Dimensions.frameWidth * 0.25, height: 40)
                .rotationEffect(Angle(degrees: degrees))
                .onAppear {
                    self.start()
                }
            Spacer()
            
        }
    }
    
    func start() {
            _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                withAnimation {
                    self.degrees += 10.0
                }
                if self.degrees == 360.0 {
                    self.degrees = 0.0
                }
            }
        }


}
