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
        HStack() {
            Circle()
                .fill(Color.orange)
                .frame(width: 64, height: 64, alignment: .center)
            Text(character.firstName + " " + character.lastName)
                .font(.title3)
            Spacer()
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(character: Person[0])
    }
}
