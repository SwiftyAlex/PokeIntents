//
//  PokeContainer.swift
//  PokéIntents
//
//  Created by Alex Logan on 14/11/2022.
//

import Foundation
import SwiftUI

struct PokeContainer<Content: View>: View {
    var content: () -> (Content)

    var readableWidth: CGFloat {
        UIViewController().view.readableContentGuide.layoutFrame.width
    }

    init(@ViewBuilder content: @escaping () -> (Content)) {
        self.content = content
    }

    var body: some View {
        ZStack {
            Color.backgroundGray.edgesIgnoringSafeArea(.all)
            content()
                .frame(maxWidth: readableWidth, alignment: .center)
        }
    }
}
