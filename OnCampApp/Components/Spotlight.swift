//
//  Spotlight.swift
//  OnCampApp
//
//  Created by Michael Washington on 1/19/24.
//

import SwiftUI

struct Spotlight: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Spotlight")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("LTBL"))
                LazyVStack(spacing: 32) {
                    ForEach(0 ... 10, id: \.self) { events in
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
    Spotlight()
}
