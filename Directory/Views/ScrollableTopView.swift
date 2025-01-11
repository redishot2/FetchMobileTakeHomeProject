//
//  ScrollableTopView.swift
//  Directory
//
//  Created by Natasha Martinez on 1/10/25.
//

import SwiftUI

struct ScrollableTopView: View {
    private enum Constants {
        static let scrollID = "topScrollPoint"
    }
    
    let reader: ScrollViewProxy
    @Binding var scrollOnChange: Bool
    
    var body: some View {
        EmptyView()
            .id(Constants.scrollID)
            .onChange(of: scrollOnChange, { _, _ in
                withAnimation {
                    reader.scrollTo(Constants.scrollID, anchor: .leading)
                }
            })
    }
}

#Preview {
    @State var scrollOnChange = false
    return ScrollViewReader { proxy in
        ScrollableTopView(reader: proxy, scrollOnChange: $scrollOnChange)
    }
}
