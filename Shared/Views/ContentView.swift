//
//  ContentView.swift
//  Shared
//
//  Created by Jack Knight on 7/5/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var characters = [StarWarsCharacter]()
    
    @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Individual.id, ascending: true)],
            animation: .default)
    
        var individuals: FetchedResults<Individual>
    
    var body: some View {
        NavigationView {
            List(individuals, id: \.id) { individual in
                NavigationLink(destination: SwiftUIDetailView(individual: individual)) {
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: individual.profilePicture ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .scaledToFit()
                            
                            Text("\(individual.firstName ?? "") \(individual.lastName ?? "")")
                                .font(.title)
                        }
                        Spacer()
                    }
                }
                .navigationTitle("Star Wars")
            }
            .onAppear() {
                StarWarsCharacters.shared.fetchStarWarsCharacters { result in
                    switch result {
                    case .success(let starWarsCharacters):
                        viewContext.perform {
                            mappingCoreData(characters: starWarsCharacters)
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // Convert a character to croe data indivdual
    func mappingCoreData(characters: [StarWarsCharacter]) {
        for character in characters {
            let individual = fetchIndividual(id: character.id)
            individual.id = Int64(character.id)
            individual.firstName = character.firstName
            individual.lastName = character.lastName
            individual.birthdate = character.birthdate
            individual.forceSensitive = character.forceSensitive
            individual.profilePicture =  character.profilePicture
            individual.affiliation = character.affiliation
        }
        try? viewContext.save()
    }
    
    /// Fetch request for a Star Wars individual
    func fetchIndividual(id: Int) -> Individual {
        let fetchRequest = Individual.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.sortDescriptors = []
        let fetchedIndividual = try? viewContext.fetch(fetchRequest).first
        return fetchedIndividual ?? Individual(context: self.viewContext)
    }
}
