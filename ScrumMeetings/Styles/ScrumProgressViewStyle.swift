/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle {
    var theme: Theme

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(theme.accentColor)
                .frame(height: 20.0)
            if #available(iOS 15.0, *) {
                ProgressView(configuration)
                    .tint(theme.mainColor)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            } else {
                ProgressView(configuration)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            }
        }
    }
}

extension ProgressViewStyle where Self == ScrumProgressViewStyle {
    func trailingIcon(theme: Theme) -> Self { Self(theme: theme) }
}

#Preview(traits: .sizeThatFitsLayout) {
    ProgressView(value: 0.65)
        .progressViewStyle(ScrumProgressViewStyle(theme: .buttercup))
}
