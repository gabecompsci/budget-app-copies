//
//  Income.swift
//  Budget app (list)
//
//  Created by gabriel carreno on 7/21/24.
//

import SwiftUI

struct Income: View {
 
    @State var Income: Array<String> = []
    @State var IncomeAmount: Array<Int> = []
    @State var showsheet = false
    @State var newitemfieldI  = ""
    @State var newitemfieldI2 = ""
    

var body: some View {
    
    
    NavigationStack {
        
        
        
        NavigationView {
            Group {
                if Income.count <= 1 {
                    Text("No Items") }
                else {
                    List((1...Income.count-1), id: \.self)
                    { i in
                        Text(Income[i])
                            .contextMenu {
                                Button(action: {
                                    Income.remove(at: i)
                                }, label: {
                                    Label("Delete", systemImage: "delete.left")
                                })
                                
                            }
                    }
                }
                
         
                
                
                
            }
            .padding()
            .listRowSpacing(8.0)
            .listRowSeparator(.hidden)
            .navigationTitle("Income")
            .navigationBarTitleDisplayMode(.inline)
        }
        Button(action:  {
            showsheet.toggle()
            newitemfieldI = ""
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(.gray)
        })
        
        
        
                        .onChange(of: Income) {
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
        
        .sheet(isPresented: $showsheet)  {
            NavigationStack {
                VStack {
                    List {
                        TextField("Income Source", text: $newitemfieldI)
                        
                        TextField("Amount", value: $newitemfieldI2, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                        
                    }
                    
                    .navigationTitle("New Entry")
                    .toolbar{
                        Button("add") {
                            
                            
                            
                            Income.append(newitemfieldI)
                            
                            showsheet.toggle()
                            
                            
                            
                        }
                        .foregroundColor(.gray)
                        
                        //
                        
                    }
                }
                
            }
            .presentationDetents([.height(300)])
        }
        
        
    }
    
    .preferredColorScheme(.dark)
}



        func save() -> Void {
            let temp = Income.joined(separator: "/[Split]/")
            let key = UserDefaults.standard
            key.set(temp, forKey: "Income")
        }


        func load() -> Void {
            let key = UserDefaults.standard
            let temp = key.string(forKey: "Income") ?? ""
            let temparray = temp.components(separatedBy: "/[Split]/")
            Income = temparray
        }
    }






#Preview {
    Income()
}
