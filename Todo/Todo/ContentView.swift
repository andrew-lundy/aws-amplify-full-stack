//
//  ContentView.swift
//  Todo
//
//  Created by Andrew Lundy on 9/19/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins
import Combine

struct ContentView: View {
    @State var todoSubscription: AnyCancellable?
    
    var body: some View {
        Text("Hello, world!")
            .onAppear {
                self.performOnAppear()
             }
    }
    
    func subscribeTodos() {
        self.todoSubscription = Amplify.DataStore.publisher(for: Todo.self).sink(receiveCompletion: { (completion) in
            print("Subscription has been completed: \(completion)")
        }, receiveValue: { (mutationEvent) in
            print("Subscription got this value: \(mutationEvent)")
        })
    }
    
    func performOnAppear() {
        subscribeTodos()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
