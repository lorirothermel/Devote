//
//  ContentView.swift
//  Devote
//
//  Created by Lori Rothermel on 6/21/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
   

    

        
    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
       
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    
    
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Main View
                VStack {
               // MARK: - Header
                    HStack(spacing: 10) {
                        // MARK: - Title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        // MARK: - Edit Button
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )  // .background
                        
                        // MARK: - Appearance Button
                        Button {
                            // Toggle Appearance
                            isDarkMode.toggle()
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }  // Button
                        
                    }  // HStack
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    
               // MARK: - New Task Button
                    Button {
                        showNewTaskItem = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }  // Button
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )  // .background
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
               // MARK: - Tasks
                    
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }  // ForEach
                        .onDelete(perform: deleteItems)
                    }  // List
                    .listStyle(.insetGrouped)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }  // VStack
                
                // MARK: - New Task Item
                if showNewTaskItem {
                    BlankView()
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }  // withAnimation
                        }  // .onTapGesture
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }  // if
                                
            }  // ZStack
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
            )  // .background
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        }  // NavigationStack
        .navigationViewStyle(.stack)
        .scrollContentBackground(.hidden)
        
    }  // some View
}  // ContentView


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
