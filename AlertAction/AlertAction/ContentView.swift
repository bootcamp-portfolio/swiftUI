//
//  ContentView.swift
//  AlertAction
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI

struct ContentView: View {
    @State var isAlert = false
    @State var isActionsheet = false
    
    var body: some View {
        VStack {
        
            Text("Alert와 Action Sheet")
                .bold()
                .padding()
            
            HStack(spacing: 50, content: {
                Button("Alert",action: {
                    isAlert = true
                })
                .alert("Title", isPresented: $isAlert, actions: {
                    Button("Action Default", role: .none, action: {
                        print("Action Default")
                    })
                    Button("Action Destructive", role: .destructive, action: {
                        print("Action Destructive")
                    })
                    Button("Action Cancel", role: .cancel, action: {
                        print("Action Cancel")
                    })
                })
                Button("Action Sheet", action: {
                    isActionsheet = true})
            })
            .confirmationDialog(
                "Title",
                isPresented: $isActionsheet,
                titleVisibility: .visible
            ) {
                Button("Action Default", role: .none) {
                    print("Action Default")
                }
                Button("Action Destructive", role: .destructive) {
                    print("Action Destructive")
                }
                Button("Action Cancel", role: .cancel) {
                    print("Action Cancel")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
