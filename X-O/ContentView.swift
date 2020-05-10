//
//  ContentView.swift
//  X-O
//
//  Created by Eng. Norii on 5/9/20.
//  Copyright © 2020 EngSrayea. All rights reserved.
//

import SwiftUI

struct Field {
    var text: String
    var enabled: Bool
    
}

struct ContentView: View {
    
    @State var fields: [[Field]] = .init(repeating: .init(repeating: Field(text: "", enabled: true), count: 3), count: 3)
    
    @State var crrntPlayer: String = "X"
    @State var winner = ""
    @State var counter = 0
    
    var body: some View {
        
        VStack(spacing: 10){
            Text(winner).foregroundColor(.red).font(.system(size: 50, weight: .bold, design: .rounded)).offset(y: -50)
            
            Text("\(crrntPlayer) Turn").font(.system(size: 50, weight: .bold, design: .rounded)).offset(y: -50)
            
            ForEach(0 ..< 3){ r in
                HStack(spacing: 10){
                    ForEach(0 ..< 3){ c in
                        Button(action: {
                            if self.fields[r][c].enabled{
                                self.fields[r][c].text = self.crrntPlayer
                            self.crrntPlayer = self.crrntPlayer == "X" ? "O" : "X"
                                self.fields[r][c].enabled = false
                                self.counter += 1
                                self.checkWinners()
                                
                            }
                        }) {
                            Text(self.fields[r][c].text).foregroundColor(.black).font(.system(size: 50, weight: .bold, design: .rounded))
                                .frame(width: 100, height: 100).background(Color.yellow)
                        }
                    }
                }
            }
            
            if winner != "" {
                Button(action: {
                    self.restartGame()
                }) {
                    Text("Restart Game?").font(.system(size: 30, weight: .bold, design: .rounded))
                }
            }
            
        }
    }

    func checkWinners() {
        func checkWinner(plyr : String){
    let r1 = fields[0][0].text == plyr && fields[0][1].text == plyr && fields[0][2].text == plyr
    let r2 = fields[1][0].text == plyr && fields[1][1].text == plyr && fields[1][2].text == plyr
    let r3 = fields[2][0].text == plyr && fields[2][1].text == plyr && fields[2][2].text == plyr
    let c1 = fields[0][0].text == plyr && fields[1][0].text == plyr && fields[2][0].text == plyr
    let c2 = fields[0][1].text == plyr && fields[1][1].text == plyr && fields[2][1].text == plyr
    let c3 = fields[0][2].text == plyr && fields[1][2].text == plyr && fields[2][2].text == plyr
    let d1 = fields[0][0].text == plyr && fields[1][1].text == plyr && fields[2][2].text == plyr
    let d2 = fields[0][2].text == plyr && fields[1][1].text == plyr && fields[2][0].text == plyr
    
    if r1 || r2 || r3 || c1 || c2 || c3 || d1 || d2 {
        winner = "\(plyr) wins!"
            }
            else if counter == 9 {
            winner = "DRAW!"
            }
        }
        checkWinner(plyr: "X")
        checkWinner(plyr: "O")
    }
    
    
    
    func restartGame(){
        fields = .init(repeating: .init(repeating: Field(text: "", enabled: true), count: 3), count: 3)
        crrntPlayer = "X"
        winner = ""
        counter = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


