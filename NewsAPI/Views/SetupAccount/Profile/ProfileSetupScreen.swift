//
//  ProfileSetupScreen.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-25.
//

import SwiftUI

struct ProfileSetupScreen: View {
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var checkEntry : Bool = false
    
    @State private var showImagePicker : Bool = false
    
    @State private var submit : Bool = false
    
    @State private var goToCompletion : Bool = false
    
    
    var body: some View {
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30) {
                
                NavigationHeader(title: "Profile Information")
                    .disabled(submit ? true : false)
                
                
                if viewModel.avatar != nil {
                    Image(uiImage: viewModel.avatar!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .modifier(ProfileAvatarModifier())
                        .onTapGesture {
                            if !submit {
                                showImagePicker.toggle()
                            }
                            
                        }
                    
                    
                } else {
                    Image(systemName: SystemIcons.person.rawValue)
                        .resizable()
                        .foregroundColor(.greyBlueMedium)
                        .background(Color.greyLBlueMedDark)
                        .frame(width: K.Dimensions.frameWidth / 3, height: K.Dimensions.frameWidth / 3)
                        .clipShape(Circle())
                        .onTapGesture {
                            showImagePicker.toggle()
                        }

                    
                }
                
                //MARK: Outlets
                Group {
                    IconTextField(icon: .person, placeHolder: "Name", text: $viewModel.name, isMandatory: true, errorMessage: "Please enter a name", checkEntry: checkEntry)
                    
                    IconTextField(icon: .username, placeHolder: "Username", text: $viewModel.username, isMandatory: true, errorMessage: "Please provide a user name", checkEntry: checkEntry)
                        .sheet(isPresented: $showImagePicker, onDismiss: {
                            
                        }, content: {
                            ImagePicker(selectedImage: $viewModel.avatar)
                        })
                        .disabled(submit ? true : false)
                }
                
                Spacer()
                
                Button(action: {
                    
                    if viewModel.avatar != nil {
                        withAnimation {
                            submit.toggle()
                        }
                    }
                    
                    
                    
                }, label: {
                    CTARed(label: "Submit")
                })
                    .disabled(submit ? true : false)
                
            }
            .padding()
            .blur(radius: submit ? 10 : 0)
            
            if submit {
                CircularLoad()
                    .onAppear(perform: {
                        
                        DispatchQueue.main.async {
                            
                            userProfile.setUserProfile(categories: viewModel.selectedCategories, sources: viewModel.selectedSources, avatar: viewModel.avatar!, username: viewModel.username, country: viewModel.selectedCountry!, name: viewModel.name)
                            
                            userProfile.isSignedIn = true
                            
                        }
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            withAnimation {
                                goToCompletion.toggle()
                            }
                            
                            
                        }
                    })
                    .fullScreenCover(isPresented: $goToCompletion, onDismiss: {
                        
                    }, content: {
                        
                        SetupCompleteScreen()
                        
                    })
            }
        }
        .hideNavigationBar()
        .environmentObject(userProfile)
    }
}

struct ProfileSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetupScreen(viewModel: AccountSetupViewModel())
    }
}

struct ProfileAvatarModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: K.Dimensions.frameWidth / 3, height: K.Dimensions.frameWidth / 3)
            .clipShape(Circle())
            .overlay(Circle().stroke(lineWidth: 4).foregroundColor(.cRed))
        
    }
}
