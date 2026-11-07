// 7.62x38mmR (Nagant Revolver)

/obj/projectile/bullet/n762
	name = "7.62x38mmR bullet"
	damage = 30
	ricochets_max = 1
	ricochet_chance = 50
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 3
	wound_bonus = -20
	bare_wound_bonus = 10
	embed_type = /datum/embedding/n762
	embed_falloff_tile = -4
	speed = BULLET_SPEED_REVOLVER

/datum/embedding/n762
	embed_chance = 25
	fall_chance = 2
	jostle_chance = 2
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 3
	jostle_pain_mult = 5
	rip_time = 1 SECONDS

// .38 (Detective's Gun)

/obj/projectile/bullet/c38
	name = ".38 bullet"
	damage = 20
	armour_penetration = -20
	ricochets_max = 2
	ricochet_chance = 50
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 3
	speed = BULLET_SPEED_REVOLVER

/datum/embedding/bullet_c38
	embed_chance = 25
	fall_chance = 2
	jostle_chance = 2
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 3
	jostle_pain_mult = 5
	rip_time = 1 SECONDS

/obj/projectile/bullet/c38/match
	name = ".38 Match bullet"
	ricochets_max = 4
	ricochet_chance = 100
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_incidence_leeway = 50
	ricochet_decay_chance = 1
	ricochet_decay_damage = 1
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c38/match/bouncy
	name = ".38 Rubber bullet"
	damage = 10
	stamina = 28
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 1
	shrapnel_type = null
	sharpness = NONE
	embed_type = null
	speed_mod = BULLET_SPEED_RUBBER_MOD

// premium .38 ammo from cargo, weak against armor, lower base damage, but excellent at embedding and causing slice wounds at close range
/obj/projectile/bullet/c38/dumdum
	name = ".38 DumDum bullet"
	damage = 20
	weak_against_armour = TRUE
	ricochets_max = 0
	sharpness = SHARP_EDGED
	speed_mod = BULLET_SPEED_HP_MOD

/datum/embedding/bullet_c38_dumdum
	embed_chance = 75
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

/obj/projectile/bullet/c38/trac
	name = ".38 TRAC bullet"
	damage = 10
	ricochets_max = 0

/obj/projectile/bullet/c38/trac/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	var/mob/living/carbon/M = target
	if(!istype(M))
		return
	var/obj/item/implant/tracking/c38/imp
	for(var/obj/item/implant/tracking/c38/TI in M.implants) //checks if the target already contains a tracking implant
		imp = TI
		return
	if(!imp)
		imp = new /obj/item/implant/tracking/c38(M)
		imp.implant(M)

/obj/projectile/bullet/c38/hotshot //similar to incendiary bullets, but do not leave a flaming trail
	name = ".38 Hot Shot bullet"
	damage = 20
	ricochets_max = 0

/obj/projectile/bullet/c38/hotshot/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(6)
		M.ignite_mob()

/obj/projectile/bullet/c38/iceblox //see /obj/projectile/temp for the original code
	name = ".38 Iceblox bullet"
	damage = 20
	ricochets_max = 0

	/// How much to change the target's body temperature by
	var/temperature = 100

/obj/projectile/bullet/c38/iceblox/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((100-blocked)/100)*(temperature - M.bodytemperature))

// .357 (Syndie Revolver)

/obj/projectile/bullet/a357
	name = ".357 bullet"
	damage = 35

/obj/projectile/bullet/a357/hp
	name = ".357 hollow point bullet"
	damage = 60
	armour_penetration = -30
	speed_mod = BULLET_SPEED_HP_MOD

// admin only really, for ocelot memes
/obj/projectile/bullet/a357/match
	name = ".357 match bullet"
	ricochets_max = 5
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1
	speed_mod = BULLET_SPEED_AP_MOD

///.45 Long, also used in the Brush Gun


/obj/projectile/bullet/g45l
	name = ".45 Long bullet"
	damage = 30
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/g45l/rubber
	name = ".45 Long rubber bullet"
	damage = 7.5
	stamina = 35
	sharpness = NONE
	speed_mod = BULLET_SPEED_RUBBER_MOD

///.585 Trappiste, heavy crew pistol/smg round

/obj/projectile/bullet/c585trappiste
	name = ".585 Trappiste bullet"
	damage = 60
	speed_mod = BULLET_SPEED_REVOLVER
/obj/projectile/bullet/c585trappiste/incapacitator
	name = ".585 Trappiste flathead bullet"
	damage = 10
	stamina = 40
	wound_bonus = -20
	shrapnel_type = null
	sharpness = NONE
	speed_mod = BULLET_SPEED_RUBBER_MOD

/obj/projectile/bullet/c585trappiste/hollowpoint
	name = ".585 Trappiste hollowhead bullet"
	damage = 60
	armour_penetration = -30
	speed_mod = BULLET_SPEED_HP_MOD

//.45-70, mining revolver

/obj/projectile/bullet/govmining
	name = ".45-70 Gov Kinetic Bullet"
	damage = 25
	fauna_mod = 3 //four shots to kill a goliath

/obj/projectile/bullet/govmining/on_hit(atom/target, Firer, blocked = 0, pierce_hit) //its not meant to tear through walls like a plasma cutter, but will still at least bust down a wall if it hits one.
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer, FALSE)
	. = ..()


// .500 (Admin only)

/obj/projectile/bullet/a500
	name = ".500 Magnum bullet"
	damage = 75
	wound_bonus = 50
	paralyze = 5
	dismemberment = 50
	catastropic_dismemberment = TRUE
