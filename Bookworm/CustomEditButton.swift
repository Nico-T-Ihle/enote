//
//  EditButton.swift
//  Bookworm
//
//  Created by Nico Ihle on 01.09.22.
//

import Foundation
import SwiftUI

struct CustomEditButton: View {
    @Environment(\.editMode) var editMode
    
    private var isEditing:Bool{
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View{
        Button( action: {
            editMode?.wrappedValue = isEditing ? .inactive : .active
        },
            label: {
            Image(systemName: isEditing ? "pencil.circle" : "pencil.circle")
                .resizable()
                .scaledToFit()
                .frame(height: 24)
        })
    }
}

struct EditButton_Previews: PreviewProvider{
    static var previews: some View{
        CustomEditButton()
    }
}
