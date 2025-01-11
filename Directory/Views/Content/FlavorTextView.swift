//
//  FlavorTextView.swift
//  Directory
//
//  Created by Natasha Martinez on 1/10/25.
//

import SwiftUI

struct FlavorTextView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            
            Text(recipe.name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.01)
                .bold()
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5))
            
            HStack {
                Spacer()
                
                rating(4)
                
                Spacer()
                
                HStack {
                    Image(systemName: "globe.americas.fill")
                        .foregroundStyle(Color.gray)
                    
                    Text(recipe.cuisine)
                        .font(.footnote)
                        .foregroundStyle(Color.gray)
                }
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                subHeadline(text: "30 mins", systemImage: "timer")
                
                Spacer()
                
                subHeadline(text: "2 servings", systemImage: "person")
                
                Spacer()
            }
            
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
            .frame(height: 40)
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.customColorLight, Color.customColorMedium]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .overlay {
                Button {
                    print("Button pressed!")
                } label: {
                    Text("VIEW RECIPE")
                        .foregroundColor(.white)
                }
                .buttonStyle(EmptyButtonStyle())
            }
            .padding(EdgeInsets(top: 15, leading: 0, bottom: 5, trailing: 0))
        }
    }
    
    func subHeadline(text: String, systemImage: String) -> some View {
        Group {
            Image(systemName: systemImage)
                .foregroundStyle(Color.gray)
            
            Text(text)
                .font(.footnote)
                .foregroundStyle(Color.gray)
        }
    }
    
    func rating(_ stars: Int) -> some View {
        let totalStars: Int = 5
        
        return HStack {
            ForEach(0..<totalStars, id: \.self) { i in
                let fillColor = i < stars ? Color.yellow : Color.gray
                
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(fillColor)
            }
        }
    }
}

#Preview {
    FlavorTextView(recipe: Recipe(cuisine: "", name: "", photo_url_large: "", photo_url_small: "", uuid: "", source_url: "", youtube_url: ""))
}
