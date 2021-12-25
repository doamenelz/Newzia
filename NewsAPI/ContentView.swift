//
//  ContentView.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2021-12-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CategoriesSetupScreen(viewModel: AccountSetupViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
