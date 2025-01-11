//
//  DirectoryView.swift
//  Directory
//
//  Created by Natasha Martinez on 1/9/25.
//

import SwiftUI

struct DirectoryView: View {
    private enum Padding {
        static let sides: CGFloat = 10.0
        static let bottom: CGFloat = 10.0
    }
    
    let recipes: [Recipe]
    @Binding var shouldScrollToTop: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollableTopView(reader: proxy, scrollOnChange: $shouldScrollToTop)
                
                LazyHStack(spacing: 25) {
                    ForEach(recipes, id: \.self) { recipe in
                        NavigationLink {
                            Text(recipe.name)
                        } label: {
                            DirectoryCellView(recipe: recipe)
                        }
                        .buttonStyle(EmptyButtonStyle())
                    }
                }
            }
            .frame(height: 600)
            .contentMargins(.leading, 50, for: .scrollContent)
        }
    }
}

#Preview {
    @State var shouldScrollToTop = true
    return DirectoryView(recipes: [], shouldScrollToTop: $shouldScrollToTop)
}
