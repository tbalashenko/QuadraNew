//
//  LoadingManager.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 18/06/2025.
//

import Foundation
import Combine

@MainActor
final class LoadingManager: ObservableObject {
    @Published var isLoading = false
    
    private var currentTask: Task<Void, Never>?
    
    func runWithLoading(delay: TimeInterval = 0, _ work: @escaping () async -> Void) {
        isLoading = true
        currentTask?.cancel()
        
        currentTask = Task {
            if delay > 0 {
                try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            }
            
            await work()
            self.isLoading = false
        }
    }
    
    func cancel() {
        currentTask?.cancel()
        isLoading = false
    }
}
