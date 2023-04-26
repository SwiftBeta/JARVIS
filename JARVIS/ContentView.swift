//
//  ContentView.swift
//  JARVIS
//
//  Created by Home on 19/4/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var prompt: String = "Por favor, dime un resumen del señor de los anillos"
    
    var body: some View {
        VStack {
            ConversationView()
                .environmentObject(viewModel)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Spacer()
            HStack {
                TextField("Write something for ChatGPT", text: $prompt, axis: .vertical)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(25)
                    .lineLimit(6)
                Button(action: {
                    Task {
                        await viewModel.send(message: prompt)
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color.white)
                        .frame(width: 44, height: 44)
                        .background(Color.blue)
                        .cornerRadius(22)
                }
            }
            .padding(.leading, 8)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
