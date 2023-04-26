//
//  ConversationView.swift
//  JARVIS
//
//  Created by Home on 22/4/23.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.messages) { message in
                TextMessageView(message: message)
            }
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView().environmentObject(ViewModel())
    }
}
