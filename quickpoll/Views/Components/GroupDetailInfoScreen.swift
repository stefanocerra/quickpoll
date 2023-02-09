//
//  GroupDetailInfoScreen.swift
//  quickpoll
//
//  Created by Stefano Cerra on 02.09.22.
//

import SwiftUI

struct GroupDetailInfoScreen: View {
    
    @EnvironmentObject var groupViewModel: GroupViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var qrData: Data?
    
    let group: PollGroup
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Fertig")
                        .foregroundColor(.accentColor)
                })
                .padding(.trailing)
                .padding(.top)
            }
            
            if let qrData = qrData, let uiImage = UIImage(data: qrData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.top)
            }
            
            Spacer()
        }
        .onAppear {
            qrData = groupViewModel.generateCode(text: group.code)
        }
    }
}

struct GroupDetailInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailInfoScreen(group: PollGroup(name: "Test", code: "asdf", users: ["asdf"]))
    }
}
