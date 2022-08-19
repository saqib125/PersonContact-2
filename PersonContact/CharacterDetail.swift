//
//  CharacterDetail.swift
//  PersonContact
//
//  Created by Saqib Siddique on 2022-08-19.
//

import SwiftUI

struct CharacterDetail: View {
    @StateObject var dataManager = DataManager()
    @State private var userName: String = ""
    @State private var id: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
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
        Button("Save") {
            var newArray = array

                newArray.append(User(id: id, firstName: firstname, lastName: lastname))
                writeJSON(items: newArray)
            print("successfully")
          }
//        Button(action: {
//                       // Update array, just for testing update all userName
//            for i in dataManager.jsonArray.indices {
//            dataManager.jsonArray[i].firstName = userName
//                       }
//                       // save to file
//                       dataManager.saveToFile()
//                       print("Done")
//                   })
//                   {
//                       Text("Save")
//                   }
        VStack{
           
        Image("icon")
            .resizable()
            .frame(width:64.0,height:64.0)
        List {
          Section(header: Text("Main Information"), content: {

           CharacterInfoRow(icon: "icon", title: "Firstname", value: character.firstName)
           CharacterInfoRow(icon: "icon", title: "Lastname", value: character.lastName)
           })
           }
           .listStyle(GroupedListStyle())
        }
       // .navigationBarHidden(true)
//       .navigationBarItems(trailing: HeaderView(btn: "backbtn", title: "Save", action:{ presentationMode.wrappedValue.dismiss()}))
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

class DataManager: ObservableObject {
    @Published var jsonArray: [User] = []

    var fileName = "data"

    init() {
        readFromFile()
    }

    func readFromFile() {
        jsonArray = readJSONBundle(fileName)
    }

    private func readJSONBundle<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            print(file)
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

    func saveToFile() {
        do {
            let furl = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
                .appendingPathExtension("json")
            print("---> writing to: \(furl)")
            let data = try JSONEncoder().encode(jsonArray)
            try data.write(to: furl)
        } catch {
            print("---> error saveToFile: \(error)")
        }
    }

    func readJSON() {
        do {
            let furl = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
                .appendingPathExtension("json")
            print("---> reading from: \(furl)")
            let data = try Data(contentsOf: furl)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([User].self, from: data)
            jsonArray = jsonData
        } catch {
            print("---> error reading from file: \(error)")
        }
    }

}
