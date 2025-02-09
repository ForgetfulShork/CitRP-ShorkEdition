/datum/trait/kintype
	allowed_species = list(SPECIES_SHADEKIN)
	var/color = BLUE_EYES
	name = "Shadekin Blue Adaptation"
	desc = "Makes your shadekin adapted as a Blue eyed kin! This gives you good energy regeneration in darkness, decreased regeneration in the light and unchanged health!"
	cost = 0
	custom_only = FALSE
	var_changes = list(
		"total_health" = 100,
		"energy_light" = 0.5,
		"energy_dark" = 1,
		"unarmed_types" = list(
			/datum/unarmed_attack/stomp,
			/datum/unarmed_attack/kick,
			/datum/unarmed_attack/claws/shadekin,
			/datum/unarmed_attack/bite/sharp/shadekin,
			/datum/unarmed_attack/shadekinharmbap,
		)
	)

/datum/trait/kintype/red
	name = "Shadekin Red Adaptation"
	color =	RED_EYES
	desc = "Makes your shadekin adapted as a Red eyed kin! This gives you minimal energy regeneration in darkness, good regeneration in the light and increased health!"
	var_changes = list(
		"total_health" = 200,
		"energy_light" = 1,
		"energy_dark" = 0.25,
		"unarmed_types" = list(
			/datum/unarmed_attack/stomp,
			/datum/unarmed_attack/kick,
			/datum/unarmed_attack/claws/shadekin,
			/datum/unarmed_attack/bite/sharp/shadekin,
			/datum/unarmed_attack/shadekinharmbap
		)
	)

/datum/trait/kintype/purple
	name = "Shadekin Purple Adaptation"
	color = PURPLE_EYES
	desc = "Makes your shadekin adapted as a Purple eyed kin! This gives you very good energy regeneration in darkness, minor degeneration in the light and increased health!"
	var_changes = list(
		"total_health" = 150,
		"energy_light" = -0.5,
		"energy_dark" = 1.5,
		"unarmed_types" = list(
			/datum/unarmed_attack/stomp,
			/datum/unarmed_attack/kick,
			/datum/unarmed_attack/claws/shadekin,
			/datum/unarmed_attack/bite/sharp/shadekin,
			/datum/unarmed_attack/shadekinharmbap
		)
	)

/datum/trait/kintype/yellow
	name = "Shadekin Yellow Adaptation"
	color = YELLOW_EYES
	desc = "Makes your shadekin adapted as a Yellow eyed kin! This gives you the highest energy regeneration in darkness, high degeneration in the light and unchanged health!"
	var_changes = list(
		"total_health" = 100,
		"energy_light" = -1,
		"energy_dark" = 3,
		"unarmed_types" = list(
			/datum/unarmed_attack/stomp,
			/datum/unarmed_attack/kick,
			/datum/unarmed_attack/claws/shadekin,
			/datum/unarmed_attack/bite/sharp/shadekin,
			/datum/unarmed_attack/shadekinharmbap
		)
	)

/datum/trait/kintype/green
	name = "Shadekin Green Adaptation"
	color = GREEN_EYES
	desc = "Makes your shadekin adapted as a Green eyed kin! This gives you high energy regeneration in darkness, minor regeneration in the light and unchanged health!"
	var_changes = list(
		"total_health" = 100,
		"energy_light" = 0.25,
		"energy_dark" = 2,
		"unarmed_types" = list(
			/datum/unarmed_attack/stomp,
			/datum/unarmed_attack/kick,
			/datum/unarmed_attack/claws/shadekin,
			/datum/unarmed_attack/bite/sharp/shadekin,
			/datum/unarmed_attack/shadekinharmbap
		)
	)

/datum/trait/kintype/orange
	name = "Shadekin Orange Adaptation"
	color = ORANGE_EYES
	desc = "Makes your shadekin adapted as a Orange eyed kin! This gives you good energy regeneration in darkness, small degeneration in the light and increased health!"
	var_changes = list(
		"total_health" = 175,
		"energy_light" = -0.5,
		"energy_dark" = 1,
		"unarmed_types" = list(
			/datum/unarmed_attack/stomp,
			/datum/unarmed_attack/kick,
			/datum/unarmed_attack/claws/shadekin,
			/datum/unarmed_attack/bite/sharp/shadekin,
			/datum/unarmed_attack/shadekinharmbap
		)
	)

/datum/trait/kintype/apply(datum/species/shadekin/S, mob/living/carbon/human/H)
	if (istype(S))
		..(S,H)
		if(color) //Sanity check to see if they're actually a shadekin, otherwise just don't do anything. They shouldn't be able to spawn with the trait.
			S.kin_type = color
			switch(color)
				if(BLUE_EYES)
					H.shapeshifter_set_eye_color("0000FF")
				if(RED_EYES)
					H.shapeshifter_set_eye_color("FF0000")
				if(GREEN_EYES)
					H.shapeshifter_set_eye_color("00FF00")
				if(PURPLE_EYES)
					H.shapeshifter_set_eye_color("FF00FF")
				if(YELLOW_EYES)
					H.shapeshifter_set_eye_color("FFFF00")
				if(ORANGE_EYES)
					H.shapeshifter_set_eye_color("FFA500")


/datum/unarmed_attack/shadekinharmbap
	attack_name = "syphon strike"
	attack_verb = list("hit", "clawed", "slashed", "scratched")
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	shredding = FALSE

/datum/unarmed_attack/shadekinharmbap/apply_effects(mob/living/carbon/human/shadekin/user, mob/living/carbon/human/target, armour, attack_damage, zone)
	..()
	if(user == target) //Prevent self attack to gain energy
		return
	var/obj/item/organ/internal/brain/shadekin/shade_organ = user.internal_organs_by_name[O_BRAIN]
	if(!istype(shade_organ))
		return
	shade_organ.dark_energy = clamp(shade_organ.dark_energy + attack_damage,0,shade_organ.max_dark_energy) //Convert Damage done to Energy Gained
