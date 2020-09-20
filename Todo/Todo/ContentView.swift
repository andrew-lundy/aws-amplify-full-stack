//
//  ContentView.swift
//  Todo
//
//  Created by Andrew Lundy on 9/19/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onAppear {
                self.performOnAppear()
             }
    }
    
    
    func performOnAppear() {
        Amplify.DataStore.query(Todo.self, where: Todo.keys.name.eq("File those quarterly taxes.")) { (result) in
            switch(result) {
            case .success(let todos):
                guard todos.count == 1, let toDeleteTodo = todos.first else {
                    print("Did not find exactly one todo, bailing.")
                    return
                }
                
                Amplify.DataStore.delete(toDeleteTodo) { (result) in
                    switch(result) {
                    case .success:
                        print("Deleted item: \(toDeleteTodo.name)")
                        
                    case .failure(let error):
                        print("Could not update DataStore: \(error)")
                    }
                }
            case .failure(let error):
                print("Unable to query DataStore: \(error)")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
