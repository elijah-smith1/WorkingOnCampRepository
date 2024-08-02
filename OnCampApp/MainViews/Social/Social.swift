import SwiftUI

struct Social: View {
    let categories = ["All", "Tournament", "School", "Parties"]
    @State private var selectedCategoryIndex = 0
    @State private var showingSearchView = false
    @State private var messageNotificationCount = 2 // Example count, update with real data
    @State private var notificationCount = 5 // Example count, update with real data

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    featuredEventsTitle
                    instagramStyleCircles
                    categoryPicker
                    contentSwitcherView
                }
                .padding(.bottom, 20)
            }
            .navigationTitle(categories[selectedCategoryIndex])
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: MessagesView()) {
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
    }

    var featuredEventsTitle: some View {
        Text("Featured Events")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
    
    var instagramStyleCircles: some View {
        HStack {
            ForEach(0..<3) { _ in
                Circle()
                    .frame(width: 60, height: 60)
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
            }
        }
        .padding(.horizontal)
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
                Events()
            case 1:
                Trending()
            case 2:
                Spotlight()
            case 3:
                BulletinBoard()
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
