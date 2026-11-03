/obj/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	armor_flag = BULLET
	hitsound_non_living = 'sound/items/weapons/pierce.ogg'
	hitsound_glass = SFX_SHATTER
	hitsound_stone = 'sound/effects/meteorimpact.ogg'
	hitsound_metal = SFX_RICOCHET
	hitsound_wood = 'sound/effects/woodhit.ogg'
	hitsound_snow = 'sound/effects/miss.ogg'
	near_miss_sound = 'sound/items/weapons/bulletflyby.ogg'
	ricochet_sound = SFX_RICOCHET
	ricochets_max = 5
	ricochet_chance = 30
	ricochet_decay_damage = 0.5
	sharpness = SHARP_POINTY
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	shrapnel_type = /obj/item/shrapnel/bullet
	embed_type = /datum/embedding/bullet
	wound_bonus = 0
	wound_falloff_tile = -5
	embed_falloff_tile = -3
	speed = 1.6
	//light_system = OVERLAY_LIGHT
	//light_outer_range = 1.25
	//light_power = 1
	//light_color = COLOR_VERY_SOFT_YELLOW
	//light_on = TRUE
	//This applies to casings too, for some reason, and regardless this shouldn't apply to every bullet not every bullet should or does have a tracer.

/obj/projectile/bullet/smite
	name = "divine retribution"
	damage = 10

/datum/embedding/bullet
	embed_chance=20
	fall_chance=2
	jostle_chance=0
	ignore_throwspeed_threshold=TRUE
	pain_stam_pct=0.5
	pain_mult=3
	rip_time=10
