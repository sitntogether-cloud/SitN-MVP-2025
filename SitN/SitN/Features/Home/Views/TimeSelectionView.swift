//
//  TimeSelectionView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

struct TimeSelectionView: View {
    @State private var selectedTimes: [String] = []

    // Mock data
    let availableTimes = ["7:00 PM", "7:30 PM", "8:00 PM", "8:30 PM", "9:00 PM", "9:30 PM"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            Text("Select Reservation Times")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(availableTimes, id: \.self) { time in
                        Button(action: {
                            if selectedTimes.contains(time) {
                                selectedTimes.removeAll { $0 == time }
                            } else {
                                selectedTimes.append(time)
                            }
                        }) {
                            Text(time)
                                .font(.headline)
                                .foregroundColor(selectedTimes.contains(time) ? .white : .blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedTimes.contains(time) ? Color.blue : Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        }
                    }
                }
                .padding()
            }
            
            if !selectedTimes.isEmpty {
                Text("Selected: \(selectedTimes.joined(separator: ", "))")
                    .padding()
                
                NavigationLink(destination: InviteListView()) {
                    PrimaryButtonLabel(text: "Next")
                }
                .padding()
            }

            Spacer()
        }
        .navigationTitle("Select Times")
    }
}

#Preview {
    TimeSelectionView()
}
