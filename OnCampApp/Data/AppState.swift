//
//  AppState.swift
//  OnCampApp
//
//  Created by Michael Washington on 2/1/24.
//


import Combine

class AppState: ObservableObject {
    @Published var selectedTab: Int = 4 // Default to the profile tab as per your current setup
}
