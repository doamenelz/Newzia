//
//  SourcesList.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-26.
//

import Foundation
import SwiftUI

struct SourcesList: View {
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    @ObservedObject var viewModel : AccountSetupViewModel
    
    @ObservedObject var sourcesViewModel : SourcesModel
    
    @Binding var search : String
    
    var body: some View {
        ScrollView {
            
            if !sourcesViewModel.sources.isEmpty {
                
                LazyVGrid(columns: columns, content: {
                    ForEach(search == "" ? sourcesViewModel.sources : sourcesViewModel.sources.filter({$0.name.uppercased().contains(search.uppercased())}), id: \.self) {source in
                        
                        SourcesCell(source: source, isSelected: viewModel.selectedSources.contains(source) ? true : false)
                            .onTapGesture {
                                
                                withAnimation {
                                    
                                    if viewModel.selectedSources.contains(source) {
                                        viewModel.selectedSources.removeAll(where: {$0.id == source.id})
                                    } else {
                                        viewModel.selectedSources.append(source)
                                    }
                                    
                                }
                                
                            }
                        
                    }
                    
                    
                })
                
            }
            
        }
    }
}

