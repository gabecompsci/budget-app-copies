import SwiftUI
import UIKit

// ask tutor why the variables arent showing up the same as
// the other viee where they are blue
    
struct Expenses: View {
   
        
        
        @State var Expenses: Array<String> = []
        @State var ExpensesAmount: Array<Int> = []
        @State var showsheet = false
        @State var newitemfieldE  = ""
        @State var newitemfieldE2 = ""
        

    var body: some View {
        
        
        NavigationStack {
            
            
            
            NavigationView {
                Group {
                    if Expenses.count <= 0 {
                        Text("No Item") }
                    else {
                        List((0...Expenses.count-1), id: \.self)
                        { i in
                            Text(Expenses[i])
                                .contextMenu {
                                    Button(action: {
                                        Expenses.remove(at: i)
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
                .navigationTitle("Expenses")
                .navigationBarTitleDisplayMode(.inline)
            }
            Button(action:  {
                showsheet.toggle()
                newitemfieldE = ""
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.gray)
            })
            
            
            
            //                .onChange(of: ExpensesA) {
            //                    save()
            //                    load()
            //                }
            //                .onAppear() {
            //                    save()
            //                    load()
            //                }
            //
            //                .refreshable {
            //                    save()
            //                    load()
            //                }
            
            .sheet(isPresented: $showsheet)  {
                NavigationStack {
                    VStack {
                        List {
                            TextField("Expense Name", text: $newitemfieldE)
                            
                            TextField("Amount", value: $newitemfieldE2, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                            
                        }
                        
                        .navigationTitle("New Entry")
                        .toolbar{
                            Button("add") {
                                
                                
                                
                                Expenses.append(newitemfieldE)
                                
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
    
    
    
    //        func save() -> Void {
    //            let tempE = ExpensesA.joined(separator: "/[splitE]/")
    //            let keyE = UserDefaults.standard
    //            keyE.set(tempE, forKey: "ExpensesE")
    //        }
    //
    //
    //        func load() -> Void {
    //            let keyE = UserDefaults.standard
    //            let tempE = keyE.string(forKey: "ExpensesE") ?? ""
    //            let temparrayE = tempE.components(separatedBy: "/[splitE]/")
    //            ExpensesA = temparrayE
    //        }
    //    }
    
}
    

#Preview {
    Expenses()
}
