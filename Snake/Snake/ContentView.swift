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
    // Player and Food initialization
    @State private var foodPosition: CGPoint =  CGPoint(x: round(CGFloat.random(in: -17...17))*10 , y: round(CGFloat.random(in: -17...17))*10)
    @State private var playerPositions:[CGPoint] = [CGPoint(x: round(Double.random(in: -17...17))*10, y: round(Double.random(in: -17...17))*10)]
    
    @State private var gameOver: Bool = false
    @State private var leftRightButton: Bool = false
    @State private var upDownButton: Bool = false
    @State private var movementTimer : Timer?
    @State private var collided: Bool = false
    @State private var blockSize: CGFloat = 10
    
    
    var body: some View {
        ZStack{
            Image("Background2")
            VStack {
                // Score measurement Text
                HStack {
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .padding(.trailing, 20.0)
                    Text("High Score: \(highScore)")
                        .foregroundColor(.white)
                        .padding(.leading, 20.0)
                }
                ZStack {
                    // Drawing the game board
                    Rectangle()
                        .fill(Color(red: 0.02, green: 0.25, blue: 0.1))
                        .frame(width: 350, height: 350)
                        .padding(.all, 40.0)
                    // Drawing the food
                    Rectangle()
                        .fill(.red)
                        .frame(width: blockSize, height: blockSize)
                        .offset(x: foodPosition.x, y: foodPosition.y)
                    // Drawing the player player
                    ForEach(0..<playerPositions.count, id:\.self) {index in
                        Rectangle()
                            .fill(.black)
                            .frame(width: blockSize, height: blockSize)
                            .offset(x: playerPositions[index].x, y: playerPositions[index].y)
                    }
                }
                
                Button("UP") {
                    // validating buttons that can be pressed on an up movement
                    upDownButton = true
                    leftRightButton = false
                    
                    if (upDownButton) {
                        movementTimer?.invalidate()
                        movementTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats : upDownButton) {timer in
                            movePlayer(arg1: "up")
                            checkCollision()
                            checkBounds()
                            if (gameOver) {
                                movementTimer?.invalidate()
                                leftRightButton = true
                            }
                        }
                    }
                }.buttonStyle(.borderedProminent)
                    .tint(.black)
                    .frame(width: 100, height: 35.0)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .disabled(upDownButton)
                
                HStack {
                    // Left movement
                    Button("LEFT") {
                        upDownButton = false
                        leftRightButton = true
                        
                        if (leftRightButton) {
                            movementTimer?.invalidate()
                            movementTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats : leftRightButton) { timer in
                                movePlayer(arg1: "left")
                                checkCollision()
                                checkBounds()
                                if (gameOver) {
                                    movementTimer?.invalidate()
                                    upDownButton = true
                                }
                            }
                        }
                    }.buttonStyle(.borderedProminent)
                        .tint(.black)
                    
                        .frame(width: 100, height: 35.0)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .disabled(leftRightButton)
                    
                    // Right movement
                    Button("RIGHT") {
                        upDownButton = false
                        leftRightButton = true
                        if (leftRightButton) {
                            movementTimer?.invalidate()
                            movementTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats : leftRightButton) { timer in
                                movePlayer(arg1: "right")
                                checkCollision()
                                checkBounds()
                                if (gameOver) {
                                    movementTimer?.invalidate()
                                    upDownButton = true
                                }
                            }
                        }
                    }.buttonStyle(.borderedProminent)
                        .tint(.black)
                        .frame(width: 100, height: 35.0)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .disabled(leftRightButton)
                }
                
                // Down movement
                Button("DOWN") {
                    upDownButton = true
                    leftRightButton = false
                    if (upDownButton) {
                        movementTimer?.invalidate()
                        movementTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats : upDownButton) { timer in
                            movePlayer(arg1: "down")
                            checkCollision()
                            checkBounds()
                            if (gameOver) {
                                movementTimer?.invalidate()
                                leftRightButton = true
                            }
                        }
                    }
                }.buttonStyle(.borderedProminent)
                    .tint(.black)
                    .frame(width: 100, height: 35.0)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .disabled(upDownButton)
                
                // Resets everything to the initial game mode
                Button("Reset") {
                    foodPosition.x = round(CGFloat.random(in: -17...17))*10
                    foodPosition.y = round(CGFloat.random(in: -17...17))*10
                    playerPositions.removeAll()
                    playerPositions.append(CGPoint(x: round(CGFloat.random(in: -17...17))*10, y: round(CGFloat.random(in: -17...17))*10))
                    upDownButton = false
                    leftRightButton = false
                    movementTimer?.invalidate()
                    gameOver = false
                    if (score > highScore) {
                        highScore = score
                    }
                    score = 0
                }.buttonStyle(.bordered)
                    .tint(.green)
                    .frame(width: 100, height: 35.0)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding(.all)
            }
        }
    }
    
    // Keeps player within the bounds of the game board
    func checkBounds() {
        if (playerPositions[0].x > 170 || playerPositions[0].x < -170 || playerPositions[0].y > 170 || playerPositions[0].y < -170) {
            gameOver = true
        }
    }
    
    // Moves the palyer
    func movePlayer(arg1 direction: String) {
        var previousPos: CGPoint = playerPositions[0]
        if (direction == "up") {
            playerPositions[0].y = playerPositions[0].y - 10
        }
        else if (direction == "down") {
            playerPositions[0].y = playerPositions[0].y + 10
        }
        else if (direction == "left") {
            playerPositions[0].x = playerPositions[0].x - 10
        }
        else if (direction == "right") {
            playerPositions[0].x = playerPositions[0].x + 10
        }
        // Moves body of the player
        for i in 1..<playerPositions.count {
            let current: CGPoint = playerPositions[i]
            playerPositions[i] = previousPos
            previousPos = current
        }
    }
    
    // Checks for collision between player and food
    func checkCollision() {
        if (playerPositions[0].x == foodPosition.x && playerPositions[0].y == foodPosition.y){
            score+=1
            playerPositions.append(CGPoint(x: foodPosition.x, y: foodPosition.y))
            foodPosition.x =  round(CGFloat.random(in: -17...17))*10
            foodPosition.y =  round(CGFloat.random(in: -17...17))*10
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
