//
//  ContentView.swift
//  Bookworm
//
//  Created by Nico Ihle on 23.08.22.
//

import SwiftUI
import UIKit
import CoreData
import SwiftUIFontIcon

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    //stuff form the database if you get the could not fine the scope try clean project
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    // for the core data
    @FetchRequest(sortDescriptors: []) var taskStore2: FetchedResults<Test>
    
    @AppStorage("newnewTask") var newnewTask : String  = ""
    
    @State private var isPressed = false
    
    var searchBar : some View{
        //HStack is horizontale ausrichtung
//        FontIcon.text(.materialIcon(code: .assistant), fontsize: 45, color: .blue)
        HStack{
            TextField("Insert new Task", text: self.$newnewTask)
            //self is like this
            Button(action: self.addnewnewTask, label: { Image(systemName: "plus.circle.fill").resizable()
                .frame(width: 50.0, height: 51.0)  } )
                .padding(1)
//                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                //.background(Color(red: 167 / 255, green: 193 / 255, blue: 217 / 255))
                .foregroundColor(.black)
                .cornerRadius(10)
                .opacity(isPressed ? 0.4 : 1.0)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .pressEvents{
                    withAnimation(.easeIn(duration: 0.2)) {
                        isPressed = true
                    }
                } onRelease: {
                    withAnimation{isPressed = false}
                }
            
//            Button("Button title") {
//                print("Button tapped!")
//            }
        }.textFieldStyle(OvalTextFieldStyle())
    }
    //Style Textfield
    struct OvalTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(20)
                .background(Color(red: 26 / 255, green: 26 / 255, blue: 26 / 255))
                .cornerRadius(10)
                .foregroundColor(.white)
        }
    }
    
    //Add a Function for the button
    func addnewnewTask () {
        let test = Test(context: moc)
        //The id is for each object Special so it wont replace the name from the db
        test.id = UUID();
        //The name from the db
        test.taskname = self.newnewTask
        
        try? moc.save()
    }
    
    let backgroundGradient = LinearGradient(
        colors: [Color(red: 157 / 255, green: 180 / 255, blue: 198 / 255), Color.white],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView{
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {
                    searchBar.padding()
                    List {
                        ForEach(taskStore2){
                            test in
                            Text(test.taskname ?? "Unknown").foregroundColor(Color(red: 157 / 255, green: 180 / 255, blue: 198 / 255))
                        }.onDelete(perform: deleteTask) .listRowBackground(Color.primary)
                        
                    }.navigationTitle("Enote ") .navigationBarTitleDisplayMode(.large)

                }.navigationBarItems( trailing: CustomEditButton() ) .padding(0)
            }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            let deleteTask = taskStore2[offset]
            moc.delete(deleteTask)
        }
        
        try? moc.save()
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
        }
    }
}
