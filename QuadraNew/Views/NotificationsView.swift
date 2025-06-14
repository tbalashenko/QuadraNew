//
//  NotificationsView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 05/07/2024.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        Toggle(TextConstants.notifications, isOn: $viewModel.sendNotifications)
        if viewModel.sendNotifications {
                DatePicker(
                    "",
                    selection: $viewModel.reminderTime,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
            
        }
        FootnoteText(text: TextConstants.dontMissOut)
    }
}

#Preview {
    NotificationsView(viewModel: SettingsViewModel(settings: SettingsService()))
}
