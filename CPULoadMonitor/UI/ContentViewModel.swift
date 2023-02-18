//
//  ContentViewModel.swift
//  CPULoadMonitor
//
//  Created by leonid.mesentsev on 17/02/23.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var cpuInfo: [ProcessorUsage] = []

    func loadData() {
        cpuInfo = CPU.coreUsage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadData()
        }
    }
}
