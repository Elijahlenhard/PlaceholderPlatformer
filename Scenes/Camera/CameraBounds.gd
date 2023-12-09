class_name CameraBounds
extends Area2D




func get_closest_bound_position(camera_pos: Vector2) -> Vector2:
	var new_target = Vector2(0,0)
	
	var collision_vectors = []
	
	var closest_collision = camera_pos
	var closest_distance = 10000000
	
	
	
	
	var space_state = get_world_2d().direct_space_state
	
	
	var ray_cast_up = camera_pos
	ray_cast_up.y-=1000
	var ray_cast_down = camera_pos
	ray_cast_down.y+=1000
	var ray_cast_left = camera_pos
	ray_cast_left.x-=1000
	var ray_cast_right = camera_pos
	ray_cast_right.x+=1000
	
	
	var query_right = PhysicsRayQueryParameters2D.create(camera_pos,ray_cast_right, collision_mask)
	query_right.collide_with_areas = true
	query_right.hit_from_inside=true
	var result_right = space_state.intersect_ray(query_right)
	if(!result_right.is_empty()):
		collision_vectors.append(result_right.get("position"))
	
	
	var query_up = PhysicsRayQueryParameters2D.create(camera_pos, ray_cast_up, collision_mask)
	query_up.collide_with_areas = true
	var result_up = space_state.intersect_ray(query_up)
	
	if(!result_up.is_empty()):
		collision_vectors.append(result_up.get("position"))
		
	var query_left = PhysicsRayQueryParameters2D.create(camera_pos,ray_cast_left, collision_mask)
	query_left.collide_with_areas = true
	var result_left = space_state.intersect_ray(query_left)
	if(!result_left.is_empty()):
		collision_vectors.append(result_left.get("position"))
	
	
	
	
	
	var query_down = PhysicsRayQueryParameters2D.create(camera_pos,ray_cast_down, collision_mask)
	query_down.collide_with_areas = true
	var result_down = space_state.intersect_ray(query_down)
	if(!result_down.is_empty()):
		collision_vectors.append(result_down.get("position"))
		
		
	
	for vector in collision_vectors:
		var distance_to_colision = (vector-camera_pos).length()
		if(distance_to_colision< closest_distance):
			closest_distance=distance_to_colision
			closest_collision = vector
	
	
	return closest_collision;

