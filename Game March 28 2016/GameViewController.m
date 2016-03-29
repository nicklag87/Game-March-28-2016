//
//  GameViewController.m
//  Game March 28 2016
//
//  Created by Nicholas Lagerstedt on 3/28/16.
//  Copyright (c) 2016 Nicholas Lagerstedt. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

bool myBool = false;
SCNScene *myScene;



- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    NSLog(@"tapped");
    if (myBool == false) {
        myScene.physicsWorld.gravity = SCNVector3Make(0.0, 9.8, 0.0);
        myBool = true;
    } else {
        myScene.physicsWorld.gravity = SCNVector3Make(0.0, -9.8, 0.0);
        myBool = false;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up camera
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(0.0, 0.0, 10.0);
    

    // view set up
    SCNView *mainView = [[SCNView alloc] init];
    self.view = mainView;
    mainView.backgroundColor = [UIColor colorWithHue:0.5 saturation:1.0 brightness:1.0 alpha:1.0];
    
    // scene set up
    myScene = [[SCNScene alloc] init];
    mainView.scene = myScene;
    [myScene.rootNode addChildNode:cameraNode];
    
    
    // create floor
    SCNFloor *mainFloor = [SCNFloor floor];
    SCNNode *floorNode = [SCNNode nodeWithGeometry:mainFloor];
    floorNode.position = SCNVector3Make(0.0, -4.0, 0.0);
    [myScene.rootNode addChildNode:floorNode];
    SCNPhysicsBody *solid = [SCNPhysicsBody staticBody];
    floorNode.physicsBody = solid;
    
    
    
    // allow camera and lighting
    mainView.autoenablesDefaultLighting = true;
    mainView.allowsCameraControl = true;
    
    
    // touch recognizer
    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:screenTap];
    
    // create box
    SCNBox *myBox = [SCNBox boxWithWidth:1.0 height:1.0 length:1.0 chamferRadius:0.1];
    SCNNode *boxNode = [SCNNode nodeWithGeometry:myBox];
    boxNode.position = SCNVector3Make(0.0, 0.0, 4.0);
    [myScene.rootNode addChildNode:boxNode];
    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
    // constraints
    SCNLookAtConstraint *boxConst = [SCNLookAtConstraint lookAtConstraintWithTarget:boxNode];
    cameraNode.constraints = @[boxConst];
    
    myScene.physicsWorld.gravity = SCNVector3Make(0.0, -9.8, 0.0);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
