//
//  SkeletonListView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 13/07/2024.
//

import SwiftUI

struct SkeletonListView: View {
    @EnvironmentObject var settings: SettingsService
    @EnvironmentObject var sizeConstants: SizeConstants
    @Binding var isPresented: Bool
    
    private var currentOpacity: CGFloat { isPresented ? 1 : 0 }
    
    var body: some View {
        List {
            ForEach(0..<10) { _ in
                SkeletonListRowView()
                    .customListRow()
                    .environmentObject(settings)
                    .environmentObject(sizeConstants)
            }
        }
        .customListStyle()
        .opacity(currentOpacity)
        .animation(.easeInOut, value: currentOpacity)
    }
}

#Preview {
    SkeletonListView(isPresented: .constant(true))
        .environmentObject(SettingsService())
        .environmentObject(SizeConstants(settings: SettingsService()))
}
