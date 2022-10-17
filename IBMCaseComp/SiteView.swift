//
//  SiteView.swift
//  IBMCaseComp
//
//  Created by Angelina Ilijevski on 10/16/22.
//

import SwiftUI
import Charts

struct SiteView: Identifiable{
    var id = UUID().uuidString
    var day: Date
    var amount: Double
    var animate: Bool = false
}

extension Date{
    func updateDay(value: Int)->Date{
        let calendar = Calendar.current
        return calendar.date(bySetting: .day, value: value, of: self) ?? .now
    }
}

var sample_analytics: [SiteView] = [
    SiteView(day: Date().updateDay(value: 1), amount: 0.83),
    SiteView(day: Date().updateDay(value: 2), amount: 0.43),
    SiteView(day: Date().updateDay(value: 3), amount: 0.90),
    SiteView(day: Date().updateDay(value: 4), amount: 0.99),
    SiteView(day: Date().updateDay(value: 5), amount: 0.24),
    SiteView(day: Date().updateDay(value: 6), amount: 0.87),
    SiteView(day: Date().updateDay(value: 7), amount: 0.23),
    SiteView(day: Date().updateDay(value: 8), amount: 0.13),
    SiteView(day: Date().updateDay(value: 9), amount: 0.57),
    SiteView(day: Date().updateDay(value: 10), amount: 0.68),
    SiteView(day: Date().updateDay(value: 11), amount: 0.66),
    SiteView(day: Date().updateDay(value: 12), amount: 0.92),
    SiteView(day: Date().updateDay(value: 13), amount: 0.83)
]


struct Analytics: View{
    @State var sampleAnalytics: [SiteView] = sample_analytics
    var body:some View{
            VStack{
                VStack(alignment: .leading, spacing: 12){
                
                    
                    AnimatedChart()
                        
                }
            }
    }
    
    @ViewBuilder
    func AnimatedChart()->some View{
        let max = sampleAnalytics.max { item1, item2 in
            return item2.amount > item1.amount
        }?.amount ?? 0
        
        Chart{
            ForEach(sampleAnalytics){item in
                LineMark(x: .value("Day", item.day), y: .value("Dollars", item.amount))
                    .foregroundStyle(Color("green").gradient)
                    //.interpolationMethod(.catmullRom) - makes lines curved
                AreaMark(x: .value("Day", item.day), y: .value("Dollars", item.amount))
                    .foregroundStyle(Color("green").opacity(0.1).gradient)
                
            }
        }
        .chartYScale(domain: 0...(max + 0.2))
        .chartYAxis{
            AxisMarks(position: .leading) // place y values on left side
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 230) //customize y axis length
        .onAppear {
            for(index, _) in sampleAnalytics.enumerated(){
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05){
                    withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)){
                        sampleAnalytics[index].animate = true
                    }
                }
            }
        }
    }
}

/*
 interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8).delay(Double(index) * 0.05)
 */

struct Site_Previews: PreviewProvider {
    static var previews: some View {
        //Selector(selected_category: "individual contributor")
        //BodyView()
        Analytics()
        //ContentView()
    }
}
