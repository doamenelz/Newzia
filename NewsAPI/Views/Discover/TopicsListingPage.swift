//
//  TopicsListingPage.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-03.
//

import SwiftUI

struct TopicsListingPage: View {
    
    @EnvironmentObject var userProfile : UserProfile
    
    @State private var topicName : String = ""
    
    @State private var showTopicModal : Bool = false
    
    @State private var showList : Bool = false
    
    var body: some View {
        ZStack {
            Color.whiteBlueDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationHeader()
                    .padding(.horizontal)
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("#Topics")
                            .modifier(FontModifier(color: .darkGreySoft, size: .large, type: .bold))
                        Text("\(userProfile.topics.count) Following")
                            .modifier(FontModifier(color: .darkGreySoft, size: .label, type: .regular))
                    }
                    
                    Spacer()
                    
                    Image(systemName: SystemIcons.plusCircle.rawValue)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.cRed)
                        .onTapGesture {
                            withAnimation {
                                showTopicModal.toggle()
                            }
                        }
                }
                .padding(.horizontal)
                
                ScrollView {
                    
                    LazyVStack {
                        ForEach(userProfile.topics, id: \.self) { topic in
                            
                            TopicCell(label: topic)
                                .onTapGesture {
                                    
                                    topicName = topic
                                    
                                    if topicName != "" {
                                        showList.toggle()
                                    }
                                    
                                }
                            
//                            NavigationLink(destination: {
//                                TopicDetailsScreen(topic: topic)
//                            }, label: {
//                                TopicCell(label: topic)
//                            })
                            
                        }
                    }
                    
                }
            }
            .background(showTopicModal ? Color.greyBlueMedium : .clear)
            .blur(radius: showTopicModal ? 5 : 0)
            .onTapGesture {
                if showTopicModal {
                    withAnimation {
                        showTopicModal.toggle()
                    }
                }
            }
            
            
            VStack {
                
                
                Spacer()
                
                
                VStack  {
                    
                    HStack {
                        Text("Search for a topic")
                            .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .medium))
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top)
                        
                    IconTextField(icon: .topic, placeHolder: "Topic Name", text: $topicName, isMandatory: false, errorMessage: "", checkEntry: false)
                        
                    
                        CTARed(label: "Continue")
                            .padding(.vertical)
                            
                            .opacity(topicName == "" ? 0.8 : 1)
                            .onTapGesture {
                                
                                if topicName != "" {
                                    showList.toggle()
                                }
                                
                            }
                            .sheet(isPresented: $showList, onDismiss: {
                                
                            }, content: {
                                TopicDetailsScreen(topic: topicName)
                            })
                    
                    
                        
                    
                    
                }
                .padding()
                .background(Color.whiteBlueDark)
                .cornerRadius(30)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding()
                .padding(.bottom, 60)
                
                
            }
            .offset(y: showTopicModal ? 0 : K.Dimensions.frameHeight)
        }
        .hideNavigationBar()
    }
}

struct TopicsListingPage_Previews: PreviewProvider {
    static var previews: some View {
        TopicsListingPage().environmentObject(UserProfile())//.preferredColorScheme(.dark)
    }
}

fileprivate struct TopicCell: View {
    
    var label : String
    
    var body: some View {
        HStack {
            Text("#\(label)")
                .modifier(FontModifier(color: .darkGreySoft, size: .body, type: .medium))
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                .background(Color.greyBlueMedium)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            Spacer()
            
            Image(systemName: SystemIcons.chevronRight.rawValue)
                .font(.caption)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}
