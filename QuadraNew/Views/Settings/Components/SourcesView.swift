//
//  SourcesView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 12/04/2024.
//

import SwiftUI
import SwiftData

struct SourcesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var sources: [CardSource]
    
    var body: some View {
        List {
            ForEach(sources) { source in
                SourceListRowView(viewModel: SourceViewModel(source: source))
            }
            .onDelete(perform: deleteSources)
        }
        .customListStyle()
        .navigationTitle(TextConstants.yourSources)
    }

    private func deleteSources(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sources[index])
            }
            
            try? modelContext.save()
        }
    }
}

#Preview {
    return SourcesView()
}
