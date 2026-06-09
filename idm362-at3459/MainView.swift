import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      ContentView()
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
      
      AboutView()
        .tabItem {
          Label("About", systemImage: "info.circle.fill")
        }
    }
    .tabViewStyle(.sidebarAdaptable)
    .tint(Color("groupTitleColor"))
  }
}

#Preview {
  MainView()
}
