//
//  ViewModel.swift
//  JARVIS
//
//  Created by Home on 19/4/23.
//

import Foundation
import SwiftOpenAI

final class ViewModel: ObservableObject {
    @Published var messages: [MessageChatGPT] = [.init(text: "¡Hola! Soy el asistente de SwiftBeta, estoy aquí para contestarte todas las preguntas relacionadas de Swift, SwiftUI, Xcode ¡y mucho más!", role: .system)]
    @Published var currentMessage: MessageChatGPT = .init(text: "", role: .assistant)

    var openAI = SwiftOpenAI(apiKey: "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")
        
    func send(message: String) async {
        let messages: [MessageChatGPT] = [
            MessageChatGPT(text: "You are a helpful assistant.", role: .system),
            MessageChatGPT(text: "Cuando se lanzó el primer iPhone?", role: .user)
        ] // 1
        let optionalParameters = ChatCompletionsOptionalParameters(temperature: 0.7,
                                                                   stream: true,
                                                                   maxTokens: 50) // 2
                
        await MainActor.run {
            let myMessage = MessageChatGPT(text: message, role: .user)
            self.messages.append(myMessage)
            
            self.currentMessage = MessageChatGPT(text: "", role: .assistant)
            self.messages.append(self.currentMessage)
        }

        do {
            let stream = try await openAI.createChatCompletionsStream(model: .gpt4(.base),
                                                                      messages: messages,
                                                                      optionalParameters: optionalParameters) // 3
            
            for try await response in stream { // 4
                print(response)
                await onReceive(newMessage: response)
            }
        } catch {
            print("Error: \(error)") // 5
        }
    }
    
    @MainActor
    private func onReceive(newMessage: ChatCompletionsStreamDataModel) {
        let lastMessage = newMessage.choices[0]
        guard lastMessage.finishReason == nil else {
            print("Finished streaming messages")
            return
        }
        
        guard let content = lastMessage.delta?.content else {
            print("Message with no content")
            return
        }
        
        currentMessage.text = currentMessage.text + content
        messages[messages.count-1].text = currentMessage.text
    }
}
