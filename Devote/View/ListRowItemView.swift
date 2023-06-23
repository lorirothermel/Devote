//
//  ListRowItemView.swift
//  Devote
//
//  Created by Lori Rothermel on 6/23/23.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? .pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default, value: item.task)
        }  // Toggle
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }  // if
        }  // .onReceive
        
    }  // some View
}  // ListRowItemView
