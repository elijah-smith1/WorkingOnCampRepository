//
//  TournamentEvents.swift
//  OnCampApp
//
//  Created by Michael Washington on 3/23/24.
//

import SwiftUI

struct TournamentEvents: View {
    @ObservedObject var viewmodel = eventViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(viewmodel.events, id: \.id) { events in
                        NavigationStack{
                            EventPreview()
                                .frame(height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Divider()
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { events in
                Text("events")
            }
        }
    }
}

#Preview {
    TournamentEvents()
}
