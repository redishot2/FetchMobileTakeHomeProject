//
//  DirectoryErrorView.swift
//  Directory
//
//  Created by Natasha Martinez on 1/9/25.
//

import SwiftUI

struct DirectoryErrorView: View {
    let networkError: Networking.NetworkingError?
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.customColorMedium)
                
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            }
            
            Text("Error loading content")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            Text(networkError?.displayMessage ?? "No content found")
                .font(.subheadline)
        }
        .padding(EdgeInsets(top: 40, leading: 30, bottom: 40, trailing: 30))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    DirectoryErrorView(networkError: Networking.NetworkingError(description: .badURL))
}
