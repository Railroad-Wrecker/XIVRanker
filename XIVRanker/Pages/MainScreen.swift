/*
  RMIT University Vietnam
  Course: COSC2659|COSC2813 iOS Development
  Semester: 2024B
  Assessment: Assignment 1
  Author: Nguyen Ngoc Luong
  ID: S3927460
  Created  date: 01/08/2024
  Last modified: 05/08/2024
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct MainScreen: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var searchText = ""
    @State private var selectedFilter: String = "All"
    @Environment(\.colorScheme) var colorScheme

    let filters = ["All", "Expansions", "Patch", "Trial", "Raid", "Event"]

    var body: some View {
        TabView { // Use TabView to include other views as tabs
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        // Search bar
                        HStack {
                            TextField("Search...", text: $searchText)
                                .padding(.leading, 36)
                                .padding(.vertical, 10)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .overlay(
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 12)
                                        Spacer()
                                    }
                                )
                            
                            Spacer()
                            
                            // Dark/Light mode toggle button
                            Button(action: {
                                isDarkMode.toggle()
                            }) {
                                Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                        .padding(.horizontal)
                        
                        // Recommended section
                        Text("Recommended")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.bottom, 4)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(expansions) { item in
                                    NavigationLink(destination: DetailView(
                                        image: item.imageName,
                                        title: item.title,
                                        author: "Krusky Tank",
                                        date: "Aug 1, 2024",
                                        tag: item.tag,
                                        rating: item.rating, // Ensure you have this property in your data model
                                        link: item.link,     // Ensure you have this property in your data model
                                        description: item.description // Ensure you have this property in your data model
                                    )) {
                                        PlacesCardView(expansion: item)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 4)
                        }
                        
                        // Filters
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 4) {
                                ForEach(filters, id: \.self) { filter in
                                    FilterButton(title: filter, isSelected: filter == selectedFilter) {
                                        selectedFilter = filter
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 4)
                        }
                        
                        // Blog list
                        VStack(alignment: .leading) {
                            ForEach(blogItems.filter { selectedFilter == "All" || $0.tag == selectedFilter }) { item in
                                NavigationLink(destination: DetailView(
                                    image: item.image,
                                    title: item.title,
                                    author: item.author,
                                    date: item.date,
                                    tag: item.tag,
                                    rating: item.rating,           // Include rating
                                    link: item.link,               // Include link
                                    description: item.description  // Include description
                                )) {
                                    BlogListItem(
                                        image: item.image,
                                        title: item.title,
                                        author: item.author,
                                        date: item.date,
                                        tag: item.tag,
                                        rating: item.rating,
                                        link: item.link
                                        
                                    )
                                }
                                .padding(.bottom, 4)
                            }
                        }

                        .padding(.horizontal)
                    }
                    .padding(.top, 8)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "house")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Circle().fill(Color.blue))
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                Text("Home")
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}


struct BlogItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let author: String
    let date: String
    let tag: String
    let rating: Double
    let link: String
    let description: String
}

let blogItems = [
    // Expansions
    BlogItem(image: "DawnTrail_Image", title: "Dawntrail - Final Fantasy XIV Latest Expansion!", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Expansions", rating: 4.5, link: "https://www.youtube.com/watch?v=kgiuQwzB6aU", description: "The Dawntrail expansion introduces a plethora of new content, including a fresh storyline, expanded world areas, and engaging new mechanics. Players will find themselves exploring novel environments, encountering unique challenges, and delving into an intricate narrative that further enriches the Final Fantasy XIV universe. This expansion sets a new benchmark for content richness and player engagement."),
    
    BlogItem(image: "EndWalker_Image", title: "Endwalker - The End of a Journey!", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Expansions", rating: 4.8, link: "https://www.youtube.com/watch?v=zTTtd6bnhFs", description: "Endwalker marks the epic conclusion of a long-running story arc in Final Fantasy XIV. With a gripping narrative that ties together numerous plot threads, players are treated to an emotional and impactful finale. The expansion features significant updates to gameplay mechanics, new dungeons, and raids, offering a satisfying closure to the saga while laying the groundwork for future adventures."),
    
    BlogItem(image: "ShadowBringer_Image", title: "Shadowbringers - A New Era Begins!", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Expansions", rating: 4.7, link: "https://www.youtube.com/watch?v=kgiuQwzB6aU", description: "Shadowbringers ushers in a transformative era for Final Fantasy XIV, introducing a new world and a host of compelling characters. The expansion's narrative is both expansive and deep, presenting players with challenging new content and engaging storylines. It broadens the game's universe with innovative features and settings, solidifying its place as a standout chapter in the series."),
    
    BlogItem(image: "Heavensward_Image", title: "Heavensward - The Battle Rages On!", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Expansions", rating: 4.6, link: "https://www.youtube.com/watch?v=4phUCJlomPo", description: "Heavensward continues the epic saga of Final Fantasy XIV, intensifying the battle against dark forces. The expansion enriches the game's lore with its medieval-inspired themes and introduces thrilling new content, including expansive new zones and intricate dungeons. The narrative depth and gameplay innovations make it a notable addition to the Final Fantasy XIV experience."),
    
    BlogItem(image: "RealmReborn_Image", title: "A Realm Reborn - The New Beginning!", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Expansions", rating: 4.4, link: "https://www.youtube.com/watch?v=39j5v8jlndM", description: "A Realm Reborn signifies a fresh start for Final Fantasy XIV, rebuilding from the ground up with improved graphics, enhanced mechanics, and a revitalized storyline. This expansion sets the stage for the game's future with its substantial overhaul and engaging new content, inviting both new and returning players to explore its vast, beautifully crafted world."),
    
    BlogItem(image: "StormBlood_Image", title: "Stormblood - The Fight for Freedom!", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Expansions", rating: 4.5, link: "https://www.youtube.com/watch?v=Jt1h1MinlLI", description: "Stormblood introduces players to a world in turmoil as the fight for freedom takes center stage. The expansion's robust narrative and new gameplay features immerse players in a tale of rebellion and liberation. With its rich storytelling and challenging new content, Stormblood adds significant depth to the Final Fantasy XIV universe."),
    
    // Patches for A Realm Reborn
    BlogItem(image: "Patch_2_1_Image", title: "Patch 2.1 - A Realm Awoken", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.0, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Patch 2.1 - A Realm Awoken rejuvenates A Realm Reborn with new content and features. It enhances the game's experience with additional quests, updated mechanics, and refined gameplay elements. This patch lays the groundwork for future updates, ensuring a richer and more engaging gameplay experience."),
    
    BlogItem(image: "Patch_2_2_Image", title: "Patch 2.2 - Through the Maelstrom", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.1, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Through the Maelstrom, Patch 2.2 expands on the foundational content of A Realm Reborn with significant updates and new challenges. Players encounter new storylines, dungeons, and features that build upon the established world, offering a more immersive and diverse gameplay experience."),
    
    BlogItem(image: "Patch_2_3_Image", title: "Patch 2.3 - Defenders of Eorzea", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.2, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Defenders of Eorzea brings a host of new content and improvements to A Realm Reborn. This patch introduces fresh storylines, new dungeons, and enhanced gameplay features, enriching the overall player experience and deepening the engagement with the game's world."),
    
    BlogItem(image: "Patch_2_4_Image", title: "Patch 2.4 - Dreams of Ice", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.3, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Patch 2.4 - Dreams of Ice continues to expand A Realm Reborn with additional content and gameplay updates. Players can look forward to new features, improved mechanics, and a richer storyline that further enhances the game's depth and appeal."),
    
    BlogItem(image: "Patch_2_5_Image", title: "Patch 2.5 - Before the Fall", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.4, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Before the Fall advances the narrative with new content and updates. This patch continues the engaging story of A Realm Reborn while introducing fresh challenges and gameplay improvements that keep the experience exciting and dynamic."),
    
    // Patches for Heavensward
    BlogItem(image: "Patch_3_1_Image", title: "Patch 3.1 - As Goes Light, So Goes Darkness", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.0, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Patch 3.1 - As Goes Light, So Goes Darkness enriches Heavensward with new content and features. This update continues the expansion's dark and engaging storyline while offering players new challenges and enhancements that deepen their immersion in the game."),
    
    BlogItem(image: "Patch_3_2_Image", title: "Patch 3.2 - The Gears of Change", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.1, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "The Gears of Change, Patch 3.2, introduces significant updates and new features to Heavensward. Players will experience fresh content that enhances the existing gameplay and narrative, providing a more comprehensive and engaging experience."),
    
    BlogItem(image: "Patch_3_3_Image", title: "Patch 3.3 - Revenge of the Horde", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.2, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Revenge of the Horde continues the Heavensward saga with new content and updates. This patch brings additional story elements, challenges, and gameplay enhancements that further develop the expansion's narrative and player engagement."),
    
    BlogItem(image: "Patch_3_4_Image", title: "Patch 3.4 - Soul Surrender", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.3, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Soul Surrender introduces new features and content to Heavensward. This update continues the expansion's gripping storyline while providing players with fresh challenges and gameplay improvements, ensuring a deeper and more engaging experience."),
    
    BlogItem(image: "Patch_3_5_Image", title: "Patch 3.5 - The Far Edge of Fate", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.4, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "The Far Edge of Fate advances the Heavensward expansion with new updates and content. This patch introduces additional storylines, features, and enhancements that enrich the player's experience and continue the expansion's narrative."),
    
    // Patches for Stormblood
    BlogItem(image: "Patch_4_1_Image", title: "Patch 4.1 - The Legend Returns", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.0, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "The Legend Returns brings new content and updates to Stormblood. This patch continues the expansion's epic story with additional features and challenges, enhancing the overall player experience and engagement."),
    
    BlogItem(image: "Patch_4_2_Image", title: "Patch 4.2 - Rise of a New Sun", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.1, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Rise of a New Sun introduces exciting new features and content to Stormblood. This update expands the expansion's narrative and gameplay with fresh challenges and improvements, offering players a deeper and more immersive experience."),
    
    BlogItem(image: "Patch_4_3_Image", title: "Patch 4.3 - Under the Moonlight", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.2, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Under the Moonlight continues the Stormblood story with new updates and content. This patch provides additional storylines, features, and gameplay enhancements that further enrich the player's adventure."),
    
    BlogItem(image: "Patch_4_4_Image", title: "Patch 4.4 - Prelude in Violet", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.3, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Prelude in Violet brings new content and features to Stormblood. This patch continues the expansion's engaging story with additional updates and enhancements that provide a richer and more dynamic gameplay experience."),
    
    BlogItem(image: "Patch_4_5_Image", title: "Patch 4.5 - A Requiem for Heroes", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.4, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "A Requiem for Heroes advances the Stormblood expansion with new updates and content. This patch adds to the expansion's narrative and gameplay with fresh challenges and features that further engage players."),
    
    // Patches for Shadowbringers
    BlogItem(image: "Patch_5_1_Image", title: "Patch 5.1 - Vows of Virtue, Deeds of Cruelty", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.0, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Vows of Virtue, Deeds of Cruelty introduces new content and features to Shadowbringers. This update enhances the expansion with fresh storylines, challenges, and gameplay improvements that deepen the player's experience."),
    
    BlogItem(image: "Patch_5_2_Image", title: "Patch 5.2 - Echoes of a Fallen Star", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.1, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Echoes of a Fallen Star continues the Shadowbringers story with new features and content. This patch expands the narrative and gameplay with additional challenges and improvements that enrich the player's adventure."),
    
    BlogItem(image: "Patch_5_3_Image", title: "Patch 5.3 - Reflections in Crystal", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.2, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Reflections in Crystal introduces new updates and content to Shadowbringers. This patch enhances the expansion with fresh storylines, features, and gameplay improvements that provide a deeper and more engaging experience."),
    
    BlogItem(image: "Patch_5_4_Image", title: "Patch 5.4 - Futures Rewritten", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.3, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Futures Rewritten brings new content and features to Shadowbringers. This update continues the expansion's engaging story with additional challenges and enhancements that enrich the overall player experience."),
    
    BlogItem(image: "Patch_5_5_Image", title: "Patch 5.5 - Death Unto Dawn", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.4, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Death Unto Dawn advances the Shadowbringers expansion with new updates and content. This patch continues the expansion's epic storyline with fresh challenges and features, providing a deeper and more immersive experience."),
    
    // Patches for Endwalker
    BlogItem(image: "Patch_6_1_Image", title: "Patch 6.1 - Newfound Adventure", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.0, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Newfound Adventure introduces new content and features to Endwalker. This update enriches the expansion with additional storylines, gameplay enhancements, and fresh challenges, offering a more comprehensive and engaging experience."),
    
    BlogItem(image: "Patch_6_2_Image", title: "Patch 6.2 - Buried Memory", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.1, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Buried Memory continues the Endwalker story with new updates and content. This patch expands the narrative with additional features and gameplay improvements, providing a richer and more immersive player experience."),
    
    BlogItem(image: "Patch_6_3_Image", title: "Patch 6.3 - Gods Revel, Lands Tremble", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.2, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Gods Revel, Lands Tremble introduces new features and content to Endwalker. This update continues the expansion's epic storyline with fresh challenges and enhancements, deepening the player's engagement and experience."),
    
    BlogItem(image: "Patch_6_4_Image", title: "Patch 6.4 - The Dark Throne", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.3, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "The Dark Throne brings new content and updates to Endwalker. This patch continues the expansion's narrative with additional features and gameplay improvements, offering players a more dynamic and engaging experience."),
    
    BlogItem(image: "Patch_6_5_Image", title: "Patch 6.5 - Growing Light", author: "Krusky Tank", date: "Aug 1, 2024", tag: "Patch", rating: 4.4, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Growing Light continues the Endwalker adventure with new features and content. This update enhances the expansion with fresh storylines, challenges, and gameplay improvements, providing a richer and more immersive player experience.")
]


struct Expansion: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let tag: String
    let rating: Double
    let link: String
    let description: String
}

let expansions = [
    Expansion(imageName: "DawnTrail_Image", title: "Dawntrail - Final Fantasy XIV Latest Expansion!", tag: "Expansions", rating: 4.5, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "The latest expansion brings new content and adventures to Final Fantasy XIV."),
    Expansion(imageName: "EndWalker_Image", title: "Endwalker - The End of a Journey!", tag: "Expansions", rating: 4.7, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Endwalker concludes the current story arc with epic events and new challenges."),
    Expansion(imageName: "ShadowBringer_Image", title: "Shadowbringers - A New Era Begins!", tag: "Expansions", rating: 4.6, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Shadowbringers introduces a dark and exciting new chapter to the game."),
    Expansion(imageName: "Heavensward_Image", title: "Heavensward - The Battle Rages On!", tag: "Expansions", rating: 4.4, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Heavensward expands the world of Final Fantasy XIV with intense battles and new storylines."),
    Expansion(imageName: "RealmReborn_Image", title: "A Realm Reborn - The New Beginning!", tag: "Expansions", rating: 4.3, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "A Realm Reborn revitalizes the game with a fresh start and exciting new content."),
    Expansion(imageName: "StormBlood_Image", title: "Stormblood - The Fight for Freedom!", tag: "Expansions", rating: 4.5, link: "https://na.finalfantasyxiv.com/lodestone/special/patchnote_log/", description: "Stormblood brings revolutionary changes and content to the game, focusing on the struggle for freedom.")
]


struct PlacesCardView: View {
    var expansion: Expansion
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GlassMorphicCard()
            
            VStack(alignment: .leading) {
                Image(expansion.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                
                Text(expansion.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .padding(.leading, 8)
                    .padding(.top, 8)
                    .padding(.trailing, 8)
                
                Text("By: Krusky Tank")
                    .font(.subheadline)
                    .opacity(0.7)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.leading, 8)
                    .padding(.top, 4)
                
                Text("Aug 5, 2024")
                    .font(.caption)
                    .opacity(0.7)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.leading, 8)
                    .padding(.top, 2)
                
                Spacer()
            }
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(width: 300, height: 310)

            
            Text(expansion.tag)
                .font(.caption)
                .fontWeight(.bold)
                .padding(8)
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding([.top, .leading], 16)
        }
    }
    
    @ViewBuilder
    func GlassMorphicCard() -> some View {
        ZStack {
            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in }
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .frame(width: 300, height: 310) // Adjusted height to match card frame
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.6, green: 0.8, blue: 1.0), Color(red: 0.3, green: 0.6, blue: 1.0)]), // Light blue gradient colors
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(10)
            .opacity(0.66)
            .shadow(radius: 10)
        )
    }
}

struct CustomBlurView: UIViewRepresentable {
    var effect: UIBlurEffect.Style
    var onChange: (UIVisualEffectView) -> ()

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: effect))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            onChange(uiView)
        }
    }
}

struct FilterButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(isSelected ? Color.blue : Color.primary)
        }
    }
}

struct BlogListItem: View {
    let image: String
    let title: String
    let author: String
    let date: String
    let tag: String
    let rating: Double
    let link: String

    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Image(image).resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .cornerRadius(8)

                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        
                        Text("By: \(author)")
                            .font(.subheadline)
                            .opacity(0.7)
                        
                        Text(date)
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(tag)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                    }
                    .padding(.leading, 8)

                    Spacer()
                }
                .padding(.vertical, 8)
                
                Divider()
            }
        }
    }



struct DetailView: View {
    let image: String
    let title: String
    let author: String
    let date: String
    let tag: String
    let rating: Double
    let link: String
    let description: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .padding(.bottom, 8)
                
                // Title
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)
                
                // Author and Date
                HStack {
                    Text("by \(author)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 4)
                
                // Tag
                Text(tag)
                    .font(.caption)
                    .foregroundColor(.blue)
                
                // Rating
                Text("Rating: \(String(format: "%.1f", rating))/5")
                    .font(.headline)
                    .padding(.bottom, 4)
                
                // Description
                Text(description)
                    .font(.body)
                    .padding(.bottom, 8)
                
                Image("Youtube")
                    .resizable()
                    .frame(width: 50, height: 40)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if let url = URL(string: link) {
                            UIApplication.shared.open(url)
                        }
                    }
                
                // Spacer
                Spacer()
            }
            .padding()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


// Utility extension to get the current UIWindow
extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        if #available(iOS 15.0, *) {
            return connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return windows.first { $0.isKeyWindow }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

