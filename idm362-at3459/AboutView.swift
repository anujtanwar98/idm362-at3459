import SwiftUI

struct AboutView: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView()
                
                FeatureCard(icon: "dollarsign.circle.fill", title: "Smart Bill Splitting", description: "Easily split bills among friends, family, or colleagues. FairShare calculates who owes what, so you don't have to.")
                
                FeatureCard(icon: "list.bullet.rectangle.fill", title: "Itemized Expenses", description: "Add detailed, itemized expenses to your groups. Track exactly what was spent and who was involved.")
                
                FeatureCard(icon: "person.2.fill", title: "Flexible Group Participation", description: "Not everyone involved in every expense? No problem! Easily include or exclude people from specific expenses within a group.")
                
                FeatureCard(icon: "function", title: "Precise Calculations", description: "FairShare accurately calculates individual contributions, considering partial participation in expenses.")
                
                ExampleView()
            }
            .padding()
        }
        .background(Color("bgColorApp").edgesIgnoringSafeArea(.all))
//        .navigationTitle("About FairShare")
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: "dollarsign.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .foregroundColor(Color("memberColor"))
            
            Text("Welcome to FairShare")
                .font(.custom("AvenirNext-Bold", size: 28))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("groupTitleColor"))
            
            Text("The smart way to split expenses and keep track of shared costs.")
                .font(.custom("AvenirNext-Regular", size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("memberColor"))
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("memberColor"))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.custom("AvenirNext-DemiBold", size: 18))
                        .foregroundColor(Color("groupTitleColor"))
                    
                    Text(description)
                        .font(.custom("AvenirNext-Regular", size: 14))
                        .foregroundColor(Color("memberColor"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color("cardBgColor"))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

struct ExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How It Works")
                .font(.custom("AvenirNext-Bold", size: 22))
                .foregroundColor(Color("groupTitleColor"))
            
            Text("Imagine a group of 6 friends on a trip. For one meal, only 4 people participated. With FairShare, you can:")
                .font(.custom("AvenirNext-Regular", size: 14))
                .foregroundColor(Color("memberColor"))
            
            VStack(alignment: .leading, spacing: 8) {
                BulletPoint(text: "Create a group for the trip")
                BulletPoint(text: "Add the meal as an expense")
                BulletPoint(text: "Select only the 4 people who participated")
                BulletPoint(text: "FairShare will calculate the split only among those 4")
            }
            
            Text("This ensures fair and accurate expense tracking for everyone involved!")
                .font(.custom("AvenirNext-Regular", size: 14))
                .foregroundColor(Color("memberColor"))
        }
        .padding()
        .background(Color("cardBgColor"))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct BulletPoint: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.system(size: 14, weight: .bold))
            Text(text)
                .font(.custom("AvenirNext-Regular", size: 14))
        }
        .foregroundColor(Color("memberColor"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView()
        }
    }
}
