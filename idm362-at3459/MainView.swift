import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "bgColorApp")
        UITabBar.appearance().shadowImage = UIImage()
            UITabBar.appearance().backgroundImage = UIImage()
    }
  
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
    .tint(Color("groupTitleColor"))
  }
}

#Preview {
  MainView()
}
