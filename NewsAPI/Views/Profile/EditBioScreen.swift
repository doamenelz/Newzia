//
//  EditBioScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-09.
//

import SwiftUI

struct EditBioScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var checkEntry : Bool = false
    
    @State private var showImagePicker : Bool = false
    
    @State private var image = UIImage(systemName: SystemIcons.person.rawValue)
    
    @State private var name : String = ""
    
    @State private var username : String = ""
    
    @Binding var dismiss : Bool
    
    var avatarURL: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("avatar.png")
    }
    
    var body: some View {
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30) {
                
                NavigationHeader(title: "Profile Information")
                
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .modifier(ProfileAvatarModifier())
                        .onTapGesture {
                            showImagePicker.toggle()
                            
                        }
                } else {
                    Image(systemName: SystemIcons.person.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .modifier(ProfileAvatarModifier())
                        .onTapGesture {
                            showImagePicker.toggle()
                            
                        }
                }
                
                IconTextField(icon: .person, placeHolder: "Name", text: $name, isMandatory: true, errorMessage: "Please enter a name", checkEntry: checkEntry)
                
                IconTextField(icon: .username, placeHolder: "Username", text: $username, isMandatory: true, errorMessage: "Please provide a user name", checkEntry: checkEntry)
                    .sheet(isPresented: $showImagePicker, onDismiss: {
                        
                    }, content: {
                        ImagePicker(selectedImage: $image)
                    })
                
                Spacer()
                
                Button(action: {
                    
                    DispatchQueue.main.async {
                        
                        userProfile.username = username
                        userProfile.name = name
                        userProfile.persistAvatar()
                        dismiss.toggle()
                        
                    }
                    
                    
                    
                }, label: {
                    CTARed(label: "Update")
                })
                    .disabled((name == "" || username == "") ? true : false )
                
            }
            .padding()
            
        }
        .onAppear(perform: {
            username = userProfile.username
            name = userProfile.name
            avatarURL.loadImage(&image)
        })

        .hideNavigationBar()
        .environmentObject(userProfile)
    }
}

struct EditBioScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditBioScreen(dismiss: .constant(false))
    }
}
