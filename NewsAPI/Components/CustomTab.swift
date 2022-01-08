//
//  CustomTab.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-27.
//

import SwiftUI

struct CustomTab: View {
    
    @State private var tabSelection : TabSelectors = .home
    
    var body: some View {
        
        ZStack {
            
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                CustomTabBar(selection: $tabSelection)
            }
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct CustomTab_Previews: PreviewProvider {
    static var previews: some View {
        CustomTab().preferredColorScheme(.dark).environmentObject(UserProfile())
    }
}

struct CustomTabBar: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @Binding var selection : TabSelectors
    
    var avatarURL: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("avatar.png")
    }
    
    
    @State private var image = UIImage(systemName: SystemIcons.person.rawValue)
    
    var body: some View {
        
        HStack (spacing: 20) {
            Image(systemName: SystemIcons.home.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(selection == .home ? .cRed : .darkGreySoft)
                .padding()
                .onTapGesture {
                    withAnimation {
                        selection = .home
                    }
                }
            //Spacer()
            Image(systemName: SystemIcons.search.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(selection == .search ? .cRed : .darkGreySoft)
                .padding()
                .onTapGesture {
                    withAnimation {
                        selection = .search
                    }
                }
            //Spacer()
            Image(systemName: SystemIcons.bookmark.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(selection == .bookmark ? .cRed : .darkGreySoft)
                .padding()
                .onTapGesture {
                    withAnimation {
                        selection = .bookmark
                    }
                }
            //Spacer()
            ZStack {
                if userProfile.isSignedIn {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(lineWidth: 2).foregroundColor(selection == .person ? .cRed : .clear))
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                selection = .person
                            }
                        }
                    
                } else {
                    Image(systemName: SystemIcons.person.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(selection == .person ? .cRed : .darkGreySoft)
                    
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                selection = .person
                            }
                        }
                    
                }
            }
            
        }
        .onAppear(perform: {
            avatarURL.loadImage(&image)
        })
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        //.padding()
        
        .padding(.bottom, 30)
        .background(Color.whiteBlueDark.opacity(0.1))
        .background(VisualEffectBlur(blurStyle: .regular))
        
    }
}

enum TabSelectors {
    case home
    case search
    case bookmark
    case person
}
