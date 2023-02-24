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
        GridItem(.adaptive(minimum: 70))
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.cpuInfo, id: \.self) { item in
                    Gauge(value: item.user + item.system, in: 0...200) {
                    } currentValueLabel: {
                        Text("\(Int(item.user))")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .tint(Gradient(colors: [.red, .orange, .yellow, .green]))
                    .gaugeStyle(.accessoryCircularCapacity)
                }
            }
            .shadow(color: .black.opacity(0.6), radius: 2.0, x: 0.0, y: 0.0)
            .onAppear {
                viewModel.loadData()
            }
        }
        .padding()
        Spacer()
    }
}
