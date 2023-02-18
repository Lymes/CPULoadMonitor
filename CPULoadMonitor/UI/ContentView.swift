//
//  ContentView.swift
//  CPULoadMonitor
//
//  Created by leonid.mesentsev on 17/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    private var viewModel = ContentViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.cpuInfo, id: \.self) { item in
                Gauge(value: item.user, in: 0...100) {
                } currentValueLabel: {
                    Text("\(Int(item.user))")
                        .foregroundColor(.white.opacity(0.8))
                }
                .tint(Gradient(colors: [.red, .orange, .yellow, .green]))
                .gaugeStyle(.accessoryCircularCapacity)
            }
        }
        .onAppear {
            viewModel.loadData()
        }
        Spacer()
    }
}
