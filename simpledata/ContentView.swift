//
//  ContentView.swift
//  simpledata
//
//  Created by user on 9/20/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var cloudContext
    @State var simple: Simple?
    @State var simples: [Simple]?
  
    func simplesList() {
      let request = Simple.fetchRequest() as NSFetchRequest<Simple>
      request.sortDescriptors = []
      let results = try! self.cloudContext.fetch(request)
//      if (!results.isEmpty) {
        self.simples = results
//      }
    }
  
    func removeSimple(item: Simple) {
      self.cloudContext.delete(item)
      try? self.cloudContext.save()
      self.simplesList()
    }
  
    func newSimple(nameToCreate: String) {
      let newSimple = Simple(context: self.cloudContext)
      newSimple.name = nameToCreate
      if (!newSimple.name!.isEmpty && self.cloudContext.hasChanges) {
        try? self.cloudContext.save()
      }
      self.simple = newSimple
      simplesList()
    }
  
    func getSimple(nameToFetch: String) {
      do {
        // go find an item named per the "nameToFetch" input
        let request = Simple.fetchRequest() as NSFetchRequest<Simple>
        request.predicate = NSPredicate(format: "name == %@", nameToFetch)
        request.sortDescriptors = []  // Cannot form a request without this
        let result = try self.cloudContext.fetch(request)
        if (!result.isEmpty) {
          self.simple = result[0] // use the first one from the set
          if (self.cloudContext.hasChanges) { try? self.cloudContext.save() }
        } else {
          // by default if an item is not found, lets add one named so, to the list
          newSimple(nameToCreate: nameToFetch)
        }
        // load the list of items
        simplesList()
      }
      catch{
        
      }
    }
    var body: some View {
        Text("Simple Core Data example")
            .padding()
            .onAppear{
              // on first load, get an item from CoreData named as such
              self.getSimple(nameToFetch: "onAppear a simple name")
            }
        
      Button( action: {
        newSimple(nameToCreate: "add a simple button")
      }){
        Text("Add a simple item")
      }
      if simples != nil && !simples!.isEmpty {
        List(simples!) { simple in
          Text("\(simple.name!)")
          Button ( action: {
            self.removeSimple(item: simple)
          }) {
            Text("Delete")
              .foregroundColor(Color.red)
          }
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
