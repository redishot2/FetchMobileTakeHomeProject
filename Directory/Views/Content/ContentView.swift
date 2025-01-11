//
//  ContentView.swift
//  Directory
//
//  Created by Natasha Martinez on 1/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedURL = Networking.URLs.valid
    @State private var shouldScrollToTop = false
    
    @State private var isLoading = true
    @State private var recipes: [Recipe] = []
    @State private var networkingError: Networking.NetworkingError?
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                if isLoading {
                    LoadingView()
                } else if recipes.count > 0 {
                    HStack(spacing: 25) {
                        DirectoryView(recipes: recipes, shouldScrollToTop: $shouldScrollToTop)
                    }
                } else {
                    let error = networkingError ?? Networking.NetworkingError(description: .emptyURL)
                    DirectoryErrorView(networkError: error)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                }
            }
            .onAppear {
                Task {
                    await fetch()
                }
            }
            .toolbar {
                Menu {
                    ForEach(Networking.URLs.all, id: \.self) { urlInfo in
                        Button(urlInfo.name) {
                            selectedURL = urlInfo
                            
                            Task {
                                await fetch()
                            }
                            
                            shouldScrollToTop.toggle()
                        }
                    }
                } label: {
                    Image(systemName: "network")
                        .foregroundStyle(Color.white)
                }
                .frame(alignment: .trailing)
                
                Menu {
                    ForEach(Sorting.SortType.SortTypes.all, id: \.self) { sortType in
                        Button(sortType.rawValue) {
                            recipes = Sorting.sort(by: sortType, content: recipes)
                            shouldScrollToTop.toggle()
                        }
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundStyle(Color.white)
                }
                .frame(alignment: .trailing)
            }
        }
    }
    
    func fetch() async {
        // Reset
        recipes = []
        networkingError = nil
        isLoading = true
        
        let result = await Networking.fetchData(url: selectedURL.url)
        isLoading = false
        
        switch result {
            case .success(let recipes):
                self.recipes = recipes
            case .failure(let error):
                self.networkingError = error
        }
    }
}

#Preview {
    ContentView()
}
