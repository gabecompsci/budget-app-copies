//
//  ContentView.swift
//  Budget app (list)
//
//  Created by gabriel carreno on 6/26/24.
//

// 6-26 figuring out how to create different sections for new budget entries.. to group them as category/amount seperately and have them appear as such.


import SwiftUI

struct ContentView: View {
    
    @State var budgetlist: Array<String> = []
    @State var showsheet = false
    @State var newitemfield  = ""
    @State var newitemfield2  = ""
    
    var body: some View {
        
        NavigationView {
            
            
            // add spacer between new entries to list from new item sheet
            
            
            Group {
                if budgetlist.count <= 1 {
                    Text("No Item")
                } else {
                    List((1...budgetlist.count-1), id: \.self) { i in
                        Text(budgetlist[i])
                            .contextMenu {
                                Button(action: {
                                    budgetlist.remove(at: i)
                                }, label: {
                                    Label("Delete", systemImage: "delete.left")
                                })
                            }
                    }
                }
            }
            
            .navigationTitle("Budget")
            .padding()
            
        }
        
        
        Button(action:  {
            showsheet.toggle()
            
            newitemfield = ""
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(.gray)
        })
        
        .padding()
        
        HStack {
            
            Spacer()
            
            GroupBox(label: Text("Expenses"), content: {
                Text("200") })
            
            
            GroupBox(label: Text("Budget"), content: {
                Text("2500") })
            
            GroupBox(label: Text("Income"), content: {
                Text("3400") })
            
            
        }
        .onChange(of: budgetlist) {
            save()
            load()
        }
        .onAppear() {
            save()
            load()
        }
        
        .refreshable {
            save()
            load()
        }
        
        //
        
        .sheet(isPresented: $showsheet)  {
            NavigationView {
                VStack {
                    List {
                        TextField("Item", text: $newitemfield)
                        TextField("Item", text: $newitemfield2)
                        
                    }
                    .navigationTitle("New Entry")
                    .toolbar{
                        Button("add") {
                            
                            budgetlist.append(newitemfield)
                            budgetlist.append(newitemfield2)
                            showsheet.toggle()
                            
                            
                        }
                        
                        //
                        
                    }
                    
                }
                
            }
            .presentationDetents([.height(300)])
        }
    }
    
    
    
    
    
    
    func save() -> Void {
        let temp = budgetlist.joined(separator: "/[split]/")
        let key = UserDefaults.standard
        key.set(temp, forKey: "budgetlist")
    }
    func load() -> Void {
        let key = UserDefaults.standard
        let temp = key.string(forKey: "budgetlist") ?? ""
        let temparray = temp.components(separatedBy: "/[split]/")
        budgetlist = temparray
    }
    
    
}



#Preview {
    ContentView()
}



//.sheet(isPresented: $showsheet)  {
//    NavigationView {
//        List {
//            TextField("Item", text: $newitemfield)
//            TextField("Item", text: $newitemfield2)
//            
//        }
//        .navigationTitle("New Entry")
//        .toolbar{
//            Button("add") {
//                
//                budgetlist.append(newitemfield)
//                budgetlist.append(newitemfield2)
//                showsheet.toggle()
//
//                
//            }
