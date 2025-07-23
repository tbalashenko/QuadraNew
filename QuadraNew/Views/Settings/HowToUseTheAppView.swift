//
//  HowToUseTheAppView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 29/05/2025.
//

import SwiftUI

struct HowToUseTheAppView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(TextConstants.addFirstCards)
                NeuButton(image: "plus.circle.fill", withBackground: false) { }
                Spacer()
            }
            
            HStack {
                Spacer()
                Text(TextConstants.recallThem)
            }
            
            DummyAutoswipingCardView()
            
            HStack(spacing: SizeConstants.spacing) {
                Spacer()
                Text(TextConstants.checkYourself)
                IconCircleButton(systemName: "repeat", size: .xxs, action: {})
            }
            
            HStack {
                Text(TextConstants.swipeThem)
                Spacer()
            }
            
            
            HStack {
                Spacer()
                Text(TextConstants.returnBackEveryDay)
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(Color.accentColor)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HowToUseTheAppView()
}
