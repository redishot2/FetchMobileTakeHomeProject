//
//  ButtonStyle+Utilities.swift
//  Directory
//
//  Created by Natasha Martinez on 1/11/25.
//

import SwiftUI

struct EmptyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
