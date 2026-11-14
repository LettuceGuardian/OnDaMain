///
// PORTED FROM PARADISE STATION, REFLAVOURED CORPORATE JUDO
///
#define MIN_COMBO 2

///
// ITEM INFORMATION
///
/obj/item/clothing/gloves/tackler/shocker
	name = "Shocker Gloves"
	desc = "Energy conductive gloves, these come with hard knuckles, in case shocking your target wasn't enough. Too bulky to use with guns and batons, and the grip could be better. Maybe you could upgrade it?"
	icon_state = "shocker"
	worn_icon_state = "shocker"
	inhand_icon_state = "shocker"
	custom_premium_price = PAYCHECK_COMMAND * 2
	w_class = WEIGHT_CLASS_NORMAL
	equip_delay_self = 2 SECONDS

	tackle_stam_cost = 10
	base_knockdown = 0.5 SECONDS
	tackle_range = 5
	skill_mod = -1

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

	var/datum/martial_art/shocker/style

/obj/item/clothing/gloves/tackler/shocker/upgraded
	name = "Gorilla Shocker Gloves"
	desc = "Energy conductive gloves, these come with hard knuckles and upgraded grip, in case shocking your target wasn't enough. Too bulky to use with guns and batons."
	tackle_stam_cost = 15
	base_knockdown = 1.25 SECONDS
	tackle_range = 5
	skill_mod = 3

/datum/crafting_recipe/shockerupgrade
	name = "orilla Shocker Gloves"
	reqs = list(
		/obj/item/clothing/gloves/tackler/shocker = 1,
		/obj/item/clothing/gloves/tackler/combat = 1,
	)
	result = /obj/item/clothing/gloves/tackler/shocker/upgraded
	category = CAT_EQUIPMENT

///

/obj/item/clothing/gloves/tackler/shocker/Initialize(mapload)
	. = ..()
	style = new()
	style.allow_temp_override = FALSE

/obj/item/clothing/gloves/tackler/shocker/Destroy()
	QDEL_NULL(style)
	return ..()

/obj/item/clothing/gloves/tackler/shocker/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_GLOVES)
		style.teach(user, TRUE)

/obj/item/clothing/gloves/tackler/shocker/dropped(mob/user)
	. = ..()
	if(!isnull(style))
		style.remove(user)

///
// MARTIAL ART STYLE
///
/datum/martial_art/shocker
	name = "Lightning Strikes"
	id = MARTIALART_SHOCKER
	display_combos = TRUE
	max_streak_length = 12
	combo_timer = 3.5  SECONDS

	var/datum/action/cooldown/golden_bolt/bolt = new()

	help_verb = /mob/living/carbon/human/proc/shocker_help

	var/list/combo_moves = list(
		"DG" = PROC_REF(tazer),
		"HD" = PROC_REF(arc_eye),
		"GD" = PROC_REF(judo_throw),
		"DDG" = PROC_REF(armbar),
		"DDGGDH" = PROC_REF(wheel_throw),
		"EDEGDDGEDDGE" = PROC_REF(golden_blast),
	)

/datum/martial_art/shocker/teach(mob/living/owner, make_temporary=FALSE)
	. = ..()
	if(.)
		to_chat(owner, span_userdanger("You slip your hands into the gloves, they promptly turn on with a crackle of electricity."))
		owner.apply_status_effect(/datum/status_effect/weapon_lock)
		bolt.Grant(owner)

/datum/martial_art/shocker/remove(mob/living/owner)
	. = ..()
	owner.remove_status_effect(/datum/status_effect/weapon_lock)
	bolt.Remove(owner)
	if(.)
		to_chat(owner, span_userdanger("The gloves' electric crackles die down."))

/mob/living/carbon/human/proc/shocker_help()
	set name = "Read the warning tag"
	set desc = "This sure looks dangerous!"
	set category = "Shocker Gloves"

	to_chat(usr, "<b><i>DO NOT USE TO CAUSE UNNEEDED INJURY, USE FORCE ONLY AS NECESSARY. TO USE:</i></b>")

	var/list/teach_msg = list()

	teach_msg += span_notice("Hardened Knuckles") + ": " + span_memo("Your punches strike harder than normal.")
	teach_msg += span_notice("Taze") + ": " + span_memo("Disarm Grab.") + " Generates an electric shock; drains some of the opponents stamina, and confuses them for a moment."
	teach_msg += span_notice("Arc Eye") + ": " + span_memo("Harm Disarm.") + " Targeted shock on the eyes. Causes burn and makes it increasingly hard to see."
	teach_msg += span_notice("Judo Throw") + ": " + span_memo("Grab Disarm.") + " You and your opponent must not be on the floor. With a maintained grasp, throw them to the floor draining their stamina and ability to stand up."
	teach_msg += span_notice("Armbar") + ": " + span_memo("Disarm Disarm Grab.") + " Twist the arm of a laying opponent causing them heavy exhaustion and knocking them into the floor. Standing leverage causes the opponent to drop their held possesions."
	teach_msg += span_notice("Wheel Throw") + ": " + span_memo("Armbar->Grab Disarm Harm.") + " Continuing from Armbar this dance will throw a laying opponent over your body and back into the ground. Heavy exhaustion, confusion, and loss of balance will follow."
	teach_msg += span_notice("Golden Blast") + ": " + span_memo("Help Disarm Help-Grab Disarm Disarm-Grab Help Disarm-Disarm Grab Help.") + " An absurdly intricate fighting move to demonstrate your mastery of the shock gloves. Hits opponent with overwhelming energy. Knocks them down heavily causing confusion, exhaustion, balance loss."
	to_chat(usr, teach_msg.Join("\n"))

/datum/martial_art/shocker/Destroy()
	if(holder)
		var/mob/living/owner = holder.resolve()
		if(owner)
			remove(owner) // Clean up the martial art effects from the owner
	combo_moves = null
	return ..()

///
// MARTIAL ART STYLE: ABILITIES
///
/datum/martial_art/shocker/proc/tazer(mob/living/carbon/human/attacker, mob/living/defender)
	reset_streak(defender)
	defender.visible_message("<span class='warning'>[attacker] tazes [defender] with [attacker.p_their()] palm!</span>", \
						"<span class='userdanger'>[attacker] tazes you with [attacker.p_their()] palm!</span>")
	playsound(get_turf(attacker), 'sound/items/weapons/taserhit.ogg', 40, TRUE, -1)
	defender.apply_damage(25, STAMINA)
	defender.adjust_confusion(5 SECONDS)
	do_sparks(1, FALSE, defender)
	log_combat(attacker, defender, "Melee attacked with martial-art [src] : tazer")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/shocker/proc/arc_eye(mob/living/attacker, mob/living/defender)
	reset_streak(defender)
	defender.visible_message("<span class='warning'>[attacker]'s palm smacks and flashes [defender] with a blinding arc light!</span>", \
						"<span class='userdanger'>[attacker] flashes an arc of electricity at your eyes!</span>")
	playsound(get_turf(attacker), 'sound/items/weapons/taser.ogg', 40, TRUE, -1)
	defender.apply_damage(10, BRUTE)
	defender.adjust_eye_blur_up_to(5,30)
	defender.set_temp_blindness(2 SECONDS)
	do_sparks(3, FALSE, defender)
	log_combat(attacker, defender, "Melee attacked with martial-art [src] : Arc Eye")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/shocker/proc/judo_throw(mob/living/carbon/human/attacker, mob/living/defender)
	reset_streak(defender)
	if(!attacker.body_position == STANDING_UP || !defender.body_position == STANDING_UP)
		return MARTIAL_ATTACK_INVALID

	if(defender.pulledby != attacker)
		defender.visible_message("<span class='warning'>[defender] managed to struggle out of [attacker]'s throw.</span>", \
						"<span class='userdanger'>You wrestle out of [attacker]'s grip!</span>")
		return MARTIAL_ATTACK_INVALID
	defender.visible_message("<span class='warning'>[attacker] judo throws [defender] to ground!</span>", \
						"<span class='userdanger'>[attacker] judo throws you to the ground!</span>")
	playsound(get_turf(attacker), 'sound/items/weapons/slam.ogg', 40, TRUE, -1)
	defender.apply_damage(25, STAMINA)
	defender.Knockdown(7 SECONDS, prevent_drop = TRUE)
	log_combat(attacker, defender, "Melee attacked with martial-art [src] : Judo Throw")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/shocker/proc/armbar(mob/living/carbon/human/attacker, mob/living/defender)
	if(defender.body_position == STANDING_UP)
		reset_streak(defender)
		return MARTIAL_ATTACK_INVALID
	defender.visible_message("<span class='warning'>[attacker] puts [defender] into an armbar!</span>", \
						"<span class='userdanger'>[attacker] wrestles you into an armbar!</span>")
	playsound(get_turf(attacker), 'sound/items/weapons/slashmiss.ogg', 40, TRUE, -1)
	if(attacker.body_position == STANDING_UP)
		defender.drop_all_held_items()
	defender.apply_damage(45, STAMINA)
	defender.Knockdown(5 SECONDS)
	combo_refresh() // Flow combos need to refresh the chain.
	log_combat(attacker, defender, "Melee attacked with martial-art [src] : Armbar")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/shocker/proc/wheel_throw(mob/living/carbon/human/attacker, mob/living/defender)
	reset_streak(defender)
	if(defender.body_position == STANDING_UP)
		return MARTIAL_ATTACK_INVALID
	if(attacker.body_position == STANDING_UP)
		defender.visible_message("<span class='warning'>[attacker] raises [defender] over [attacker.p_their()] shoulder, and slams [defender.p_them()] into the ground!</span>", \
							"<span class='userdanger'>[attacker] throws you over [attacker.p_their()] shoulder, slamming you into the ground!</span>")
		playsound(get_turf(attacker), 'sound/effects/magic/tail_swing.ogg', 40, TRUE, -1)
		defender.SpinAnimation(10, 1)
	else
		defender.visible_message("<span class='warning'>[attacker] manages to get a hold onto [defender], and pinning [defender.p_them()] to the ground!</span>", \
							"<span class='userdanger'>[attacker] throws you over [attacker.p_their()] shoulder, slamming you into the ground!</span>")
		playsound(get_turf(attacker), 'sound/items/weapons/slam.ogg', 40, TRUE, -1)
	defender.apply_damage(120, STAMINA)
	defender.Knockdown(15 SECONDS)
	defender.set_confusion(10 SECONDS)
	log_combat(attacker, defender, "Melee attacked with martial-art [src] : Wheel Throw")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/shocker/proc/golden_blast(mob/living/carbon/human/attacker, mob/living/defender)
	reset_streak(defender)
	defender.visible_message("<span class='warning'>[attacker] blasts [defender] with energy, sending [defender.p_them()] to the ground!</span>", \
						"<span class='userdanger'>[attacker] makes strange hand gestures, screams wildly and prods you directly in the chest! You feel the wrath of the GOLDEN BLAST surge through your body! You've been utterly robusted!</span>")
	playsound(get_turf(defender), 'sound/items/weapons/taser.ogg', 55, TRUE, -1)
	playsound(get_turf(defender), 'sound/items/weapons/taserhit.ogg', 55, TRUE, -1)
	defender.SpinAnimation(10, 1)
	do_sparks(5, FALSE, defender)
	attacker.say("GOLDEN BLAST!")
	playsound(get_turf(defender), 'sound/items/weapons/goldenblast.ogg', 60, TRUE, -1)
	defender.apply_damage(120, STAMINA)
	defender.Knockdown(30 SECONDS)
	defender.set_confusion(30 SECONDS)
	//says this causes a full stun not sure if that is something wanted.
	log_combat(attacker, defender, "Melee attacked with martial-art [src] : Golden Blast")
	return MARTIAL_ATTACK_SUCCESS

///
// Combo Adders
///
/datum/martial_art/shocker/help_act(mob/living/attacker, mob/living/defender)
	if(attacker == defender || !can_use(attacker))
		return MARTIAL_ATTACK_INVALID

	add_to_streak("E", defender)
	return check_streak(attacker, defender)

/datum/martial_art/shocker/harm_act(mob/living/attacker, mob/living/defender)
	if(attacker == defender || !can_use(attacker))
		return MARTIAL_ATTACK_INVALID
	add_to_streak("H", defender)

	if(check_streak(attacker, defender) == MARTIAL_ATTACK_SUCCESS)
		return MARTIAL_ATTACK_SUCCESS

	var/picked_hit_type = pick("chops", "slices", "strikes")
	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	defender.apply_damage(10, BRUTE)
	playsound(get_turf(defender), 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	defender.visible_message("<span class='danger'>[attacker] [picked_hit_type] [defender]!</span>", \
					"<span class='userdanger'>[attacker] [picked_hit_type] you!</span>")
	log_combat(attacker, defender, "Melee attacked with [src]")
	return MARTIAL_ATTACK_SUCCESS // If we applied our buffed damage don't allow normal punches.

/datum/martial_art/shocker/disarm_act(mob/living/attacker, mob/living/defender)
	if(attacker == defender || !can_use(attacker))
		return MARTIAL_ATTACK_INVALID

	add_to_streak("D", defender)
	return check_streak(attacker, defender)

/datum/martial_art/shocker/grab_act(mob/living/attacker, mob/living/defender)
	if(attacker == defender || !can_use(attacker))
		return MARTIAL_ATTACK_INVALID

	add_to_streak("G", defender)
	return check_streak(attacker, defender)

/datum/martial_art/shocker/proc/combo_refresh()
	// Since combo is continuing, refresh our timer sorta like DMC.
	if(timerid)
		deltimer(timerid)
	if (display_combos)
		var/mob/living/holder_living = holder.resolve()
		timerid = addtimer(CALLBACK(src, PROC_REF(reset_streak), null, FALSE), combo_timer, TIMER_UNIQUE | TIMER_STOPPABLE)
		holder_living?.hud_used?.combo_display.update_icon_state(streak, combo_timer - 2 SECONDS)

/datum/martial_art/shocker/proc/check_streak(mob/living/attacker, mob/living/defender)
	if(length(streak) < MIN_COMBO)
		combo_refresh()
		return MARTIAL_ATTACK_INVALID
	else
		var/combo_action = combo_moves[streak] // Check for exact matches and fires ability.
		if(combo_action)
			return call(src, combo_action)(attacker, defender)

		for(var/combo in combo_moves) // Check for partial combos so we can refresh our timer.
			if(length(streak) < length(combo) && copytext(combo, 1, (length(streak) + 1)) == streak)
				combo_refresh()
				return MARTIAL_ATTACK_INVALID

		var/last_move = copytext(streak, -1, 0) // Not building to a valid combo reset and carry over combo breaking move.
		reset_streak(defender)
		add_to_streak(last_move, defender)
		return MARTIAL_ATTACK_INVALID

#undef MIN_COMBO

///
// Shock Glove Abilities
///

/datum/action/cooldown/golden_bolt
	name = "Golden Bolt"
	desc = "Use the shock gloves' generated energy to summon an electric bolt. Those struck feel their muscles tense up slowing them down."
	button_icon = 'icons/hud/stances.dmi'
	button_icon_state = "golden_bolt"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS|AB_CHECK_LYING

	var/fired_cooldown = 15 SECONDS
	var/obj/item/hand_item/golden_bolt/hand_bolt

//COMSIG_PROJECTILE_FIRER_BEFORE_FIRE
/datum/action/cooldown/golden_bolt/Grant(mob/grant_to)
	. = ..()
	if(!isnull(owner))
		RegisterSignal(owner, COMSIG_PROJECTILE_FIRER_BEFORE_FIRE, PROC_REF(activate_cooldown))

/datum/action/cooldown/golden_bolt/Remove(mob/remove_from)
	. = ..()
	UnregisterSignal(remove_from, COMSIG_PROJECTILE_FIRER_BEFORE_FIRE)
	clear_hand_bolt()

/datum/action/cooldown/golden_bolt/proc/clear_hand_bolt()
	SIGNAL_HANDLER
	if(!hand_bolt)
		return
	UnregisterSignal(hand_bolt, COMSIG_QDELETING)
	if(QDELETED(hand_bolt))
		hand_bolt = null
	else
		QDEL_NULL(hand_bolt)

/datum/action/cooldown/golden_bolt/Activate(atom/target)
	if(hand_bolt)
		clear_hand_bolt()
		return
	hand_bolt = new /obj/item/hand_item/golden_bolt(owner)
	RegisterSignal(hand_bolt, COMSIG_QDELETING, PROC_REF(clear_hand_bolt))
	if(owner.put_in_active_hand(hand_bolt))
		owner.visible_message("[owner] summons a ball of energy into [owner.p_Their()] hand.",
		"Your hand now crackles with the belt's energy."
		)
	else
		clear_hand_bolt()
	return .

/datum/action/cooldown/golden_bolt/proc/activate_cooldown(datum/source, obj/projectile/bullet, atom/firer, atom/original_target)
	SIGNAL_HANDLER
	if((firer == owner) && istype(bullet, /obj/projectile/golden_bolt))
		StartCooldown(fired_cooldown)

/obj/item/hand_item/golden_bolt
	name = "\improper golden bolt"
	desc = "Take all the energy you collected and fire it at your opponent."
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "Golden_Bolt"
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	inhand_icon_state = "duffelcurse"

/obj/item/hand_item/golden_bolt/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/hand_item/golden_bolt/ranged_interact_with_atom(atom/target, mob/living/user, list/modifiers)
	var/obj/projectile/fired_bolt = new /obj/projectile/golden_bolt(get_turf(user))

	//Shooting Code:
	fired_bolt.original = target
	fired_bolt.fired_from = user
	fired_bolt.firer = user // don't hit ourself that would be really annoying
	fired_bolt.impacted = list(WEAKREF(user) = TRUE) // just to make sure we don't hit the wearer
	fired_bolt.aim_projectile(target, user)
	fired_bolt.fire()
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/projectile/golden_bolt
	name = "Golden Bolt"
	icon_state = "Golden_Bolt"
	hitsound = 'sound/items/weapons/taser3.ogg'
	hitsound_wall = 'sound/items/weapons/taser3.ogg'
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	speed = 1.6
	damage_type = BRUTE
	damage = 0 // Meant to slow does no damage
	armour_penetration = 100 // Do I need this?

/obj/projectile/golden_bolt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/parriable_projectile)

/obj/projectile/golden_bolt/fire(angle, atom/direct_target)
	if(firer && ishuman(firer))
		var/mob/living/carbon/human/ryu = firer
		if(prob(10))
			icon_state = "hadouken"
			ryu.say("Hadouken!!!")
		else
			ryu.say("Golden Bolt!!!")
	return ..()

/obj/projectile/golden_bolt/impact(atom/A)
	def_zone = BODY_ZONE_CHEST
	return ..()

/obj/projectile/golden_bolt/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if(. == BULLET_ACT_BLOCK)
		return .

	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		try_slow(human_target)

/obj/projectile/golden_bolt/proc/try_slow(mob/living/carbon/human/living_target)
	living_target.apply_status_effect(/datum/status_effect/judo_slow)
	playsound(living_target, 'sound/items/weapons/taserhit.ogg', clamp(vol_by_damage() + (suppressed ? 0 : 20), 0, 100), TRUE, -1,  mixer_channel = mixer_channel)
	living_target.visible_message("<b>[living_target] looks like they are struggling to move.",
	span_userdanger("Your muscles are extremely tense making moving more difficult.")
	)
