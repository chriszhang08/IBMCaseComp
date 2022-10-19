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
    @Binding var showingProfile: Bool
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(local_businesses, id: \.self){i in
                    
                    Button(action:{
                        self.showingProfile.toggle()
                    }){
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

var tabs = ["funding", "allocations", "home", "favorites", "profile"]

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
    @State var showingProfile = false
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
                    
                    LocalBusinessesList(showingProfile: $showingProfile)
                        .onTapGesture {
                            self.showingProfile = true
                        }
                    Text("Local News")
                        .font(.custom("Avenir", size: 18))
                        
                        .foregroundColor(.black)
                        //.font(.title3)
                        //.fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.vertical,10)
                    
                    LocalNews()
                    
                    
                    
                    
                }.sheet(isPresented: $showingProfile){
                    BusinessProfile()
                }.presentationDetents([.fraction(0.2)])
            }
            
        }.frame(width:UIScreen.main.bounds.width)
        .background(Color("offWhite").ignoresSafeArea())
        
    }
}

struct BusinessProfile : View {
    
    var body: some View{
        Text("Builders LLC")
            .font(.custom("Avenir", size: 20))
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        Text("Meet The Team")
            .font(.custom("Lora-Medium", size: 18))
        
        HStack{
            Image("")
                .resizable()
                .clipShape(Circle())
            
            Image("")
                .resizable()
                .clipShape(Circle())
            
            Image("")
                .resizable()
                .clipShape(Circle())
        }
        
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
                
                Allocations()
                    .tag("allocations")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                
                Home(selected_category: selected_category, nextPage: $nextPage)
                    .tag("home")
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
                    Text("Funded Businesses")
                        .font(.custom("Avenir", size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            Org(name: "Local Leaves", index: 1, contribution: 30.71)
                            Org(name: "GoodToGo", index: 3, contribution: 57.63)
                        }
                    }
                }.padding(.top,10)
                
                Spacer()
            }.padding(.horizontal,20)
            
    
            //Org(name: "GoodToGo", index: 2)
            //Loader()
        }.frame(width:UIScreen.main.bounds.width).background(Color("offWhite"))
    }
}

struct Org: View{
    var name: String
    var index: Int
    var contribution: Double
    var body: some View{
        HStack{
            Image("localbus" + "\(index)")
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(spacing:3){
                Text(name)
                    .font(.custom("Lora-Semibold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("+$" + "\(contribution)")
                    .font(.custom("Lora-Medium", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("green"))
                
                Group{
                    Text("**Estimated Impact:**")
                        .foregroundColor(Color.blue)
                    Text(index == 1 ? "Your proceeds helped fund a *hedge shear*!" : "Your proceeds helped fund a *company trailer*!")
                }
                    .font(.custom("Lora-Regular", size: 13))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
        }.padding(.vertical,8)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
    }
}
struct Allocations: View {
    @State var currentTab: String = "food"
    @State var isOn: Bool = false
    @State var allocSet = false
    @State var modifyingAlloc = true
    @State var showing = false
    @State var percentages = false
    var body: some View{
        ZStack{
            VStack(spacing:5){
                HStack{
                    Text("My Allocations")
                        .font(.custom("Avenir", size: 22))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Image(systemName: "chevron.down")
                            .font(.system(size: 15))
                        
                        Image("visa")
                            .resizable()
                            .frame(width:30, height:20)
                        
                    }.padding(.vertical,6).padding(.horizontal, 9).background(RoundedRectangle(cornerRadius:5).fill(Color.white))
                    
                    // Image(systemName: "slider.horizontal.3")
                    //.font(.system(size: 18))
                }
                
                Picker("", selection: $currentTab){
                    Text("Food")
                        .tag("food")
                    Text("Gas")
                        .tag("gas")
                    Text("Education")
                        .tag("education")
                    Text("Other")
                        .tag("education")
                    
                }.pickerStyle(.segmented).padding(.top,10)
                
                //            HStack{
                //                Text("Total Allocation: ")
                //                    .font(.custom("Lora-Semibold", size: 17))
                //                    .frame(maxWidth: .infinity, alignment: .leading)
                //
                //            }.padding(.top,8)
                
                Toggle(isOn: $isOn){
                    Text("Allocate with Percentages")
                        .font(.custom("Avenir", size: 17))
                    
                        .bold()
                }.tint(.black).padding(.top,10)
                
                VStack{
                    if currentTab == "food"{
                        AllocView(name: "Local Leaves", index: 1, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                    } else if currentTab == "gas"{
                        AllocView(name: "Wyld Greens", index: 5, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                    } else if currentTab == "education" {
                        AllocView(name: "Herbal Soaps", index: 6, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                    } else {
                        AllocView(name: "Wyld Greens", index: 5, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                    }
                    
                    
                    if currentTab == "food"{
                        AllocView(name: "The Fair Food Co.", index: 2, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                        
                    } else if currentTab == "gas"{
                        AllocView(name: "The Fluffy", index: 8, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                    } else if currentTab == "education"{
                        AllocView(name: "Comfort Plus", index: 7, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                    } else {
                        AllocView(name: "Local Leaves", index: 10, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                    }
                    
                    if currentTab == "gas"{
                        AllocView(name: "PJs Cleaning", index: 9, isOn: $isOn, allocSet: $allocSet, modifyAlloc: $modifyingAlloc, percentagesChosen: $percentages)
                    }
                    
                }.padding(.top,10)
                
                
                HStack(spacing: 10){
                    Image(systemName: "plus.circle")
                        .font(.system(size: 18, weight: .semibold))
                    
                    
                    Text("Add Organization")
                        .font(.custom("Avenir", size: 17))
                    
                }.padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).frame(width: UIScreen.main.bounds.width - 40)).padding(.top,5)
                // TODO: "your allocation has been set!" popup "you can modify your selections at any time"
                Button(action:{
                    withAnimation{
                        if self.modifyingAlloc == true{
                            self.allocSet = true
                        } else {
                            self.allocSet = false
                        }
                        if self.modifyingAlloc{
                            self.showing.toggle()
                        }
                        if isOn{
                            self.percentages.toggle()
                        }
                    }
                }){
                    Text(allocSet && !isOn || percentages ? "Modify Allocation" : "Set Allocation")
                        .font(.custom("Avenir", size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical,5)
                        .padding(.horizontal,12)
                    
                }.background(Capsule().fill(Color("glacier"))).frame(maxWidth: .infinity, alignment: .trailing).padding(.top,10)
                Spacer()
                
                
            }.padding(.horizontal,20).background(Color("offWhite").edgesIgnoringSafeArea(.all))
            
            if showing{
                PopUp(showing: $showing)
            }
        }
    }
}

struct PopUp : View {
    @Binding var showing: Bool
    var body: some View{
        ZStack{
            VStack{
                Spacer()
                VStack(alignment: .center, spacing: 10){
                    Text("Your allocation has been set! You can modify your selections at any time.")
                        .font(.custom("Avenir", size: 17))
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Button(action:{
                        self.showing.toggle()
                    }){
                        Text("Okay!")
                            .font(.custom("Avenir", size: 17))
                            .bold()
                    }.foregroundColor(.black).padding(.vertical,6).padding(.horizontal,12).background(RoundedRectangle(cornerRadius: 15).fill(Color("glacier").opacity(0.5)))
                }.padding().background(RoundedRectangle(cornerRadius: 10).fill(Color.white)).padding(.horizontal,50)
                Spacer()
            }.edgesIgnoringSafeArea(.all)
        }.frame(width: UIScreen.main.bounds.width).edgesIgnoringSafeArea(.all).background(Color.primary.opacity(0.35))
    }
}
struct AllocView: View{
    var name: String
    var index: Int
    @State var allocation: Double = 0
    @Binding var isOn: Bool
    @State var input = ""
    @State var selectedAmt = "$1"
    @Binding var allocSet: Bool
    @Binding var modifyAlloc: Bool
    @Binding var percentagesChosen: Bool
    var body: some View{
        HStack{
            Image("localbus" + "\(index)")
                .resizable()
                .frame(width: 75, height: 75)
            
            VStack(spacing:8){
                HStack{
                    Text(name)
                        .font(.custom("Lora-Semibold", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    if isOn{
                        Text("\(Int(allocation))%")
                            .font(.custom("Avenir", size: 15))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing,15)
                            .foregroundColor(Color("green"))
                    } else {
                        
                    }
                }
                
                if isOn{
                    if !percentagesChosen{
                        Slider(value: $allocation, in: 0...100)
                            .accentColor(.black)
                            .frame(width: 255)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,3)
                    }
                    
                } else {
                    HStack{
                        Button(action:{
                            withAnimation(.easeInOut){
                                selectedAmt = "$1"
                            }
                        }){
                            DonationAmounts(dollar: "$1", selectedTab: $selectedAmt, allocSet: $allocSet, modifyAlloc: $modifyAlloc)
                        }.foregroundColor(.black)
                        
                        Button(action:{
                            withAnimation(.easeInOut){
                                selectedAmt = "$5"
                            }
                        }){
                            DonationAmounts(dollar: "$5", selectedTab: $selectedAmt, allocSet: $allocSet, modifyAlloc: $modifyAlloc)
                        }.foregroundColor(.black)
                        Button(action:{
                            withAnimation(.easeInOut){
                                selectedAmt = "$10"
                            }
                        }){
                            DonationAmounts(dollar: "$10", selectedTab: $selectedAmt, allocSet: $allocSet, modifyAlloc: $modifyAlloc)
                        }.foregroundColor(.black)
                        
                        Button(action:{
                            withAnimation(.easeInOut){
                                selectedAmt = "Custom"
                            }
                        }){
                            DonationAmounts(dollar: "Custom", selectedTab: $selectedAmt, allocSet: $allocSet, modifyAlloc: $modifyAlloc)
                        }.foregroundColor(.black)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if selectedAmt == "Custom" {
                    HStack{
                        Text("$")
                            .font(.custom("Avenir", size: 17))
                            .bold()
                        TextField("e.g. 8.50", text: $input)
                            .font(.custom("Avenir", size: 16))
                            .keyboardType(.decimalPad)
                            .padding(5)
                            .frame(width: 85)
                            .disabled(allocSet)
                            .background(RoundedRectangle(cornerRadius:5).stroke(Color.black.opacity(allocSet ? 0 : 0.6), lineWidth: 1))
                        
                        
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(.top,2)
                }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
        }.padding(.vertical,8)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
    }
    
    func getAlloc()->Double{
        return allocation
    }
}

struct DonationAmounts: View {
    var dollar: String
    @Binding var selectedTab : String
    @Binding var allocSet: Bool
    @Binding var modifyAlloc: Bool
    var body: some View {
        VStack{
            Text(dollar)
                .font(.custom("Avenir", size: 17))
                .bold()
            
            
        }.padding(.horizontal, 7).padding(.vertical,4).background(RoundedRectangle(cornerRadius:8).fill(Color("blush").opacity(allocSet && selectedTab == dollar ? 0.6 : (allocSet && selectedTab != dollar ? 0.0 : (selectedTab == dollar ? 0.6 : 0.25)))))
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
        //Allocations()
        //FundingPage()
        //ContentView()
        BodyView()
    }
}
