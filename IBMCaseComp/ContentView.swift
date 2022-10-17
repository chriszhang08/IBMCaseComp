//
//  ContentView.swift
//  IBMCaseComp
//
//  Created by Angelina Ilijevski on 10/14/22.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var asset: String
    var color: String
}

var groups = [Category(name: "Individual Contributor", asset: "individual_contributor", color: "yellow"), Category(name: "Small Business", asset: "small_business", color: "coral"), Category(name: "Big Business", asset: "big_business", color: "blue"), Category(name: "Charitable Organization", asset: "charitable_organization", color: "green")]

struct Square: View {
    var color: String
    var icon: String
    var text: String
    @Binding var selectedItem: String
    var body: some View {
        
        HStack(spacing:20){
            Image(icon)
                .resizable()
                .frame(width: 35, height: 35)
            
            Text(text)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
    
            if selectedItem == text{
                Image(systemName: "checkmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.trailing, 5)
            }
            
        }.padding().background(RoundedRectangle(cornerRadius: 45).fill(Color.white.opacity(selectedItem == text ? 0.55 : 0.3)).shadow(color: .white.opacity(selectedItem == text ? 0.6 : 0.0), radius: 20, x: 3, y: 3))
            .padding(.horizontal).padding(.vertical,8)
        
        

    }
}

struct SelectionList: View {
    @Binding var selectedItem: String
    var body: some View{
        VStack{
            ForEach(groups, id: \.self){ i in
                Button(action: {
                    withAnimation{selectedItem = i.name}
                }){
                    Square(color: i.color, icon: i.asset, text: i.name, selectedItem: $selectedItem)
                }
                    
            }

        }
    }
}

struct Background: View{
    var body: some View{
        LinearGradient(colors: [Color.cyan.opacity(0.5), Color.purple.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)

        Circle()
            .frame(width: 300)
            .foregroundColor(Color("sea").opacity(0.3))
            .blur(radius: 10)
            .offset(x: -100, y: -150)

        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .frame(width: 500, height: 500)
            .foregroundStyle(LinearGradient(colors: [Color("blush").opacity(0.6), Color.mint.opacity(0.5)], startPoint: .top, endPoint: .leading))
            .offset(x: 300)
            .blur(radius: 30)
            .rotationEffect(.degrees(30))

        Circle()
            .frame(width: 450)
            .foregroundStyle(Color("pink").opacity(0.6))
            .blur(radius: 20)
            .offset(x: 200, y: -200)
        
        Circle()
            .frame(width: 430)
            .foregroundStyle(Color("yellow").opacity(0.3))
            .blur(radius: 20)
            .rotationEffect(.degrees(145))
            .offset(x: -190, y: 360)
    }
}

struct ContentView: View{
    @State var selectedItem: String = "Individual Contributor"
    @State var nextPage: Bool = false
    var body: some View{
        NavigationView{
            ZStack{
                ZStack {
                    Background()
                    VStack {
                        Text("Which category best describes you?")
                            .bold()
                            .font(.system(size: 30))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                        SelectionList(selectedItem: $selectedItem)
                        
                        Button(action:{
                            withAnimation{
                                self.nextPage.toggle()
                            }
                        }){
                            HStack{
                                Image(systemName: "arrow.forward").foregroundColor(.black)
                                    .font(.system(size: 30, weight: .bold))
                                
                            }.padding()
                                .background(Circle().fill(Color.white.opacity(0.9)))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 15)
                            
                        }.padding(.top)
                        
                        Spacer()
                    }.padding(.top, 130).padding(.horizontal, 50)
                }
                .edgesIgnoringSafeArea(.all)
                if nextPage{
                    //LottieView().edgesIgnoringSafeArea(.all)
                        
                    BodyView().transition(AnyTransition.asymmetric(
                        insertion: AnyTransition.opacity.animation(Animation.default.delay(0.75)),
                        removal: AnyTransition.opacity))
                }
            }
        }
    }
}

struct Business: Identifiable, Hashable {
    var id = UUID()
    var companyName: String
    var amountContributed: Double
    var icon: String
}

var local_businesses = [Business(companyName: "Builders LLC", amountContributed: 0.87, icon: "buildtool"), Business(companyName: "Local Woodworks", amountContributed: 0.35, icon: "wood"), Business(companyName: "Painters Delight", amountContributed: 0.97, icon: "paint")]
struct LocalBusinessesList: View {
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(local_businesses, id: \.self){i in
                    HStack(spacing:15){
                        Image(i.icon)
                            .resizable()
                            .frame(width: 35, height: 35)
                        VStack(spacing:5){
                            Text(i.companyName)
                                .font(.custom("Lora-Medium", size: 17))
                                .foregroundColor(.black)
                                
                                
                               
                            Text("+ $" + "\(i.amountContributed)")
                                .font(.subheadline)
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.vertical,2)
                                .background(RoundedRectangle(cornerRadius: 5).fill(Color("green")).frame(width:70))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading,8)
                        }
                    }.padding(.horizontal,15) .padding(.vertical,12).background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                }
            }.padding(.horizontal, 20)
        }
    }
}

struct NewsPosting: Identifiable, Hashable{
    var id = UUID()
    var title: String
    var description: String
    var image: String
}

var news_items = [NewsPosting(title: "Local Woodworks to Provide 100k in Supplies to Fresh Markets", description: "It's the time of year where the crops are at high yield and local farmers are looking for ways to put their products on the market. One of the most difficult parts of this process is finding the supplies to setup their selling of goods.", image: "news1"), NewsPosting(title: "Timeless Books Go On Sale at The Neighbor's Bookkeeper", description: "The newest hot spot for old books is now right around the corner! The Smiths' are opening up to share their history, heritage, and love for a good read. With thousands of books to choose from, customers are lining up at the door.", image: "bookstore")]
struct LocalNews: View{
    var body : some View{
        VStack(spacing: 15){
            ForEach(news_items, id: \.self){i in
                Image(i.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width*0.9, height: 225)
                    .clipped()
                    .cornerRadius(15)
                    .overlay(
                        VStack{
                            Spacer()
                            VStack(spacing:8){
                                Text(i.title)
                                    .font(.custom("Avenir", size: 16))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(i.description)
                                    .font(.custom("Lora-Regular", size: 12))
                                    .lineLimit(2)
                                    
                                HStack(spacing:5){
                                    Spacer()
                                    Group{
                                        Text("Read More")
                                            .font(.custom("Lora-Medium", size: 12))
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                        Image(systemName: "chevron.right")
                                            .font(.system(size:10, weight: .semibold))
                                    }
                                }
                            }.padding(.horizontal,15).padding(.vertical,15).frame(maxWidth: .infinity, alignment: .leading).background(RoundedRectangle(cornerRadius: 0).fill(Color.white.opacity(0.8)))
                            
                        }
                    )
            }
        }.padding(.bottom,20)
        
    }
}

var tabs = ["funding", "inbox", "home", "favorites", "profile"]

//tab button...
struct TabButton : View {
    
    var image : String
    @Binding var selectedTab : String
    
    var body: some View {
        
        Button(action: {selectedTab = image}) {
         
            Image(image)
                .resizable()
                .frame(width: 27, height: 27)
                .opacity(selectedTab == image ? 1 : 0.4)
                .padding(10)
                .padding(.horizontal, 5)
            
        }
    }
    
}


struct Home: View {
    // TODO: change to binding var?
    var selected_category: String
    
    @Binding var nextPage: Bool
    var body: some View{
        
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 10){
                    HStack{
                        Group{
                            Text("Hello,")
                                .font(.custom("Lora-Medium", size: 24))
                                .foregroundColor(.black)
                                
                            Text("Angela")
                                .font(.custom("Lora-MediumItalic", size: 24))
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .bold()
                                .font(.system(size: 27, weight: .regular))
                        }
                        
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(9)
                            .background(Circle().fill(Color.gray.opacity(0.15)))
                    }.padding(.horizontal,20)
                    
                    Text("You Recently Funded")
                        .font(.custom("Avenir", size: 18))
                        
                        .foregroundColor(.black)
                        //.font(.title3)
                        //.fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                    
                    LocalBusinessesList()
                    
                    Text("Local News")
                        .font(.custom("Avenir", size: 18))
                        
                        .foregroundColor(.black)
                        //.font(.title3)
                        //.fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.vertical,10)
                    
                    LocalNews()
                    
                    
                    
                }
            }
            
        }.frame(width:UIScreen.main.bounds.width)
        .background(Color("offWhite").ignoresSafeArea())
    }
}

struct BodyView: View{
    @State var selectedTab = "home"
    @State var selected_category: String = "individual contributor"
    @State var nextPage = false
    var body: some View{
        VStack{
            Spacer()
            TabView(selection: $selectedTab){
                FundingPage()
                    .tag("funding")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                
                Inbox()
                    .tag("inbox")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                
                Home(selected_category: selected_category, nextPage: $nextPage)
                    .tag("home")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                
                Favorites()
                    .tag("favorites")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                
                Profile()
                    .tag("profile")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea(.all, edges: .bottom)
            
            
            HStack(spacing: -18) {
                
                ForEach(tabs, id: \.self) { image in
                    
                    TabButton(image: image, selectedTab: $selectedTab)
                        .frame(width: 50, height: 25)
                        .padding()
                    
                    //equal spacing...
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                    
                }
            }.offset(y:10).edgesIgnoringSafeArea(.bottom)
                .background(Color.white.edgesIgnoringSafeArea(.bottom))
                .shadow(color: .gray.opacity(0.1), radius: 15)
        }.frame(width:UIScreen.main.bounds.width).background(Color("offWhite"))
    }
}

struct Loader: View {
    var body: some View{
        LottieView().frame(width:100, height:100, alignment: .center)
    }
}
struct FundingPage: View {
    var body: some View{
        ZStack{
            VStack{
                
                HStack{
                    Text("My Analytics")
                        .font(.custom("Avenir", size: 22))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Group{
                            Image(systemName: "chevron.down")
                                .font(.system(size: 15))
                            Text("This Month")
                                .font(.custom("Avenir", size: 16))
                                .fontWeight(.medium)
                            
                        }}.padding(.horizontal, 9).padding(.vertical, 5).background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                }
                
                Text("Daily Donations")
                    .font(.custom("Avenir", size: 16)).fontWeight(.semibold).italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Analytics().padding(.top,3)
                
             
                HStack(spacing:0){
                    VStack(spacing:5){
                        Text("Total No. Donations")
                            .font(.custom("Avenir", size: 15))
                            .foregroundColor(.black.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing:15){
                            Text("54")
                                .font(.system(size: 17))
                                .bold()
                                
                            HStack(spacing:3){
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("green"))
                                Text("5% this month")
                                    .font(.custom("Avenir", size: 13))
                                    .foregroundColor(Color("green"))
                                
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing:5){
                        
                        Text("Total Value")
                            .font(.custom("Avenir", size: 15))
                            .foregroundColor(.black.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 15){
                            
                            Text("$27.36")
                                .font(.system(size: 17))
                                .bold()
                            
                                HStack(spacing:3){
                                    Image(systemName: "arrow.down")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.red)
                                    
                                Text("2% this month")
                                    .font(.custom("Avenir", size: 13))
                                    .foregroundColor(Color.red)
                                
                            }
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                    
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }.padding(.top,1)
                
                VStack{
                    Text("Funded Organizations")
                        .font(.custom("Avenir", size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            
                        }
                    }
                }.padding(.top,10)
                
                Spacer()
            }.padding(.horizontal,20)
            
            
            //Loader()
        }.frame(width:UIScreen.main.bounds.width).background(Color("offWhite"))
    }
}

struct Org: View{
    
    var body: some View{
        VStack{
            
        }
        .background(RoundedRectangle(cornerRadius: 10))
    }
}
struct Inbox: View {
    var body: some View{
        VStack{
            //do
        }
    }
}

struct Favorites: View {
    var body: some View{
        VStack{
            //do
        }
    }
}

struct Profile: View {
    var body: some View{
        VStack{
            //do
        }
    }
}
/*struct ContentView: View {
    let rows = [
        GridItem(.fixed(80), spacing: 30, alignment: .center),
        GridItem(.fixed(80), spacing: 30, alignment: .center)
    ]
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [ Color("glacier").opacity(0.9), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack(spacing:60){
                Text("Which category best describes you?")
                    .bold()
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                SelectionList()
                Spacer()
            }.padding(.top, 130)
        }.edgesIgnoringSafeArea(.all)
    }
}*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //Selector(selected_category: "individual contributor")
        //BodyView()
        FundingPage()
        //ContentView()
    }
}
