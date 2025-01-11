//
//  LoadingView.swift
//  Directory
//
//  Created by Natasha Martinez on 1/10/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .scaleEffect(2.0, anchor: .center)
    }
}

#Preview {
    LoadingView()
}
