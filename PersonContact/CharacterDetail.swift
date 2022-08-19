//
//  CharacterDetail.swift
//  PersonContact
//
//  Created by Saqib Siddique on 2022-08-19.
//

import SwiftUI

struct CharacterDetail: View {
    @State private var userName: String = ""
    @State private var id: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    var character: User
    @State var array: [User] = {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("data.json")
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let items = try decoder.decode([User].self, from: data)
            return items
        } catch {
            print(error.localizedDescription)
            return []
        }
    }()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack(alignment: .center) {
            Circle()
                .fill(Color.orange)
                .frame(width: 128, height: 128, alignment: .center)
                .padding(.bottom)
            Form {
                Section(header: Text("Main Information")) {
                    HStack {
                        CharacterInfoRow(icon: "", title: "Firstname", value: character.firstName)
                    }
                    HStack {
                        CharacterInfoRow(icon: "", title: "Lastname", value: character.lastName)
                    }
                }
                Section(header: Text("Sub Information")) {
                    HStack {
                        CharacterInfoRow(icon: "", title: "Email", value: character.email ?? "")
                    }
                    HStack {
                        CharacterInfoRow(icon: "", title: "Phone", value: character.phone ?? "")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
            }
        }
        .accentColor(.orange)
    }
}

struct CharacterInfoRow: View {
    var icon: String
    var title: String
    @State var value: String = ""
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .foregroundColor(.accentColor)
            Text(title)
                .font(.body)
                .foregroundColor(.accentColor)
            Spacer()
            
            TextField("",text: $value)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: Person[0])
    }
}

