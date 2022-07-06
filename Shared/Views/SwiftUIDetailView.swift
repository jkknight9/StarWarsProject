//
//  SwiftUIDetailView.swift
//  StarWarsProject
//
//  Created by Jack Knight on 7/5/22.
//

import SwiftUI

struct SwiftUIDetailView: View {
    @ObservedObject var individual: Individual
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Spacer()
            AsyncImage(url: URL(string: individual.profilePicture ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .shadow(color: Color.black.opacity(0.5), radius: 30, x: 0, y: 30)
            .frame(width: UIScreen.main.bounds.width, alignment: .center)
            
            
            Text("\(individual.affiliation?.replacingOccurrences(of: "_", with: " ") ?? "")")
                .font(.largeTitle)
            
            if individual.forceSensitive {
                Text("\(individual.firstName ?? "") is sensitive to the force!")
            }
            
            let bday = Date().formatDate(individual.birthdate)
            Text("Born on: \(bday)")
            Spacer()
        }
        .navigationBarTitle(Text("\(individual.firstName ?? "") \(individual.lastName ?? "")"), displayMode: .inline)
    }
}
