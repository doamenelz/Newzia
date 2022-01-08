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

struct ProfileSourcesScreen: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var searchedText : String = ""
    
    @State private var isLoading : Bool = false
    
    @State private var toggleAddSources : Bool = false
    
    @State private var showFollowing : Bool = true
    
    @State private var sources = [Source]()
    
    @Binding var dismiss : Bool
    
    var body: some View {
        
        NavigationView {
          
            ZStack {
                
                Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading) {
                    NavigationHeaderSheetStyle(dismiss: $dismiss)
                        .padding(.horizontal)
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Sources")
                                .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                            Text("\(userProfile.sources.count) Following")
                                .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
                        }
                        
                        Spacer()

                    }
                    .padding(.horizontal)
                .padding(.bottom, 10)
                    
                    IconTextField(icon: .search, placeHolder: "Search for sources", text: $searchedText, isMandatory: false, errorMessage: "", checkEntry: false).padding(.horizontal)
                    
                    HStack (spacing: 10) {
                        
                        FilterTab(label: "Following", isSelected: showFollowing)
                            .onTapGesture {
                                showFollowing.toggle()
                                sources = sortBy().sorted(by: {$0.name < $1.name})
                                
                            }
                        
                        FilterTab(label: "Not Following", isSelected: !showFollowing)
                            .onTapGesture {
                                showFollowing.toggle()
                                sources = sortBy().sorted(by: {$0.name < $1.name})
                            }
                        
                        Spacer()
                    }
                    .padding([.leading, .top])
                    
                    
                    ScrollView {
                        LazyVStack (spacing: 20) {
                            
                            ForEach(searchedText == "" ? sources : sources.filter({$0.name.uppercased().contains( searchedText.uppercased())}), id: \.self) { source in
                                
                                NavigationLink(destination: {
                                    SourceProfilePage(source: source)
                                }, label: {
                                    DiscoverSourcesCell(source: source)
                                        .padding(.all, 10)
                                })
                                
                            }
                            
                        }
                        .padding()
                        .padding(.bottom, 60)
                        
                    }
                                    
                }
                .onAppear(perform: {
                    sources = sortBy()//userProfile.sources
                })
                
                
                
            }
            .hideNavigationBar()
            
        }
        
    }
}

extension ProfileSourcesScreen {
    
    func sortBy () -> [Source] {
        
        if showFollowing {
            
            return userProfile.sources//.sorted(by: {$0.name < $1.name})
            
        } else {
            
            return allAppSources.filter{ !userProfile.sources.contains($0) }
            
        }
        
        
    }
    
    
}

