//
//  QuadraNewApp.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI
import SwiftData

@main
struct QuadraNewApp: App {
    var sharedModelContainer: ModelContainer
    @StateObject private var appState = AppState.shared
    @StateObject private var settingsService: SettingsService
    @StateObject private var sizeConstants: SizeConstants
    @StateObject private var cardService: CardService
    
    init() {
        let settings = SettingsService()
        let cardService = CardService()
        _settingsService = StateObject(wrappedValue: settings)
        _cardService = StateObject(wrappedValue: cardService)
        _sizeConstants = StateObject(wrappedValue: SizeConstants(settings: settings))
        
        ValueTransformer.setValueTransformer(
            AttributedStringTransformer(),
            forName: NSValueTransformerName("AttributedStringTransformer")
        )
        
        sharedModelContainer = {
            let schema = Schema([
                Card.self, ArchiveTag.self, CardSource.self, StatData.self
                
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $appState.selectedTab) {
                ContentView()
                    .tabItem { Image(systemName: "book.pages") }
                    .tag(AppTab.cards)
                ListView()
                    .tabItem { Image(systemName: "list.bullet") }
                    .tag(AppTab.list)
                StatView()
                    .tabItem { Image(systemName: "chart.xyaxis.line") }
                    .tag(AppTab.stat)
                OtherView()
                    .tabItem { Image(systemName: "gearshape") }
                    .tag(AppTab.settings)
            }
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(settingsService)
        .environmentObject(sizeConstants)
        .environmentObject(cardService)
    }
}
