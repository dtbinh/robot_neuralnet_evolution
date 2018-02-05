function fitness = evaluate_controller_multiscene(net)

create_scene1
d1 = norm(scene.goal.pos(1:2) - scene.robot.pos(1:2));
f1 = evaluate_controller_scene(net,scene);

create_scene2
d2 = norm(scene.goal.pos(1:2) - scene.robot.pos(1:2));
f2 = evaluate_controller_scene(net,scene);

create_scene3
d3 = norm(scene.goal.pos(1:2) - scene.robot.pos(1:2));
f3 = evaluate_controller_scene(net,scene);

fitness = 1+min([(f1/d1), (f2/d2), (f3/d3)]);

end
