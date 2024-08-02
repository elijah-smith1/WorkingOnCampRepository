import SwiftUI
import FirebaseFirestore
import Kingfisher

struct Social: View {
    @StateObject var viewModel = eventViewModel()
    @State private var selectedCategoryIndex = 0
    @State private var showingSearchView = false
    @State private var messageNotificationCount = 2
    @State private var notificationCount = 5

    let categories = ["All", "Tournament", "School", "Parties"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    featuredEventsTitle
                    if let featuredEvent = viewModel.events.first(where: { $0.isFeatured }) {
                        instagramStyleBox(for: featuredEvent)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(viewModel.events.filter { $0.isSponsored }) { event in
                                instagramStyleBox(for: event)
                            }
                        }
                        .padding(.horizontal)
                    }
                    categoryPicker
                    contentSwitcherView
                }
                .padding(.bottom, 20)
            }
            .navigationTitle(categories[selectedCategoryIndex])
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: Messages()) {
                        BadgeView(iconName: "message", count: messageNotificationCount)
                    }
                }

                ToolbarItem(placement: .principal) {
                    searchButton
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NotificationsView()) {
                        BadgeView(iconName: "bell", count: notificationCount)
                    }
                }
            }
            .sheet(isPresented: $showingSearchView) {
                Search() // Ensure this view exists and is correct
            }
        }
        .onAppear {
            Task{
                do{
                    try await  viewModel.fetchEvents()
                }
            }
           
        }
    }

    // MARK: - View Components
    var featuredEventsTitle: some View {
        Text("Featured Events")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }

    func instagramStyleBox(for event: Event) -> some View {
        NavigationLink(destination: DetailView(event: event)) {
            VStack {
                if let imageUrl = event.imageUrls?.first, let url = URL(string: imageUrl) {
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 160)
                        .cornerRadius(10)
                }
                Text(event.title)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 5)
            .background(Color.white) // Optional: for better visibility
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(event.isFeatured ? Color.purple : event.isSponsored ? Color.yellow : Color.clear, lineWidth: 4)
            )
        }
    }

    var categoryPicker: some View {
        Picker("Categories", selection: $selectedCategoryIndex) {
            ForEach(categories.indices, id: \.self) { index in
                Text(categories[index]).tag(index)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }

    var contentSwitcherView: some View {
        Group {
            switch selectedCategoryIndex {
            case 0:
                AllEvents()
            case 1:
                TournamentEvents()
            case 2:
                SchoolEvents() // Make sure this is the correct initializer
            case 3:
                PartyEvents() // Make sure this is the correct initializer
            default:
                EmptyView()
            }
        }
    }

    var searchButton: some View {
        Button(action: {
            showingSearchView = true
        }) {
            HStack {
                Text("Search...")
                    .foregroundColor(.blue)
            }
            .padding(7)
            .frame(width: 300, height: 30)
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(.blue))
        }
    }
}

// MARK: - Supporting Views (Assuming these are already defined or placeholders for your real views)
struct DetailView: View {
    var event: Event

    var body: some View {
        // Implement your detailed view content here
        Text("Detail view for \(event.title)")
    }
}

struct BadgeView: View {
    var iconName: String
    var count: Int
    
    var body: some View {
        ZStack {
            Image(systemName: iconName)
            if count > 0 {
                Text("\(count)")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
}

struct Social_Previews: PreviewProvider {
    static var previews: some View {
        Social()
    }
}
