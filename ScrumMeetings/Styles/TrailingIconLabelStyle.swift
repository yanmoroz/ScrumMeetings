//
//  TrailingIconLabelStyle.swift
//  SUISandbox
//
//  Created by Yan Moroz on 10.02.2024.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}

#Preview(traits: .sizeThatFitsLayout) {
    Label("Label Text", systemImage: "globe")
        .labelStyle(.trailingIcon)
}
