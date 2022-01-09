//
//  ProfileLanding.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-07.
//

import SwiftUI

struct ProfileLanding: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @StateObject private var countryModel = CountryModel()
    
    var avatarURL: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("avatar.png")
    }
    
    @State private var image = UIImage(systemName: SystemIcons.person.rawValue)
    
    @State private var toggleCountry : Bool = false
    
    @State private var newsFeedSort : Bool = false
    
    @State private var toggleCategories : Bool = false
    
    @State private var toggleSources : Bool = false
    
    @State private var toggleBioEdit : Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    VStack {
                        
                        HStack {
                            if image != nil {
                                Image(uiImage: image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    //.padding()
                            } else {
                                Image(systemName: SystemIcons.person.rawValue)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    //.padding()
                            }
                            
                            
                            VStack (alignment: .leading, spacing: 10) {
                                Text(userProfile.name)
                                    .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .medium))
                                Text("@\(userProfile.username)")
                                    .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .medium))
                                
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical)
                        .onTapGesture {
                            
                            toggleBioEdit.toggle()
                        }
                        .sheet(isPresented: $toggleBioEdit, onDismiss: {
                            
                        }, content: {
                            EditBioScreen(dismiss: $toggleBioEdit)
                        })
                        
                        //MARK: Cell Outlets
                        Group {
                            ProfileSettingsCell(label: "Newsfeed", icon: .newspaper, type: .newsFeed)
                                .onTapGesture {
                                    newsFeedSort.toggle()
                                }
                                .sheet(isPresented: $newsFeedSort, onDismiss: {
                                    
                                }, content: {
                                    NewsSortConfigurationScreen(dismiss: $newsFeedSort)
                                })
                            
                            ProfileSettingsCell(label: "Sources", icon: .sources, type: .sources)
                                .onTapGesture {
                                    toggleSources.toggle()
                                    
                                }
                                .sheet(isPresented: $toggleSources, onDismiss: {
                                    
                                }, content: {
                                    ProfileSourcesScreen(dismiss: $toggleSources)
                                })
                                
                            
                            ProfileSettingsCell(label: "Categories", icon: .categories, type: .categories)
                                .onTapGesture {
                                    toggleCategories.toggle()
                                }
                                .sheet(isPresented: $toggleCategories, onDismiss: {
                                    
                                }, content: {
                                    ProfileCategoriesList(dismiss: $toggleCategories)
                                })
                                
                            
                            ProfileSettingsCell(label: "Country", icon: .globe, type: .country)
                                .onTapGesture {
                                    toggleCountry.toggle()
                                    
                                }
                                .sheet(isPresented: $toggleCountry, onDismiss: {
                                    
                                }, content: {
                                    ProfileCountrySetUp(dismiss: $toggleCountry)
                                })
                            
                        }
                        
                        
                    }
                    .padding()
                   
                    
                    
                }
                .padding(.vertical)
                
            }
            .hideNavigationBar()
            .onAppear(perform: {
                
                avatarURL.loadImage(&image)
            })
        }
        
        
    }
    
}

struct ProfileLanding_Previews: PreviewProvider {
    static var previews: some View {
        ProfileLanding().environmentObject(UserProfile()).preferredColorScheme(.dark)
    }
}

