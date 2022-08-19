//
//  CharacterRow.swift
//  PersonContact
//
//  Created by Saqib Siddique on 2022-08-19.
//

import SwiftUI

struct CharacterRow: View {
    var character: User
       var body: some View {
           
           HStack {
               HStack() {
                   Image("icon")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 32.0, height: 32.0)
                   Text("\(character.firstName)\(character.lastName)")
                       .font(.title3)
               }
               
               Spacer()
           }.padding()
       }
   }

   struct CharacterRow_Previews: PreviewProvider {
       static var previews: some View {
           CharacterRow(character: Person[0])
       }
   }
