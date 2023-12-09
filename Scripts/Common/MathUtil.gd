class_name MathUtil
extends Node




static func ease_in_power(t: float, power: float, out_put_mag: float, time_to_max):
	return (1-pow((1- (1/time_to_max)*t),power))*out_put_mag

static func ease_out_power(t: float, power: float, out_put_mag: float, time_to_min):
	return (pow((1- ((1/time_to_min)*t)),power))*out_put_mag


static func get_speed_from_frame(frame: float):
	return PlayerConst.top_speed*(sign(frame)-pow(sign(frame)- ((1/PlayerConst.time_to_top_speed)*(frame)), PlayerConst.runing_curve_power))
