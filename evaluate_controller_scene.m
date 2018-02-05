function fitness = evaluate_controller_scene(net,scene)
global num_evals
num_evals = num_evals + 1;
Tsim = 10;
Tstep = 0.1;
for i=1:ceil(Tsim/Tstep)
    scene.obstacle(5).random_move(Tstep)
    scene.obstacle(6).random_move(Tstep)
    scene.obstacle(7).random_move(Tstep)
    
    scene.robot.laser_scanner.scan(scene);
    scene.robot.move(net,scene.goal.pos, Tstep);
    
    fitness = -norm(scene.goal.pos(1:2) - scene.robot.pos(1:2));
     
    if scene.robot.check_collision(scene)
        disp('collision')
        break;
    end
end

end
