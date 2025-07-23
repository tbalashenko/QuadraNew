//
//  SkeletonListRowView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 08/04/2024.
//

import SwiftUI

struct SkeletonListRowView: View {
    @EnvironmentObject var settings: SettingsService
    @EnvironmentObject var sizeConstants: SizeConstants
    @State private var offset: CGFloat = -SizeConstants.screenWidth / 2
    
    var body: some View {
        ZStack {
            SkeletonView()
                .offset(x: offset)
                .frame(size: sizeConstants.listImageSize)
            HStack {
                Spacer()
                    .frame(width: sizeConstants.listImageWidth / 2 - 16)
                VStack(alignment: .leading, spacing: 8) {
                    SkeletonView()
                        .frame(height: 22)
                        .padding([.top, .leading])
                    SkeletonView()
                        .frame(width: 100,
                               height: 22)
                        .padding([.leading, .bottom])
                }
                
            }
            .padding(.trailing, 16)
        }
        .background(Color.element
            .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
            .northWestShadow()
        )
    }
}

#Preview {
    List {
        ForEach(0..<10) { _ in
            SkeletonListRowView()
                .customListRow()
                .environmentObject(SettingsService())
                .environmentObject(SizeConstants(settings: SettingsService()))
        }
    }
    .customListStyle()
}
