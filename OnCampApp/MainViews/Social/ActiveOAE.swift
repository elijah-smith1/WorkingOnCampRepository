//
//  ActiveOAE.swift
//  OnCampApp
//
//  Created by Michael Washington on 8/2/24.
//

import SwiftUI

struct ActiveOAE: View {
    @State private var showingOrders = false
    @State private var showingEvents = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Active Orders and Events")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 20) {
                Text("Orders")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Button("View Current Orders") {
                    showingOrders = true
                }
                .buttonStyle(.borderedProminent)
                
                Button("Order History") {
                    showingOrders = true
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
            
            VStack(spacing: 20) {
                Text("Events")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Button("Upcoming Events") {
                    showingEvents = true
                }
                .buttonStyle(.borderedProminent)
                
                Button("Past Events") {
                    showingEvents = true
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green.opacity(0.1)))
        }
        .padding()
        .sheet(isPresented: $showingOrders) {
            Text("Orders View")
                .font(.title)
        }
        .sheet(isPresented: $showingEvents) {
            Text("Events View")
                .font(.title)
        }
    }
}


#Preview {
    ActiveOAE()
}
