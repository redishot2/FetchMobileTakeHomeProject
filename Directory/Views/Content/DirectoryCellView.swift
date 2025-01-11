//
//  DirectoryCellView.swift
//  Directory
//
//  Created by Natasha Martinez on 1/9/25.
//

import SwiftUI

struct DirectoryCellView: View {
    private enum Constants {
        static let imageSize: CGFloat = 300.0
    }
    
    let recipe: Recipe
    
    var body: some View {
        VStack {
            if let imageURL = recipe.photo_url_large, let url = URL(string: imageURL) {
                CacheAsyncImage(url: url) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    } else if state.error != nil {
                        Color.red
                    } else {
                        // Loading
                        Color.customColorMedium
                            .frame(width: Constants.imageSize, height: Constants.imageSize)
                    }
                }
            }
            
            FlavorTextView(recipe: recipe)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .frame(width: Constants.imageSize)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3, x: 3, y: 3)
    }
}

#Preview {
    DirectoryCellView(recipe: Recipe(cuisine: "", name: "", photo_url_large: nil, photo_url_small: nil, uuid: "", source_url: "", youtube_url: ""))
}
