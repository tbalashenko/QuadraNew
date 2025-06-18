//
//  SwipeIndicatorView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 18/06/2025.
//

import SwiftUI

struct SwipeIndicatorView: View {
    @Binding var xOffset: CGFloat
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(size: SizeConstants.xLargeButtonImageSize)
                    .foregroundStyle(Color.Green.darkSeaGreen.opacity(0.3))
                    .rotationEffect(.degrees(-30))
                    .opacity (Double(xOffset / (SizeConstants.screenWidth / 3)))
                Spacer()
            }
            Spacer()
            VStack {
                Image(systemName: "xmark.app")
                    .resizable()
                    .frame(size: SizeConstants.xLargeButtonImageSize)
                    .foregroundStyle(Color.dustRose.opacity(0.3))
                    .rotationEffect(.degrees(30))
                    .opacity (Double(xOffset / (SizeConstants.screenWidth / 3) * -1))
                Spacer()
            }
        }
        .padding(.top, SizeConstants.screenWidth / 3)
    }
}
