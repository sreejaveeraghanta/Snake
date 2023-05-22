//
//  ContentView.swift
//  Snake
//
//  Created by Sreeja V on 2023-05-18.
//

import SwiftUI
private var score: Int = 0
private var highScore: Int = 0

struct ContentView: View {
    // mutable varialbe declaration
    @State private var playerX : CGFloat =  round(CGFloat.random(in: -17...17))*10
    @State private var playerY: CGFloat =  round(CGFloat.random(in: -17...17))*10
    @State private var foodX : CGFloat =  round(CGFloat.random(in: -17...17))*10
    @State private var foodY : CGFloat =  round(CGFloat.random(in: -17...17))*10
    
    @State private var outOfBounds: Bool = false
    @State private var leftRightButton: Bool = false
    @State private var upDownButton: Bool = false
    @State private var movementTimer : Timer?
    
    var body: some View {
        ZStack{
            Image("Background2")
            VStack {
                HStack {
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .padding(.trailing, 20.0)
                    Text("High Score: \(highScore)")
                        .foregroundColor(.white)
                        .padding(.leading, 20.0)
                }
                ZStack {
                    // Game board
                    Rectangle()
                        .fill(Color(red: 0.02, green: 0.25, blue: 0.01))
                        .frame(width: 350, height: 350)
                        .padding(.all, 40.0)
                    // Food for player
                    Rectangle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                        .offset(x: foodX, y: foodY)
                    
                    // The player
                    Rectangle()
                        .fill(.black)
                        .frame(width: 10, height: 10)
                        .offset(x: playerX, y: playerY)
                    
                }
                
                Button("UP") {
                    // validating buttons that can be pressed on an up movement
                    upDownButton = true
                    leftRightButton = false
                    
                    
                    if (upDownButton) {
                        movementTimer?.invalidate()
                        movementTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats : upDownButton) { timer in
                            movePlayer(arg1: "up", arg2: &playerX, arg3: &playerY)
                            outOfBounds = checkBounds(arg1: playerX, arg2: playerY)
                            if (outOfBounds) {
                                movementTimer?.invalidate()
                                leftRightButton = true
                            }
                            checkCollision(arg1: playerX, arg2: playerY, arg3: &foodX, arg4: &foodY)
                        }
                    }
                }
                .frame(width: 70, height: 35.0)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .disabled(upDownButton)
                HStack {
                    Button("LEFT") {
                        
                        upDownButton = false
                        leftRightButton = true
                        
                        if (leftRightButton) {
                            movementTimer?.invalidate()
                            movementTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats : leftRightButton) { timer in
                                movePlayer(arg1: "left", arg2: &playerX, arg3: &playerY)
                                outOfBounds = checkBounds(arg1: playerX, arg2: playerY)
                                if (outOfBounds) {
                                    movementTimer?.invalidate()
                                    upDownButton = true
                                }
                                checkCollision(arg1: playerX, arg2: playerY, arg3: &foodX, arg4: &foodY)
                            }
                        }
                    }
                    .frame(width: 70, height: 35.0)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .disabled(leftRightButton)
                    
                    Button("RIGHT") {
                        upDownButton = false
                        leftRightButton = true
                        
                        if (leftRightButton) {
                            movementTimer?.invalidate()
                            movementTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats : leftRightButton) { timer in
                                movePlayer(arg1: "right", arg2: &playerX, arg3: &playerY)
                                outOfBounds = checkBounds(arg1: playerX, arg2: playerY)
                                if (outOfBounds) {
                                    movementTimer?.invalidate()
                                    upDownButton = true
                                }
                                checkCollision(arg1: playerX, arg2: playerY, arg3: &foodX, arg4: &foodY)
                            }
                        }
                    }
                    .frame(width: 70, height: 35.0)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .disabled(leftRightButton)
                    
                }
                Button("DOWN") {
                    upDownButton = true
                    leftRightButton = false
                    
                    if (upDownButton) {
                        movementTimer?.invalidate()
                        movementTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats : upDownButton) { timer in
                            movePlayer(arg1: "down", arg2: &playerX, arg3: &playerY)
                            outOfBounds = checkBounds(arg1: playerX, arg2: playerY)
                            if (outOfBounds) {
                                movementTimer?.invalidate()
                                leftRightButton = true
                            }
                            checkCollision(arg1: playerX, arg2: playerY, arg3: &foodX, arg4: &foodY)
                        }
                    }
                    
                }
                .frame(width: 70, height: 35.0)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .disabled(upDownButton)
                
                Button("Reset") {
                    // Reset to initial game mode
                    playerX =  round(CGFloat.random(in: -17...17))*10
                    playerY =  round(CGFloat.random(in: -17...17))*10
                    foodX =  round(CGFloat.random(in: -17...17))*10
                    foodY =  round(CGFloat.random(in: -17...17))*10
                    upDownButton = false
                    leftRightButton = false
                    movementTimer?.invalidate()
                    outOfBounds = false
                    if (score > highScore) {
                        highScore = score
                    }
                    score = 0
                    
                }.frame(width: 70, height: 35.0)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding(.all)
            }
        }
    }
}

func movePlayer(arg1 direction:String, arg2 playerX: inout CGFloat, arg3 playerY: inout CGFloat) {
    if (direction == "left") {
        playerX = playerX - 10
    }
    else if (direction == "right") {
        playerX = playerX + 10
    }
    else if (direction == "up") {
        playerY =  playerY - 10
    }
    else if (direction == "down") {
        playerY = playerY + 10
    }
}

func checkBounds(arg1 playerX:CGFloat, arg2 playerY:CGFloat) -> Bool{
    if (playerX > 170 || playerX < -170 || playerY > 170 || playerY < -170) {
        return true
    }
    return false
}

func checkCollision(arg1 playerX:CGFloat, arg2 playerY:CGFloat, arg3 foodX: inout CGFloat, arg4 foodY: inout CGFloat){
    if (playerX == foodX && playerY == foodY) {
        score = score+1
        foodX = round(CGFloat.random(in: -17...17))*10
        foodY = round(CGFloat.random(in: -17...17))*10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
